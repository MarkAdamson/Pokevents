package com.markadamson83.pokeventsadmin.data

import com.markadamson83.pokeventsadmin.domain.Event

class EventsRepository(private val dsEvents: EventsDatasource) {
    fun getEvents(): Map<String, Event> =
        dsEvents.getEvents()
    fun createEvent(event: Event): String =
        dsEvents.createEvent(event)
    fun updateEvent(id: String, event: Event) =
        dsEvents.updateEvent(id, event)
    fun deleteEvent(id: String) =
        dsEvents.deleteEvent(id)
}