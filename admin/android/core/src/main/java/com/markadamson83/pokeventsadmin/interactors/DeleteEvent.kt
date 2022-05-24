package com.markadamson83.pokeventsadmin.interactors

import com.markadamson83.pokeventsadmin.data.EventsRepository

class DeleteEvent(private val eventsRepository: EventsRepository) {
    operator fun invoke(id: String) =
        eventsRepository.deleteEvent(id)
}