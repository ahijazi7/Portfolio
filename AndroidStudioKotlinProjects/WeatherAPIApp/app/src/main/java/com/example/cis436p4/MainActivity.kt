package com.example.cis436p4

import DataDisplayFragment
import SpinnerFragment
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.android.volley.Request
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.example.cis436p4.databinding.ActivityMainBinding
import org.json.JSONObject

class MainActivity : AppCompatActivity(), SpinnerFragment.OnCitySelectedListener {
    lateinit var binding: ActivityMainBinding

    private lateinit var dataDisplayFragment: DataDisplayFragment
    private lateinit var spinnerFragment: SpinnerFragment
    private var selectedCity: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        dataDisplayFragment = supportFragmentManager.findFragmentById(R.id.fragmentContainerView) as DataDisplayFragment
        spinnerFragment = supportFragmentManager.findFragmentById(R.id.fragmentContainerView3) as SpinnerFragment
    }

    fun fetchWeatherData(city: String) {
        val weatherURL = "https://api.weatherapi.com/v1/current.json?key=95db3f5e09bd41a685a65215232304&q=$city&aqi=no"
        val queue = Volley.newRequestQueue(this)

        val stringRequest = StringRequest(
            Request.Method.GET, weatherURL,
            { response ->
                val fetchedWeatherData = JSONObject(response)
                val current = fetchedWeatherData.getJSONObject("current")
                val location = fetchedWeatherData.getJSONObject("location")
                val isDay = current.getInt("is_day")
                val imageResId = if (isDay == 1) R.drawable.day else R.drawable.night
                val localTime = location.getString("localtime")
                val tempC = current.getString("temp_c")
                val tempF = current.getString("temp_f")

                dataDisplayFragment.updateWeatherData(localTime, tempC, tempF, imageResId)


            },
            { error ->
                Toast.makeText(this, "Error: ${error.message}", Toast.LENGTH_SHORT).show()
            })

        queue.add(stringRequest)
    }

    override fun onCitySelected(city: String) {
        selectedCity = city
    }

    fun getSelectedCity(): String {
        return selectedCity
    }

    fun getDataDisplayFragment(): DataDisplayFragment {
        return dataDisplayFragment
    }
}
