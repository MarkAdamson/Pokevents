package com.markadamson83.pokeventsadmin.presentation

import android.app.Application
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.markadamson83.pokeventsadmin.domain.Event
import com.markadamson83.pokeventsadmin.framework.Interactors
import com.markadamson83.pokeventsadmin.framework.PEAViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

enum class Status {
    NONE,
    LOADING,
    SUCCESS,
    ERROR,
}

class Result<T>(val status: Status, val value: T? = null, val message: String? = null){
    companion object {
        fun <T> clear(): Result<T> {
            return Result(Status.NONE)
        }
        fun <T> success(value: T?): Result<T> {
            return Result(Status.SUCCESS, value)
        }
        fun <T> error(message: String?): Result<T> {
            return Result(Status.ERROR, message = message)
        }
        fun <T> loading(exState: Result<T>?): Result<T> {
            return Result(Status.LOADING, exState?.value, exState?.message)
        }
    }
}

enum class SaveStatus {
    NEW,
    CLEAN,
    DIRTY,
    SAVING,
    SAVED,
    CANCELLED
}

class MainViewModel(application: Application, interactors: Interactors)
    : PEAViewModel(application, interactors) {

    val events: MutableLiveData<Result<Map<String, Event>>> = MutableLiveData()
    val event: MutableLiveData<Result<Event>> = MutableLiveData()
    val eventSaveStatus: MutableLiveData<SaveStatus> = MutableLiveData()

    fun getEvents() {
        events.value = Result.loading(events.value)
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                try {
                    events.postValue(Result.success(interactors.getEvents()))
                } catch (e: Exception) {
                    events.postValue(Result.error(e.message))
                }
            }
        }
    }

    fun getEvent(id: String) {
        event.value = Result.loading(event.value)
        eventSaveStatus.value = null

        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                try {
                    event.postValue(Result.success(interactors.getEvents()[id]))
                    eventSaveStatus.postValue(SaveStatus.CLEAN)
                } catch (e: Exception) {
                    events.postValue(Result.error(e.message))
                }
            }
        }
    }

    fun newEvent() {
        event.value = Result.loading(event.value)
        eventSaveStatus.value = null

        event.value = Result.success(Event())
        eventSaveStatus.value = SaveStatus.NEW
    }

    private fun validateEvent() {
        val e = event.value!!.value!!

        if (e.title.isBlank())
            throw RuntimeException("Please enter a title")

        if (e.description.isBlank())
            throw RuntimeException("Please enter a description")

        if (e.species.isBlank())
            throw RuntimeException("Please enter the species")

        if (e.locations.isEmpty())
            throw RuntimeException("Please enter at least one location")

        if (e.games.isEmpty())
            throw RuntimeException("Please select at least one game")
    }

    fun updateEvent(id: String) {
        validateEvent()

        val ss = eventSaveStatus.value

        eventSaveStatus.value = SaveStatus.SAVING

        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                try {
                    interactors.updateEvent(id, event.value!!.value!!)
                    eventSaveStatus.postValue(SaveStatus.SAVED)
                } catch (ex: Exception) {
                    eventSaveStatus.postValue(ss)
                }
            }
        }
    }

    fun createEvent() {
        validateEvent()

        val ss = eventSaveStatus.value

        eventSaveStatus.value = SaveStatus.SAVING

        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                try {
                    interactors.createEvent(event.value!!.value!!)
                    eventSaveStatus.postValue(SaveStatus.SAVED)
                } catch (ex: Exception) {
                    eventSaveStatus.postValue(ss)
                }
            }
        }
    }

    fun deleteEvent(id: String) {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                interactors.deleteEvent(id)
                events.postValue(Result.success(events.value!!.value!!.filter { entry -> entry.key != id }))
            }
        }
    }
}