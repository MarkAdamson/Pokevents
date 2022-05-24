package com.markadamson83.pokeventsadmin.framework

import com.markadamson83.pokeventsadmin.interactors.*

data class Interactors(
    val getEvents: GetEvents,
    val createEvent: CreateEvent,
    val updateEvent: UpdateEvent,
    val deleteEvent: DeleteEvent,
)
