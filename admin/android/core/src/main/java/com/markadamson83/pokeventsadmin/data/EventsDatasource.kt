package com.markadamson83.pokeventsadmin.data

import com.markadamson83.pokeventsadmin.domain.Event

interface EventsDatasource {
    fun getEvents(): Map<String,Event>
    fun createEvent(event: Event): String
    fun updateEvent(id: String, event: Event)
    fun deleteEvent(id: String)
}