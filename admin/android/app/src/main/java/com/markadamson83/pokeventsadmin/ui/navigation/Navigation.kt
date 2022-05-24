package com.markadamson83.pokeventsadmin.ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.markadamson83.pokeventsadmin.presentation.MainViewModel
import com.markadamson83.pokeventsadmin.ui.EventScreen
import com.markadamson83.pokeventsadmin.ui.EventsScreen

@Composable
fun Navigation(viewModel: MainViewModel) {
    val navController = rememberNavController()
    NavHost(navController = navController, startDestination = Screen.EventsScreen.route) {
        composable(route = Screen.EventsScreen.route) {
            EventsScreen(viewModel = viewModel, navController = navController)
        }
        composable(
            route = Screen.EventScreen.route + "?eventId={eventId}",
            arguments = listOf(
                navArgument("eventId") {
                    nullable = true
                }
            )
        ) { entry ->
            EventScreen(
                viewModel = viewModel,
                navController = navController,
                eventId = entry.arguments?.getString("eventId")
            )
        }
    }
}