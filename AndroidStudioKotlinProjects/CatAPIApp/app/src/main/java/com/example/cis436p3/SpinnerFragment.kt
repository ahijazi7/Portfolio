import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Spinner
import androidx.fragment.app.Fragment
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.example.cis436p3.MainActivity
import com.example.cis436p3.databinding.FragmentSpinnerBinding
import org.json.JSONArray
import org.json.JSONObject

class SpinnerFragment : Fragment() {
    private lateinit var binding: FragmentSpinnerBinding
    private lateinit var onCatSelectedListener: OnCatSelectedListener
    var catsArray: JSONArray = JSONArray()

    interface OnCatSelectedListener {
        fun onCatSelected(catName: String, catOrigin: String, catTemperament: String, catImageId: String)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        try {
            onCatSelectedListener = context as OnCatSelectedListener
        } catch (e: ClassCastException) {
            throw ClassCastException("$context must implement OnCatSelectedListener")
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
    }

    fun initializeSpinner() {
        val mainActivity = activity as MainActivity
        val catNames = mainActivity.catNames
        catsArray = mainActivity.catsArray
        val spinner = binding.catSpinner
        spinner.adapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_dropdown_item, catNames)

        binding.catSpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val cat = catsArray.getJSONObject(position)
                val catName = cat.getString("name")
                val catOrigin = cat.getString("origin")
                val catTemperament = cat.getString("temperament")
                val catImageId = cat.optString("reference_image_id", "")

                onCatSelectedListener.onCatSelected(catName, catOrigin, catTemperament, catImageId)
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }
    }
}