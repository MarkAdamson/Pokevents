package com.markadamson83.pokeventsadmin.ui.navigation

sealed class Screen(val route: String) {
    object EventsScreen : Screen("events_screen")
    object EventScreen : Screen("event_screen")

    fun <T>withArgs(vararg args: T): String {
        return buildString {
            append(route)
            args.forEach { arg ->
                append("?eventId=$arg")
            }
        }
    }
}