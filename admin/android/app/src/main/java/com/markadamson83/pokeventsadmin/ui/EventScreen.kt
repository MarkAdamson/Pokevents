package com.markadamson83.pokeventsadmin.ui

import android.app.DatePickerDialog
import android.util.Log
import android.widget.DatePicker
import android.widget.Toast
import androidx.activity.OnBackPressedCallback
import androidx.activity.OnBackPressedDispatcher
import androidx.activity.compose.LocalOnBackPressedDispatcherOwner
import androidx.compose.foundation.*
import androidx.compose.foundation.interaction.InteractionSource
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.PressInteraction
import androidx.compose.foundation.interaction.collectIsPressedAsState
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material.ripple.rememberRipple
import androidx.compose.runtime.*
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalTextInputService
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.TextRange
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.google.accompanist.flowlayout.FlowRow
import com.google.accompanist.flowlayout.SizeMode
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState
import com.markadamson83.pokeventsadmin.R
import com.markadamson83.pokeventsadmin.domain.Event
import com.markadamson83.pokeventsadmin.domain.Game
import com.markadamson83.pokeventsadmin.domain.Gender
import com.markadamson83.pokeventsadmin.domain.Region
import com.markadamson83.pokeventsadmin.presentation.MainViewModel
import com.markadamson83.pokeventsadmin.presentation.Result
import com.markadamson83.pokeventsadmin.presentation.SaveStatus
import com.markadamson83.pokeventsadmin.presentation.Status
import kotlinx.coroutines.delay
import java.util.*

@Composable
fun EventScreen(viewModel: MainViewModel, navController: NavController, eventId: String?) {
    val event = viewModel.event.observeAsState()
    val saveStatus = viewModel.eventSaveStatus.observeAsState()

    LaunchedEffect(Unit) {
        if (eventId == null) viewModel.newEvent() else viewModel.getEvent(eventId)
    }

    if (EnumSet.of(SaveStatus.SAVED, SaveStatus.CANCELLED).contains(saveStatus.value)) {
        viewModel.eventSaveStatus.value = null
        navController.navigateUp()
    }

    var saveDialog by remember { mutableStateOf(false) }
    if (saveDialog)
        AlertDialog(
            onDismissRequest = {
                saveDialog = false
            },
            title = {
                Text("Save Changes?")
            },
            text = {
                Text("There are unsaved changes - would you like to save them now?")
            },
            buttons = {
                Row(
                    Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 8.dp), horizontalArrangement = Arrangement.End ) {
                    val context = LocalContext.current
                    TextButton(onClick = {
                        try { eventId?.let { viewModel.updateEvent(it) } ?: run { viewModel.createEvent() } }
                        catch (e: Exception) { Toast.makeText(context, e.message, Toast.LENGTH_SHORT).show() }
                        saveDialog = false
                    }){
                        Text(stringResource(R.string.yes))
                    }
                    TextButton(onClick = {
                            viewModel.eventSaveStatus.value = SaveStatus.CANCELLED
                    }) {
                        Text(stringResource(R.string.no))
                    }
                    TextButton(onClick = {
                            saveDialog = false
                    }) {
                        Text(stringResource(android.R.string.cancel))
                    }
                }
            }
        )

    fun onBack() {
        Log.d("EventScreen", "onBackPressed")
        when(saveStatus.value) {
            null, SaveStatus.CLEAN -> navController.navigateUp()
            SaveStatus.NEW, SaveStatus.DIRTY -> saveDialog = true
            else -> {}
        }
    }

    BackPressHandler { onBack() }

    fun editEvent(doUpdate: (Event) -> Unit) {
        val e = event.value!!.value!!
        doUpdate(e)
        viewModel.event.value = Result.success(e)
        viewModel.eventSaveStatus.value = SaveStatus.DIRTY
    }

    Scaffold(
        topBar = {


            TopAppBar(
                title = {
                    Text("${eventId?.let { "Edit" }?:run { "New" }} Event...")
                },
                navigationIcon = {
                    IconButton(onClick = { onBack() }) {
                        Icon(Icons.Filled.ArrowBack, contentDescription = null)
                    }
                },
                actions = {
                    when (saveStatus.value) {
                        SaveStatus.SAVING -> CircularProgressIndicator(color = MaterialTheme.colors.onPrimary)
                        else -> {
                            val context = LocalContext.current
                            IconButton(
                                onClick = {
                                    try { eventId?.let { viewModel.updateEvent(it) } ?: run { viewModel.createEvent() } }
                                    catch (e: Exception) { Toast.makeText(context, e.message, Toast.LENGTH_SHORT).show() }
                                },
                                enabled = EnumSet.of(SaveStatus.NEW, SaveStatus.DIRTY).contains(saveStatus.value)
                            ) {
                                Icon(Icons.Filled.Done, contentDescription = stringResource(R.string.save))
                            }
                        }
                    }
                })
        }
    ) { paddingValues ->
        Box(
            Modifier
                .fillMaxSize()
                .padding(bottom = paddingValues.calculateBottomPadding())
        ) {
            when (event.value?.status) {
                null, Status.NONE, Status.LOADING ->
                    CircularProgressIndicator(Modifier.align(Alignment.Center))
                Status.ERROR ->
                    SwipeRefresh(
                        state = rememberSwipeRefreshState(isRefreshing = event.value!!.status == Status.LOADING),
                        onRefresh = {viewModel.getEvent(eventId!!)}
                    ) {
                        Box(
                            Modifier
                                .fillMaxSize()
                                .verticalScroll(rememberScrollState())) {
                            event.value?.message?.let { msg -> Text(msg, Modifier.align(Alignment.Center)) }
                        }
                    }
                Status.SUCCESS -> {
                    Column(
                        Modifier
                            .verticalScroll(rememberScrollState())
                            .fillMaxSize()
                            .padding(16.dp),
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        RegionDropDown(event.value!!.value!!.region, saveStatus.value != SaveStatus.SAVING) { region ->
                            editEvent { e -> e.region = region }
                        }
                        TextField(
                            modifier = Modifier.fillMaxWidth(),
                            value = event.value!!.value!!.title,
                            onValueChange = { editEvent{ e-> e.title = it } },
                            label = { Text("Title")},
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            singleLine = true,
                            keyboardOptions = KeyboardOptions(
                                capitalization = KeyboardCapitalization.Words,
                                imeAction = ImeAction.Next
                            )
                        )
                        TextField(
                            modifier = Modifier.fillMaxWidth(),
                            value = event.value!!.value!!.description,
                            onValueChange = { editEvent{ e-> e.description = it } },
                            label = { Text("Description") },
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            keyboardOptions = KeyboardOptions(
                                capitalization = KeyboardCapitalization.Sentences
                            )
                        )
                        TextField(
                            modifier = Modifier.fillMaxWidth(),
                            value = event.value!!.value!!.kind?: "",
                            onValueChange = { editEvent{ e-> e.kind = it } },
                            label = { Text("Type") },
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            singleLine = true,
                            keyboardOptions = KeyboardOptions(
                                capitalization = KeyboardCapitalization.Words,
                                imeAction = ImeAction.Next
                            )
                        )
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            DatePicker(modifier = Modifier.weight(1f), event.value!!.value!!.startDate, "Start Date", saveStatus.value != SaveStatus.SAVING, false) { date ->
                                editEvent { e -> e.startDate = date!! }
                            }
                            DatePicker(modifier = Modifier.weight(1f), event.value!!.value!!.endDate, "End Date", saveStatus.value != SaveStatus.SAVING, true) { date ->
                                editEvent { e -> e.endDate = date }
                            }
                        }
                        StringListEditor(
                            label = "Locations",
                            strings = event.value!!.value!!.locations,
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            onAdd = { location ->
                                editEvent { e ->
                                    e.locations.add(location)
                                }
                            },
                            onEdit = { index, location ->
                                editEvent { e ->
                                    e.locations[index] = location
                                }
                            },
                            onDelete = { index ->
                                editEvent { e ->
                                    e.locations.removeAt(index)
                                }
                            }
                        )
                        TextField(
                            modifier = Modifier.fillMaxWidth(),
                            value = event.value!!.value!!.species,
                            onValueChange = { editEvent{ e-> e.species = it } },
                            label = { Text("Species") },
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            singleLine = true,
                            keyboardOptions = KeyboardOptions(
                                capitalization = KeyboardCapitalization.Words,
                                imeAction = ImeAction.Next
                            )
                        )
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            TextField(
                                modifier = Modifier.weight(1f),
                                value = event.value!!.value!!.ball?: "",
                                onValueChange = { editEvent{ e->
                                    if (it.isNotBlank()) e.ball = it else e.ball = null
                                }},
                                label = { Text("Ball") },
                                enabled = saveStatus.value != SaveStatus.SAVING,
                                singleLine = true,
                                keyboardOptions = KeyboardOptions(
                                    capitalization = KeyboardCapitalization.Words,
                                    imeAction = ImeAction.Next
                                )
                            )
                            TextField(
                                modifier = Modifier.weight(1f),
                                value = event.value!!.value!!.level?.toString()?: "",
                                onValueChange = {
                                    if (it.isBlank() && event.value!!.value!!.level != null)
                                        editEvent{ e-> e.level = null }
                                    else {
                                        val newLevel = it.toIntOrNull() ?: event.value!!.value!!.level
                                        if (newLevel == event.value!!.value!!.level || newLevel!! < 1 || newLevel > 100)
                                            return@TextField

                                        editEvent{ e-> e.level = newLevel }
                                    }
                                },
                                label = { Text("Level") },
                                enabled = saveStatus.value != SaveStatus.SAVING,
                                singleLine = true,
                                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number, imeAction = ImeAction.Next),
                                trailingIcon = {
                                    Icon(Icons.Filled.Cancel,"Clear",
                                        Modifier.clickable { if (event.value!!.value!!.level != null) editEvent{ e-> e.level = null }},
                                    )
                                }
                            )
                            GenderDropDown(
                                modifier = Modifier.weight(1f),
                                selectedGender = event.value!!.value!!.gender,
                                enabled = saveStatus.value != SaveStatus.SAVING,
                                onChange = { editEvent{ e -> e.gender = it}}
                            )
                        }
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            LabelledCheckBox(
                                modifier = Modifier.weight(1f),
                                label = stringResource(R.string.shiny),
                                checked = event.value!!.value!!.shiny,
                                onCheckedChange = { editEvent { e -> e.shiny = it }})
                            LabelledCheckBox(
                                modifier = Modifier.weight(1f),
                                label = stringResource(R.string.gigantamax),
                                checked = event.value!!.value!!.gigantamax,
                                onCheckedChange = { editEvent { e -> e.gigantamax = it }})
                        }
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            TextField(
                                modifier = Modifier.weight(2f),
                                value = event.value!!.value!!.ot?: "",
                                onValueChange = { editEvent{ e->
                                    if (it.isNotBlank()) e.ot = it else e.ot = null
                                }},
                                label = { Text("OT") },
                                enabled = saveStatus.value != SaveStatus.SAVING,
                                singleLine = true,
                                keyboardOptions = KeyboardOptions(
                                    capitalization = KeyboardCapitalization.Words,
                                    imeAction = ImeAction.Next
                                )
                            )
                            TextField(
                                modifier = Modifier.weight(1f),
                                value = event.value!!.value!!.tid?: "",
                                onValueChange = { editEvent{ e->
                                    if (it.isNotBlank()) e.tid = it else e.tid = null
                                }},
                                label = { Text("ID") },
                                enabled = saveStatus.value != SaveStatus.SAVING,
                                singleLine = true,
                                keyboardOptions = KeyboardOptions(
                                    imeAction = ImeAction.Next
                                )
                            )
                        }
                        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            TextField(
                                modifier = Modifier.weight(1f),
                                value = event.value!!.value!!.ability?: "",
                                onValueChange = { editEvent{ e->
                                    if (it.isNotBlank()) e.ability = it else e.ability = null
                                }},
                                label = { Text("Ability") },
                                enabled = saveStatus.value != SaveStatus.SAVING,
                                singleLine = true,
                                keyboardOptions = KeyboardOptions(
                                    capitalization = KeyboardCapitalization.Words,
                                    imeAction = ImeAction.Next
                                )
                            )
                            TextField(
                                modifier = Modifier.weight(1f),
                                value = event.value!!.value!!.nature?: "",
                                onValueChange = { editEvent{ e->
                                    if (it.isNotBlank()) e.nature = it else e.nature = null
                                }},
                                label = { Text("Nature") },
                                enabled = saveStatus.value != SaveStatus.SAVING,
                                singleLine = true,
                                keyboardOptions = KeyboardOptions(
                                    capitalization = KeyboardCapitalization.Words,
                                    imeAction = ImeAction.Next
                                )
                            )
                        }
                        TextField(
                            modifier = Modifier.fillMaxWidth(),
                            value = event.value!!.value!!.holdItem?: "",
                            onValueChange = { editEvent{ e->
                                if (it.isNotBlank()) e.holdItem = it else e.holdItem = null
                            }},
                            label = { Text("Hold Item") },
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            singleLine = true,
                            keyboardOptions = KeyboardOptions(
                                capitalization = KeyboardCapitalization.Words,
                                imeAction = ImeAction.Next
                            )
                        )
                        StringListEditor(
                            label = "Moves",
                            strings = event.value!!.value!!.moves,
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            onAdd = { move ->
                                editEvent { e ->
                                    e.moves.add(move)
                                }
                            },
                            onEdit = { index, move ->
                                editEvent { e ->
                                    e.moves[index] = move
                                }
                            },
                            onDelete = { index ->
                                editEvent { e ->
                                    e.moves.removeAt(index)
                                }
                            },
                            max = 4
                        )
                        StringListEditor(
                            label = "Marks",
                            strings = event.value!!.value!!.marks,
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            onAdd = { mark ->
                                editEvent { e ->
                                    e.marks.add(mark)
                                }
                            },
                            onEdit = { index, mark ->
                                editEvent { e ->
                                    e.marks[index] = mark
                                }
                            },
                            onDelete = { index ->
                                editEvent { e ->
                                    e.marks.removeAt(index)
                                }
                            }
                        )
                        StringListEditor(
                            label = "Ribbons",
                            strings = event.value!!.value!!.ribbons,
                            enabled = saveStatus.value != SaveStatus.SAVING,
                            onAdd = { ribbon ->
                                editEvent { e ->
                                    e.ribbons.add(ribbon)
                                }
                            },
                            onEdit = { index, ribbon ->
                                editEvent { e ->
                                    e.ribbons[index] = ribbon
                                }
                            },
                            onDelete = { index ->
                                editEvent { e ->
                                    e.ribbons.removeAt(index)
                                }
                            }
                        )
                        Outlined(label = "Games") {
                            FlowRow(
                                Modifier.fillMaxWidth(),
                                SizeMode.Expand,
                            ) {
                                EnumSet.allOf(Game::class.java).forEach { game ->
                                    LabelledCheckBox(
                                        checked = event.value!!.value!!.games.contains(game),
                                        onCheckedChange = {
                                            editEvent { e ->
                                                if (it) e.games.add(game) else e.games.remove(game)
                                            }
                                        }, label = game.label)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


@Composable
internal fun RegionDropDown(selectedRegion: Region, enabled: Boolean, onChange: (region: Region) -> Unit) {
    var expanded by remember { mutableStateOf(false) }
    val regions = Region.values()

    val icon = if (expanded)
        Icons.Filled.ArrowDropUp //it requires androidx.compose.material:material-icons-extended
    else
        Icons.Filled.ArrowDropDown

    val source = remember { MutableInteractionSource() }

    if (source.collectClickAsState().value)
        expanded = !expanded

    Box(modifier = Modifier
        .fillMaxSize()
        .wrapContentSize(Alignment.TopStart)) {
        TextField(
            modifier = Modifier.fillMaxWidth(),
            label = { Text("Region") },
            value = selectedRegion.label,
            onValueChange = {},
            trailingIcon = {
                Icon(icon,"contentDescription",
                    Modifier.clickable { expanded = !expanded })
            },
            interactionSource = source,
            readOnly = true,
            enabled = enabled
        )
        DropdownMenu(
            expanded = enabled && expanded,
            onDismissRequest = { expanded = false },
            modifier = Modifier.fillMaxWidth()
        ) {
            regions.forEach { region ->
                DropdownMenuItem(onClick = {
                    onChange(region)
                    expanded = false
                }) {
                    Text(region.label)
                }
            }
        }
    }
}

@Composable
internal fun DatePicker(modifier: Modifier = Modifier, currentDate: Date?, label: String, enabled: Boolean, nullable: Boolean, onChange: (date: Date?) -> Unit) {
    val context = LocalContext.current

    // Initializing a Calendar
    val calendar = Calendar.getInstance()

    var dateString by remember { mutableStateOf("") }

    if (currentDate != null) {
        calendar.time = currentDate
        dateString = "${calendar.get(Calendar.DAY_OF_MONTH)}/${calendar.get(Calendar.MONTH) + 1}/${calendar.get(Calendar.YEAR)}"
    } else {
        dateString = ""
    }

    // Fetching current year, month and day
    val day = calendar.get(Calendar.DAY_OF_MONTH)
    val month = calendar.get(Calendar.MONTH)
    val year = calendar.get(Calendar.YEAR)

    val dlgDatePicker = DatePickerDialog(
        context,
        { _: DatePicker, y: Int, m: Int, d: Int ->
            onChange(GregorianCalendar(y, m, d).time)
        }, year, month, day
    )

    val source = remember { MutableInteractionSource() }
    if (source.collectClickAsState().value)
        dlgDatePicker.show()

    Box(modifier = modifier
        .wrapContentSize(Alignment.TopStart))  {
        TextField(
            modifier = modifier,
            value = dateString,
            onValueChange = {},
            label = { Text(label) },
            interactionSource = source,
            readOnly = true,
            enabled = enabled,
            trailingIcon = {
                if (nullable) {
                    Icon(Icons.Filled.Cancel,"contentDescription",
                        Modifier.clickable { onChange(null) })
                }
            }
        )
    }
}

@Composable
internal fun StringListEditor(modifier: Modifier = Modifier, label: String, strings: List<String>, enabled: Boolean,
                     onAdd: (string: String) -> Unit, onEdit: (index: Int, string: String) -> Unit,
                     onDelete: (index: Int) -> Unit, max: Int = 0) {
    Outlined(label) {
        Column(modifier = modifier, verticalArrangement = Arrangement.spacedBy(8.dp)) {
            var editing: Int? by remember { mutableStateOf(null) }

            strings.forEachIndexed{index, s ->
                val source = remember { MutableInteractionSource() }
                if (source.collectClickAsState().value)
                    editing = index

                TextField(
                    modifier = Modifier.fillMaxWidth(),
                    value = s,
                    onValueChange = {},
                    enabled = enabled,
                    interactionSource = source,
                    readOnly = true,
                    singleLine = true,
                    trailingIcon = {
                        Icon(Icons.Filled.Cancel,"Remove",
                            Modifier.clickable { onDelete(index) })
                    }
                )
            }

            if (max <= 0 || strings.size < max)
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
                    IconButton(enabled = enabled, onClick = { editing = -1 }) {
                        Icon(Icons.Filled.Add, null)
                    }
                }

            if (enabled && editing != null) {
                val _editing = editing ?: -1
                var value by remember { mutableStateOf(TextFieldValue(if (_editing >= 0) strings[_editing] else "")) }

                AlertDialog(
                    onDismissRequest = { editing = null },
                    title = { Text("${if (_editing >= 0) "Edit" else "New"}...") },
                    text = {
                        val inputService = LocalTextInputService.current
                        val focusRequester = remember { FocusRequester() }
                        LaunchedEffect(Unit) {
                            value = value.copy(selection = TextRange(value.text.length))
                            delay(300)
                            focusRequester.requestFocus()
                            inputService?.showSoftwareKeyboard()
                        }
                        TextField(
                            modifier = Modifier.focusRequester(focusRequester),
                            value = value,
                            onValueChange = { value = it},
                            singleLine = true,
                            keyboardOptions = KeyboardOptions(capitalization = KeyboardCapitalization.Words)
                        )
                    },
                    confirmButton = {
                        TextButton(
                            onClick = {
                                if (_editing >= 0)
                                    onEdit(editing!!, value.text)
                                else
                                    onAdd(value.text)
                                editing = null
                            },
                            enabled = value.text.isNotBlank()
                        ) {
                            Text(stringResource(android.R.string.ok))
                        }
                    },
                    dismissButton = {
                            TextButton(onClick = { editing = null }) {
                                Text(stringResource(android.R.string.cancel))
                            }
                    }
                )
            }
        }
    }
}

@Composable
internal fun GenderDropDown(modifier: Modifier = Modifier, selectedGender: Gender?, enabled: Boolean, onChange: (gender: Gender?) -> Unit) {
    var expanded by remember { mutableStateOf(false) }
    val genders = Gender.values()

    val icon = if (expanded)
        Icons.Filled.ArrowDropUp //it requires androidx.compose.material:material-icons-extended
    else
        Icons.Filled.ArrowDropDown

    val source = remember { MutableInteractionSource() }

    if (source.collectClickAsState().value)
        expanded = !expanded

    Box(modifier = modifier) {
        TextField(
            label = { Text(stringResource(R.string.gender)) },
            value = selectedGender?.label?: "",
            onValueChange = {},
            trailingIcon = {
                Row {
                    Icon(Icons.Filled.Cancel,null,
                        Modifier.clickable { onChange(null) })
                    Icon(icon,null,
                        Modifier.clickable { expanded = !expanded })
                }
            },
            interactionSource = source,
            readOnly = true,
            enabled = enabled
        )
        DropdownMenu(
            expanded = enabled && expanded,
            onDismissRequest = { expanded = false },
            modifier = Modifier.wrapContentWidth()
        ) {
            genders.forEach { gender ->
                DropdownMenuItem(onClick = {
                    onChange(gender)
                    expanded = false
                }) {
                    Text(gender.label)
                }
            }
        }
    }
}

@Composable
internal fun LabelledCheckBox(
    checked: Boolean,
    onCheckedChange: ((Boolean) -> Unit),
    label: String,
    modifier: Modifier = Modifier
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = modifier
            .clip(MaterialTheme.shapes.small)
            .clickable(
                indication = rememberRipple(color = MaterialTheme.colors.primary),
                interactionSource = remember { MutableInteractionSource() },
                onClick = { onCheckedChange(!checked) }
            )
            .requiredHeight(ButtonDefaults.MinHeight)
            .padding(4.dp)
    ) {
        Checkbox(
            checked = checked,
            onCheckedChange = null
        )

        Spacer(Modifier.size(6.dp))

        Text(
            text = label,
        )
    }
}




@Preview(showBackground = true)
@Composable
fun Test() {
    Outlined("Testy test") {
        Button(onClick = {}) {
            Text("Test Button")
        }
    }
}


@Composable
internal fun InteractionSource.collectClickAsState(): State<Boolean> {
    val onClick = remember { mutableStateOf(false) }
    LaunchedEffect(this) {
        var wasPressed = false
        interactions.collect { interaction ->
            when (interaction) {
                is PressInteraction.Press -> {
                    wasPressed = true
                }
                is PressInteraction.Release -> {
                    if (wasPressed) onClick.value = true
                    wasPressed = false
                }
                is PressInteraction.Cancel -> {
                    wasPressed = false
                }
            }
            // reset state with some delay otherwise it can re-emit the previous state
            delay(30L)
            onClick.value = false
        }
    }
    return onClick
}

@Composable
internal fun Outlined(label: String, content: @Composable () -> Unit) {
    Box(
        Modifier
    ) {
        Box(
            Modifier
                .padding(top = 10.dp, bottom = 0.dp)
                .padding(horizontal = 0.dp)
                .border(
                    BorderStroke(3.dp, SolidColor(MaterialTheme.colors.primary)),
                    RoundedCornerShape(5.dp)
                )
                .wrapContentSize()
                .padding(top = 6.dp)
                .padding(8.dp)) {
            content()
        }
        Text(label, modifier = Modifier
            .padding(start = 8.dp)
            .background(MaterialTheme.colors.background)
            .padding(horizontal = 2.dp))
    }
}

@Composable
internal fun BackPressHandler(
    backPressedDispatcher: OnBackPressedDispatcher? =
        LocalOnBackPressedDispatcherOwner.current?.onBackPressedDispatcher,
    onBackPressed: () -> Unit
) {
    val currentOnBackPressed by rememberUpdatedState(newValue = onBackPressed)

    val backCallback = remember {
        object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                currentOnBackPressed()
            }
        }
    }

    DisposableEffect(key1 = backPressedDispatcher) {
        backPressedDispatcher?.addCallback(backCallback)

        onDispose {
            backCallback.remove()
        }
    }
}