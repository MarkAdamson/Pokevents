package com.markadamson83.pokeventsadmin.framework

import android.app.Application
import com.markadamson83.pokeventsadmin.data.EventsRepository
import com.markadamson83.pokeventsadmin.interactors.*

class PEAApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        val eventsRepository = EventsRepository(AWSEventsDatasource())

        PEAViewModelFactory.inject(
            this,
            Interactors(
                GetEvents(eventsRepository),
                CreateEvent(eventsRepository),
                UpdateEvent(eventsRepository),
                DeleteEvent(eventsRepository),
            )
        )
    }
}