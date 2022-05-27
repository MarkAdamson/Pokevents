package com.markadamson83.pokeventsadmin.framework

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import com.markadamson83.pokeventsadmin.data.EventsDatasource
import com.markadamson83.pokeventsadmin.domain.Event
import com.markadamson83.pokeventsadmin.domain.Game
import com.markadamson83.pokeventsadmin.domain.Gender
import com.markadamson83.pokeventsadmin.domain.Region
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import java.util.*


data class EventItem(
    val ID: String?,
    val Title: String,
    val Species: String,
    val Description: String,
    val Type: String?,
    val Region: String,
    val Gender: String?,
    val Ball: String?,
    val OT: String?,
    val TID: String?,
    val Ability: String?,
    val HoldItem: String?,
    val Nature: String?,
    val Code: String?,
    val Level: Int?,
    val Marks: List<String>,
    val Moves: List<String>,
    val Ribbons: List<String>,
    val Locations: List<String>,
    val Shiny: Boolean,
    val Gigantamax: Boolean,
    val StartDate: Date,
    val EndDate: Date?,
    val Games: List<String>,
)
var eventsType = object : TypeToken<ArrayList<EventItem>>() {}.type

data class CreateResult(
    val ID: String
)
var createResultType = object : TypeToken<CreateResult>() {}.type

class AWSEventsDatasource : EventsDatasource {
    private val http = OkHttpClient()
    private val gson = GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").create()

    override fun getEvents(): Map<String, Event> {
        val response = http.newCall(
            Request.Builder()
                .url("$API_URL/events")
                .addHeader("x-api-key", API_KEY)
                .build()
        ).execute().body!!.string()

        val result: List<EventItem> = gson.fromJson(response, eventsType)

        return result.associate { event ->
            event.ID!! to Event(
                event.Title, event.Species, event.Description, event.Type,
                Region.fromLabel(event.Region)!!,
                event.Gender?.let { Gender.fromLabel(it) },
                event.Ball, event.OT, event.TID, event.Ability, event.HoldItem, event.Nature, event.Code, event.Level,
                event.Marks.toMutableList(), event.Moves.toMutableList(), event.Ribbons.toMutableList(), event.Locations.toMutableList(),
                event.Shiny, event.Gigantamax, event.StartDate, event.EndDate, EnumSet.copyOf(event.Games.map{ Game.fromCode(it)})
            )
        }
    }

    override fun createEvent(event: Event): String {
        val body = gson.toJson(EventItem(
            null, event.title, event.species, event.description, event.kind,
            event.region.label, event.gender?.label, event.ball, event.ot, event.tid, event.ability,
            event.holdItem, event.nature, event.code, event.level, event.marks, event.moves, event.ribbons,
            event.locations, event.shiny, event.gigantamax, event.startDate, event.endDate, event.games.toList().map { it.code }
        ))

        val response = http.newCall(
            Request.Builder()
                .url("$API_URL/events")
                .post(body.toRequestBody())
                .addHeader("x-api-key", API_KEY)
                .build()
        ).execute()

        val result: CreateResult = gson.fromJson(response.body!!.string(), createResultType)

        return result.ID
    }

    override fun updateEvent(id: String, event: Event) {
        val body = gson.toJson(EventItem(
            id, event.title, event.species, event.description, event.kind,
            event.region.label, event.gender?.label, event.ball, event.ot, event.tid, event.ability,
            event.holdItem, event.nature, event.code, event.level, event.marks, event.moves, event.ribbons,
            event.locations, event.shiny, event.gigantamax, event.startDate, event.endDate, event.games.toList().map { it.code }
        ))
        http.newCall(
            Request.Builder()
                .url("$API_URL/events/$id")
                .put(body.toRequestBody())
                .addHeader("x-api-key", API_KEY)
                .build()
        ).execute()
    }

    override fun deleteEvent(id: String) {
        http.newCall(
            Request.Builder()
                .url("$API_URL/events/$id")
                .delete()
                .addHeader("x-api-key", API_KEY)
                .build()
        ).execute().body!!.string()
    }
}