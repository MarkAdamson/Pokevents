package com.markadamson83.pokeventsadmin.framework

import android.app.Application
import androidx.lifecycle.AndroidViewModel

open class PEAViewModel(application: Application, protected val interactors: Interactors) :
        AndroidViewModel(application) {

    protected val application: PEAApplication = getApplication()
}