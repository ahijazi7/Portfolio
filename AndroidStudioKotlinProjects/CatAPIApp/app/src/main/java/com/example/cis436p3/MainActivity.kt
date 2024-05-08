package com.example.cis436p3

import DataDisplayFragment
import SpinnerFragment
import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.ArrayAdapter
import android.widget.Spinner
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.example.cis436p3.databinding.ActivityMainBinding
import com.squareup.picasso.Picasso
import org.json.JSONArray
import org.json.JSONObject

class MainActivity : AppCompatActivity(), SpinnerFragment.OnCatSelectedListener {
    lateinit var binding: ActivityMainBinding

    private lateinit var dataDisplayFragment: DataDisplayFragment
    private lateinit var spinnerFragment: SpinnerFragment
    val catNames = ArrayList<String>()
    var catsArray: JSONArray = JSONArray()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        dataDisplayFragment = supportFragmentManager.findFragmentById(R.id.fragmentContainerView) as DataDisplayFragment
        spinnerFragment = supportFragmentManager.findFragmentById(R.id.fragmentContainerView3) as SpinnerFragment

        fetchCatData()
    }

    private fun fetchCatData() {
        val catUrl = "https://api.thecatapi.com/v1/breeds?api_key=live_6NtqPGwEYtA2LxDgTfabYHOYce2E1W2IUvnBKulW2wga2RuCvMgiIlvIGmaweqOo"
        val queue = Volley.newRequestQueue(this)

        val stringRequest = StringRequest(
            Request.Method.GET, catUrl,
            { response ->
                val fetchedCatsArray = JSONArray(response)
                for (i in 0 until fetchedCatsArray.length()) {
                    val theCat: JSONObject = fetchedCatsArray.getJSONObject(i)
                    val catName = theCat.getString("name")
                    catNames.add(catName)
                }
                catsArray = fetchedCatsArray
                spinnerFragment.initializeSpinner()
            },
            {
                // Log error
            })

        queue.add(stringRequest)
    }

    override fun onCatSelected(catName: String, catOrigin: String, catTemperament: String, catImageId: String) {
        dataDisplayFragment.setCatData(catName, catOrigin, catTemperament, catImageId)
    }
}