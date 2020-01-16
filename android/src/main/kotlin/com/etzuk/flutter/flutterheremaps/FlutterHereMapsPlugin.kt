package com.etzuk.flutter.flutterheremaps

import com.etzuk.flutter.flutterheremaps.map.MapViewFactory
import com.here.android.mpa.common.MapSettings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

class FlutterHereMapsPlugin {

  companion object {

    private const val pluginPrefix = "flugins.etzuk.flutter_here_maps"

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val success = MapSettings.setIsolatedDiskCacheRootPath("${registrar.context().getExternalFilesDir(null)}${File.separator}.here-maps",
              registrar.context().packageName)
      if(success) {
        registrar.platformViewRegistry()
                .registerViewFactory("$pluginPrefix/MapView", MapViewFactory(registrar))
      }
    }
  }
}
