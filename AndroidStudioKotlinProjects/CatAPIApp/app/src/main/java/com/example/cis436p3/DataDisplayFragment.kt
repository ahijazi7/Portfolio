import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.cis436p3.MainActivity
import com.example.cis436p3.R
import com.example.cis436p3.databinding.FragmentDataDisplayBinding
import com.squareup.picasso.Picasso
import org.json.JSONObject

class DataDisplayFragment : Fragment() {
    private lateinit var binding: FragmentDataDisplayBinding

    private var selectedCatName: String? = null
    private var selectedCatOrigin: String? = null
    private var selectedCatTemperament: String? = null
    private var selectedCatImageId: String? = null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentDataDisplayBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.btnGetCatData.setOnClickListener {
            updateCatData()
        }
    }

    fun setCatData(catName: String, catOrigin: String, catTemperament: String, catImageId: String) {
        selectedCatName = catName
        selectedCatOrigin = catOrigin
        selectedCatTemperament = catTemperament
        selectedCatImageId = catImageId
    }

    fun updateCatData() {
        if (selectedCatName != null && selectedCatOrigin != null && selectedCatTemperament != null && selectedCatImageId != null) {
            binding.tvCatName.text = "Cat Name: $selectedCatName"
            binding.tvCatOrigin.text = "Cat Origin: $selectedCatOrigin"
            binding.tvCatTemperament.text = "Cat Temperament: $selectedCatTemperament"

            if (selectedCatImageId == "")
                binding.imageViewCat.setImageResource(R.drawable.nocatimage)
            else {
                Picasso.get().load("https://cdn2.thecatapi.com/images/$selectedCatImageId.jpg").resize(550, 550).into(binding.imageViewCat)
            }
        }
    }
}