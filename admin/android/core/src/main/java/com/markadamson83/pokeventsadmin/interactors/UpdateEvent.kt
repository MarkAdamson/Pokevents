package com.markadamson83.pokeventsadmin.interactors

import com.markadamson83.pokeventsadmin.data.EventsRepository
import com.markadamson83.pokeventsadmin.domain.Event

class UpdateEvent(private val eventsRepository: EventsRepository) {
    operator fun invoke(id: String, event: Event) =
        eventsRepository.updateEvent(id, event)
}