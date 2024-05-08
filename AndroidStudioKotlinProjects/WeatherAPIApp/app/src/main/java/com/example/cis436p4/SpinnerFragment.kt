import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.fragment.app.Fragment
import com.example.cis436p4.MainActivity
import com.example.cis436p4.databinding.FragmentSpinnerBinding

class SpinnerFragment : Fragment() {
    private lateinit var binding: FragmentSpinnerBinding
    private lateinit var onCitySelectedListener: OnCitySelectedListener

    interface OnCitySelectedListener {
        fun onCitySelected(city: String)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        try {
            onCitySelectedListener = context as OnCitySelectedListener
        } catch (e: ClassCastException) {
            throw ClassCastException("$context must implement OnCitySelectedListener")
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentSpinnerBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initializeSpinner()
    }

    fun initializeSpinner() {
        val cities = listOf(
            "Tokyo", "Delhi", "Shanghai", "Sao Paulo", "Mexico City",
            "Cairo", "Dhaka", "Mumbai", "Beijing", "Osaka", "New York City", "Los Angeles",
            "Chicago"
        )

        val spinner = binding.citySpinner
        spinner.adapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_dropdown_item, cities)

        binding.citySpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val city = cities[position]
                onCitySelectedListener.onCitySelected(city)
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }
    }
}
