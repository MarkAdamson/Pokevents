package com.markadamson83.pokeventsadmin.ui

import android.annotation.SuppressLint
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.runtime.*
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.SwipeRefreshState
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState
import com.markadamson83.pokeventsadmin.R
import com.markadamson83.pokeventsadmin.domain.Event
import com.markadamson83.pokeventsadmin.domain.Region
import com.markadamson83.pokeventsadmin.presentation.MainViewModel
import com.markadamson83.pokeventsadmin.presentation.Status
import com.markadamson83.pokeventsadmin.ui.navigation.Screen
import com.markadamson83.pokeventsadmin.ui.theme.*
import java.text.SimpleDateFormat
import java.util.*

@Composable
fun EventsScreen(viewModel: MainViewModel, navController: NavController) {
    val events = viewModel.events.observeAsState()
    LaunchedEffect(Unit) {
        viewModel.getEvents()
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text(stringResource(R.string.app_name))
                })
        },
        floatingActionButton = {
            FloatingActionButton(
                modifier = Modifier.padding(24.dp),
                onClick = { navController.navigate(Screen.EventScreen.route) },
            ) {
                Icon(imageVector = Icons.Default.Add, "")
            }
        }
    ) { paddingValues ->
        Box(
            Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            val swipeRefreshState = rememberSwipeRefreshState(isRefreshing = false)

            if (swipeRefreshState.isRefreshing) {
                if (events.value?.message != null)
                    ErrorContent(viewModel, swipeRefreshState, events.value?.message)
                else if (events.value?.value != null)
                    EventsContent(viewModel, navController, swipeRefreshState, events)
            } else
                when (events.value?.status) {
                    null, Status.NONE, Status.LOADING ->
                        CircularProgressIndicator(Modifier.align(Alignment.Center))
                    Status.ERROR ->
                        ErrorContent(viewModel, swipeRefreshState, events.value?.message)
                    Status.SUCCESS ->
                        EventsContent(viewModel, navController, swipeRefreshState, events)
                }
        }
    }
}


@Composable
internal fun ErrorContent(viewModel: MainViewModel, swipeRefreshState: SwipeRefreshState, error: String?) {
    SwipeRefresh(
        state = swipeRefreshState, // rememberSwipeRefreshState(events.value!!.status == Status.LOADING),
        onRefresh = { viewModel.getEvents() }
    ) {
        Box(
            Modifier
                .fillMaxSize()
                .verticalScroll(rememberScrollState())) {
            error?.let { msg ->
                Text(
                    msg,
                    Modifier.align(Alignment.Center)
                )
            }
        }
    }
}

@OptIn(ExperimentalFoundationApi::class)
@Composable
internal fun EventsContent(viewModel: MainViewModel, navController: NavController, swipeRefreshState: SwipeRefreshState,
                           events: State<com.markadamson83.pokeventsadmin.presentation.Result<Map<String, Event>>?>) {
    val colourMap = remember { EnumMap(Region.values().associateWith {
        when (it!!) {
            Region.WORLDWIDE -> Worldwide
            Region.AMERICA -> America
            Region.JAPAN -> Japan
            Region.EUROPE -> Europe
            Region.OTHER -> Other
        }
    })}

    var deleting: String? by remember { mutableStateOf(null) }

    deleting?.let {
        AlertDialog(
            onDismissRequest = { deleting = null },
            title = { Text("Delete Event?") },
            text = { Text("Are you sure you want to delete the event \"${events.value!!.value!![it]?.title}\"?") },
            confirmButton = {
                TextButton(onClick = {
                    viewModel.deleteEvent(it)
                    deleting = null
                }) {
                    Text(stringResource(R.string.yes))
                }
            },
            dismissButton = {
                TextButton(onClick = {
                    deleting = null
                }) {
                    Text(stringResource(R.string.no))
                }
            }
        )
    }

    val sortedEvents = remember(events) {
        events.value?.value?.entries?.sortedBy { it.value.startDate }?.groupBy { it.value.region }
    }

    SwipeRefresh(
        state = swipeRefreshState, // rememberSwipeRefreshState(events.value!!.status == Status.LOADING),
        onRefresh = { viewModel.getEvents() }
    ) {
        LazyColumn(
            Modifier
                .fillMaxSize()
        ) {

            sortedEvents?.let { events ->
                events.keys.forEach{ region ->
                    stickyHeader {
                        Surface(
                            Modifier.fillMaxWidth(),
                            color = colourMap[region]!!
                        ) {
                            Text(region.label,
                                modifier = Modifier.padding(4.dp),
                                style = MaterialTheme.typography.caption)
                        }
                    }

                    items(events[region]!!) { event ->
                        Column(
                            Modifier.combinedClickable(
                                onClick = {
                                    navController.navigate(Screen.EventScreen.withArgs(event.key))
                                },
                                onLongClick = {
                                    deleting = event.key
                                }
                            )
                        ) {
                            Row(Modifier.padding(16.dp), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                                DateDisplay(event.value.startDate)
                                Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
                                    Text(event.value.title)
                                    Text(event.value.games.joinToString("/") { it.label }, style = MaterialTheme.typography.caption)
                                }
                            }
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

@SuppressLint("SimpleDateFormat")
@Composable
internal fun DateDisplay(date: Date, modifier: Modifier = Modifier) {
    val dateFormat = remember { SimpleDateFormat("MMM yyyy") }
    Column(modifier, horizontalAlignment = Alignment.CenterHorizontally) {
        Text(date.date.toString(), style = MaterialTheme.typography.h4)
        Text(dateFormat.format(date), style = MaterialTheme.typography.caption)
    }
}

@Preview
@Composable
fun DatePreview() {
    DateDisplay(Date())
}