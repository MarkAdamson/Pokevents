package com.markadamson83.pokeventsadmin.domain

import java.util.*

enum class Game(val label: String, val code: String) {
    SUN              ("Sun",                "S"),
    MOON             ("Moon",               "M"),
    ULTRA_SUN        ("Ultra Sun",          "US"),
    ULTRA_MOON       ("Ultra Moon",         "UM"),
    GO               ("GO",                 "GO"),
    SWORD            ("Sword",              "SW"),
    SHIELD           ("Shield",             "SH"),
    LETS_GO_EEVEE    ("Let's Go, Eevee!",   "LGE"),
    LETS_GO_PIKACHU  ("Let's Go, Pikachu!", "LGP"),
    BRILLIANT_DIAMOND("Brilliant Diamond",  "BD"),
    SHINING_PEARL    ("Shining Pearl",      "SP"),
    LEGENDS_ARCEUS   ("Legends: Arceus",    "LA"),
    HOME             ("Home",               "HO"),
    SCARLET          ("Scarlet",            "SC"),
    VIOLET           ("Violet",             "VI");

    companion object {
        private val map = values().associateBy(Game::code)
        fun fromCode(code: String) = map[code]
    }
}

enum class Region(val label: String) {
    WORLDWIDE("Worldwide"),
    AMERICA("America"),
    JAPAN("Japan"),
    EUROPE("Europe"),
    OTHER("Other");

    companion object {
        private val map = values().associateBy(Region::label)
        fun fromLabel(label: String) = map[label]
    }
}

enum class Gender(val label: String) {
    NONE("None"), MALE("Male"), FEMALE("Female");

    companion object {
        private val map = Gender.values().associateBy(Gender::label)
        fun fromLabel(label: String) = map[label]
    }
}

data class Event (
    var title: String = "",
    var species: String = "",
    var description: String = "",
    var kind: String? = null,
    var region: Region = Region.WORLDWIDE,
    var gender: Gender? = null,
    var ball: String? = null,
    var ot: String? = null,
    var tid: String? = null,
    var ability: String? = null,
    var holdItem: String? = null,
    var nature: String? = null,
    var code: String? = null,
    var level: Int? = null,
    var marks: MutableList<String> = mutableListOf(),
    var moves: MutableList<String> = mutableListOf(),
    var ribbons: MutableList<String> = mutableListOf(),
    var locations: MutableList<String> = mutableListOf(),
    var shiny: Boolean = false,
    var gigantamax: Boolean = false,
    var startDate: Date = Date(),
    var endDate: Date? = null,
    var games: EnumSet<Game> = EnumSet.noneOf(Game::class.java),
)