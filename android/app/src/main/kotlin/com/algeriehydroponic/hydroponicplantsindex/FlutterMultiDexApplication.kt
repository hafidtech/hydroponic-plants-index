package com.algeriehydroponic.hydroponicplantsindex

import androidx.multidex.MultiDexApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.app.FlutterApplication

class FlutterMultiDexApplication : MultiDexApplication() {
    lateinit var flutterEngine: FlutterEngine

    override fun onCreate() {
        super.onCreate()
        
        // Initialize Flutter Engine
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
    }
}
