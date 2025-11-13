package com.example.flutter_iot_manager

import android.content.Context
import android.content.Intent
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.net.wifi.WifiNetworkSpecifier
import android.net.ConnectivityManager
import android.net.NetworkRequest
import android.net.NetworkCapabilities
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flutteriotmanager/wifi"
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openWifiSettings" -> {
                    openWifiSettings()
                    result.success(null)
                }
                "connectToWifi" -> {
                    val ssid = call.argument<String>("ssid")
                    val password = call.argument<String>("password")
                    if (ssid != null && password != null) {
                        pendingResult = result
                        connectToWifi(ssid, password)
                    } else {
                        result.error("INVALID_ARGS", "SSID and password required", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun openWifiSettings() {
        val intent = Intent(Settings.ACTION_WIFI_SETTINGS)
        startActivity(intent)
    }

    private fun connectToWifi(ssid: String, password: String) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // Android 10 (API 29) and above
            val specifier = WifiNetworkSpecifier.Builder()
                .setSsid(ssid)
                .setWpa2Passphrase(password)
                .build()

            val request = NetworkRequest.Builder()
                .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
                .setNetworkSpecifier(specifier)
                .build()

            val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            
            val callback = object : ConnectivityManager.NetworkCallback() {
                override fun onAvailable(network: android.net.Network) {
                    super.onAvailable(network)
                    // Bind to the network so all requests go through this WiFi
                    connectivityManager.bindProcessToNetwork(network)
                    runOnUiThread {
                        pendingResult?.success("Connected to $ssid successfully")
                        pendingResult = null
                    }
                }
                
                override fun onUnavailable() {
                    super.onUnavailable()
                    runOnUiThread {
                        pendingResult?.error("CONNECTION_FAILED", "Could not connect to $ssid. Make sure the device is nearby and the password is correct.", null)
                        pendingResult = null
                    }
                }
                
                override fun onLost(network: android.net.Network) {
                    super.onLost(network)
                    runOnUiThread {
                        pendingResult?.error("CONNECTION_LOST", "Connection to $ssid was lost", null)
                        pendingResult = null
                    }
                }
            }
            
            connectivityManager.requestNetwork(request, callback, 15000) // 15 second timeout
        } else {
            // Android 9 (API 28) and below - legacy method
            try {
                val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                val wifiConfig = WifiConfiguration()
                wifiConfig.SSID = "\"$ssid\""
                wifiConfig.preSharedKey = "\"$password\""
                
                val netId = wifiManager.addNetwork(wifiConfig)
                if (netId == -1) {
                    pendingResult?.error("CONNECTION_FAILED", "Failed to add network configuration", null)
                    pendingResult = null
                    return
                }
                
                val disconnected = wifiManager.disconnect()
                val enabled = wifiManager.enableNetwork(netId, true)
                val reconnected = wifiManager.reconnect()
                
                if (disconnected && enabled && reconnected) {
                    pendingResult?.success("Connecting to $ssid")
                    pendingResult = null
                } else {
                    pendingResult?.error("CONNECTION_FAILED", "Failed to connect to $ssid", null)
                    pendingResult = null
                }
            } catch (e: Exception) {
                pendingResult?.error("CONNECTION_ERROR", "Error connecting: ${e.message}", null)
                pendingResult = null
            }
        }
    }
}
