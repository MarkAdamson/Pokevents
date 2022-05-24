package com.markadamson83.pokeventsadmin.interactors

import com.markadamson83.pokeventsadmin.data.EventsRepository
import com.markadamson83.pokeventsadmin.domain.Event

class CreateEvent(private val eventsRepository: EventsRepository) {
    operator fun invoke(event: Event): String =
        eventsRepository.createEvent(event)
}