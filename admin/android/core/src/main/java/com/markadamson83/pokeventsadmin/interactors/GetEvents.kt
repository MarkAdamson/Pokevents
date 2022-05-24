package com.markadamson83.pokeventsadmin.interactors

import com.markadamson83.pokeventsadmin.data.EventsRepository
import com.markadamson83.pokeventsadmin.domain.Event

class GetEvents(private val eventsRepository: EventsRepository) {
    operator fun invoke(): Map<String,Event> =
        eventsRepository.getEvents()
}