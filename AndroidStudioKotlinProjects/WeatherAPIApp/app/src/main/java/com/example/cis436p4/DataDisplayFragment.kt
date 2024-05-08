import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.cis436p4.MainActivity
import com.example.cis436p4.databinding.FragmentDataDisplayBinding

class DataDisplayFragment : Fragment() {
    lateinit var binding: FragmentDataDisplayBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentDataDisplayBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.btnGetWeatherData.setOnClickListener {
            val selectedCity = (activity as MainActivity).getSelectedCity()
            (activity as MainActivity).fetchWeatherData(selectedCity)
        }
    }

    fun updateWeatherData(localTime: String, tempC: String, tempF: String, imageResId: Int) {
        binding.tvLocalTime.text = "Local Time: $localTime"
        binding.tvTempC.text = "Temperature (Celsius): $tempC"
        binding.tvTempF.text = "Temperature (Fahrenheit): $tempF"
        binding.imageViewWeather.setImageResource(imageResId)
    }
}
