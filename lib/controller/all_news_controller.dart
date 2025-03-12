import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../model/article_model.dart';
import '../utils/strings.dart';

class AllNewsController extends GetxController {
  var selectedCountries = <String>[].obs;//"in", "cn"
  var selectedLanguages = <String>[].obs;//"en", "hi"
  var selectedCategories = <String>[].obs;//"Education","Entertainment"

  var newsArticles = <Article>[].obs;
  var isLoading = false.obs;


    final List<Map<String, String>> countryList = [
    {"Afghanistan": "af"},
    {"Albania": "al"},
    {"Algeria": "dz"},
    {"India": "in"},
    {"China": "cn"},
    {"Canada": "ca"},
    {"Andorra": "ad"},
    {"Angola": "ao"},
    {"Argentina": "ar"},
    {"Armenia": "am"},
    {"Australia": "au"},
    {"Austria": "at"},
    {"Azerbaijan": "az"},
    {"Bahamas": "bs"},
    {"Bahrain": "bh"},
    {"Bangladesh": "bd"},
    {"Barbados": "bb"},
    {"Belarus": "by"},
    {"Belgium": "be"},
    {"Belize": "bz"},
    {"Benin": "bj"},
    {"Bermuda": "bm"},
    {"Bhutan": "bt"},
    {"Bolivia": "bo"},
    {"Bosnia And Herzegovina": "ba"},
    {"Botswana": "bw"},
    {"Brazil": "br"},
    {"Brunei": "bn"},
    {"Bulgaria": "bg"},
    {"Burkina Faso": "bf"},
    {"Burundi": "bi"},
    {"Cambodia": "kh"},
    {"Cameroon": "cm"},
    {"Cape Verde": "cv"},
    {"Cayman Islands": "ky"},
    {"Central African Republic": "cf"},
    {"Chad": "td"},
    {"Chile": "cl"},
    {"Colombia": "co"},
    {"Comoros": "km"},
    {"Congo": "cg"},
    {"Cook Islands": "ck"},
    {"Costa Rica": "cr"},
    {"Croatia": "hr"},
    {"Cuba": "cu"},
    {"Curaçao": "cw"},
    {"Cyprus": "cy"},
    {"Czech Republic": "cz"},
    {"Denmark": "dk"},
    {"Djibouti": "dj"},
    {"Dominica": "dm"},
    {"Dominican Republic": "do"},
    {"DR Congo": "cd"},
    {"Ecuador": "ec"},
    {"Egypt": "eg"},
    {"El Salvador": "sv"},
    {"Equatorial Guinea": "gq"},
    {"Eritrea": "er"},
    {"Estonia": "ee"},
    {"Eswatini": "sz"},
    {"Ethiopia": "et"},
    {"Fiji": "fj"},
    {"Finland": "fi"},
    {"France": "fr"},
    {"French Polynesia": "pf"},
    {"Gabon": "ga"},
    {"Gambia": "gm"},
    {"Georgia": "ge"},
    {"Germany": "de"},
    {"Ghana": "gh"},
    {"Gibraltar": "gi"},
    {"Greece": "gr"},
    {"Grenada": "gd"},
    {"Guatemala": "gt"},
    {"Guinea": "gn"},
    {"Guyana": "gy"},
    {"Haiti": "ht"},
    {"Honduras": "hn"},
    {"Hong Kong": "hk"},
    {"Hungary": "hu"},
    {"Iceland": "is"},
    {"Indonesia": "id"},
    {"Iran": "ir"},
    {"Iraq": "iq"},
    {"Ireland": "ie"},
    {"Israel": "il"},
    {"Italy": "it"},
    {"Ivory Coast": "ci"},
    {"Jamaica": "jm"},
    {"Japan": "jp"},
    {"Jersey": "je"},
    {"Jordan": "jo"},
    {"Kazakhstan": "kz"},
    {"Kenya": "ke"},
    {"Kiribati": "ki"},
    {"Kosovo": "xk"},
    {"Kuwait": "kw"},
    {"Kyrgyzstan": "kg"},
    {"Laos": "la"},
    {"Latvia": "lv"},
    {"Lebanon": "lb"},
    {"Lesotho": "ls"},
    {"Liberia": "lr"},
    {"Libya": "ly"},
    {"Liechtenstein": "li"},
    {"Lithuania": "lt"},
    {"Luxembourg": "lu"},
    {"Macau": "mo"},
    {"Macedonia": "mk"},
    {"Madagascar": "mg"},
    {"Malawi": "mw"},
    {"Malaysia": "my"},
    {"Maldives": "mv"},
    {"Mali": "ml"},
    {"Malta": "mt"},
    {"Marshall Islands": "mh"},
    {"Mauritania": "mr"},
    {"Mauritius": "mu"},
    {"Mexico": "mx"},
    {"Micronesia": "fm"},
    {"Moldova": "md"},
    {"Monaco": "mc"},
    {"Mongolia": "mn"},
    {"Montenegro": "me"},
    {"Morocco": "ma"},
    {"Mozambique": "mz"},
    {"Myanmar": "mm"},
    {"Namibia": "na"},
    {"Nauru": "nr"},
    {"Nepal": "np"},
    {"Netherlands": "nl"},
    {"New Caledonia": "nc"},
    {"New Zealand": "nz"},
    {"Nicaragua": "ni"},
    {"Niger": "ne"},
    {"Nigeria": "ng"},
    {"North Korea": "kp"},
    {"Norway": "no"},
    {"Oman": "om"},
    {"Pakistan": "pk"},
    {"Palau": "pw"},
    {"Palestine": "ps"},
    {"Panama": "pa"},
    {"Papua New Guinea": "pg"},
    {"Paraguay": "py"},
    {"Peru": "pe"},
    {"Philippines": "ph"},
    {"Poland": "pl"},
    {"Portugal": "pt"},
    {"Puerto Rico": "pr"},
    {"Qatar": "qa"},
    {"Romania": "ro"},
    {"Russia": "ru"},
    {"Rwanda": "rw"},
    {"Saint Lucia": "lc"},
    {"Saint Martin (Dutch)": "sx"},
    {"Samoa": "ws"},
    {"San Marino": "sm"},
    {"Sao Tome and Principe": "st"},
    {"Saudi Arabia": "sa"},
    {"Senegal": "sn"},
    {"Serbia": "rs"},
    {"Seychelles": "sc"},
    {"Sierra Leone": "sl"},
    {"Singapore": "sg"},
    {"Slovakia": "sk"},
    {"Slovenia": "si"},
    {"Solomon Islands": "sb"},
    {"Somalia": "so"},
    {"South Africa": "za"},
    {"South Korea": "kr"},
    {"Spain": "es"},
    {"Sri Lanka": "lk"},
    {"Sudan": "sd"},
    {"Suriname": "sr"},
    {"Sweden": "se"},
    {"Switzerland": "ch"},
    {"Syria": "sy"},
    {"Taiwan": "tw"},
    {"Tajikistan": "tj"},
    {"Tanzania": "tz"},
    {"Thailand": "th"},
    {"Timor-Leste": "tl"},
    {"Togo": "tg"},
    {"Tonga": "to"},
    {"Trinidad and Tobago": "tt"},
    {"Tunisia": "tn"},
    {"Turkey": "tr"},
    {"Turkmenistan": "tm"},
    {"Tuvalu": "tv"},
    {"Uganda": "ug"},
    {"Ukraine": "ua"},
    {"United Arab Emirates": "ae"},
    {"United Kingdom": "gb"},
    {"United States of America": "us"},
    {"Uruguay": "uy"},
    {"Uzbekistan": "uz"},
    {"Vanuatu": "vu"},
    {"Vatican": "va"},
    {"Venezuela": "ve"},
    {"Vietnam": "vi"},
    {"Virgin Islands (British)": "vg"},
    {"World": "wo"},
    {"Yemen": "ye"},
    {"Zambia": "zm"},
    {"Zimbabwe": "zw"}
  ];

  final List<Map<String, String>> languageList = [
    {"Afrikaans": "af"},
    {"Albanian": "sq"},
    {"English": "en"},
    {"Gujarati": "gu"},
    {"Amharic": "am"},
    {"Arabic": "ar"},
    {"Hindi": "hi"},
    {"Armenian": "hy"},
    {"Assamese": "as"},
    {"Azerbaijani": "az"},
    {"Bambara": "bm"},
    {"Basque": "eu"},
    {"Belarusian": "be"},
    {"Bengali": "bn"},
    {"Bosnian": "bs"},
    {"Bulgarian": "bg"},
    {"Burmese": "my"},
    {"Catalan": "ca"},
    {"Central Kurdish": "ckb"},
    {"Chinese": "zh"},
    {"Croatian": "hr"},
    {"Czech": "cs"},
    {"Danish": "da"},
    {"Dutch": "nl"},
    {"Estonian": "et"},
    {"Filipino": "pi"},
    {"Finnish": "fi"},
    {"French": "fr"},
    {"Galician": "gl"},
    {"Georgian": "ka"},
    {"German": "de"},
    {"Greek": "el"},
    {"Hausa": "ha"},
    {"Hebrew": "he"},
    {"Hungarian": "hu"},
    {"Icelandic": "is"},
    {"Indonesian": "id"},
    {"Italian": "it"},
    {"Japanese": "jp"},
    {"Kannada": "kn"},
    {"Kazakh": "kz"},
    {"Khmer": "kh"},
    {"Kinyarwanda": "rw"},
    {"Korean": "ko"},
    {"Kurdish": "ku"},
    {"Latvian": "lv"},
    {"Lithuanian": "lt"},
    {"Luxembourgish": "lb"},
    {"Macedonian": "mk"},
    {"Malay": "ms"},
    {"Malayalam": "ml"},
    {"Maltese": "mt"},
    {"Maori": "mi"},
    {"Marathi": "mr"},
    {"Mongolian": "mn"},
    {"Nepali": "ne"},
    {"Norwegian": "no"},
    {"Oriya": "or"},
    {"Pashto": "ps"},
    {"Persian": "fa"},
    {"Polish": "pl"},
    {"Portuguese": "pt"},
    {"Punjabi": "pa"},
    {"Romanian": "ro"},
    {"Russian": "ru"},
    {"Samoan": "sm"},
    {"Serbian": "sr"},
    {"Shona": "sn"},
    {"Sindhi": "sd"},
    {"Sinhala": "si"},
    {"Slovak": "sk"},
    {"Slovenian": "sl"},
    {"Somali": "so"},
    {"Spanish": "es"},
    {"Swahili": "sw"},
    {"Swedish": "sv"},
    {"Tajik": "tg"},
    {"Tamil": "ta"},
    {"Telugu": "te"},
    {"Thai": "th"},
    {"Traditional Chinese": "zht"},
    {"Turkish": "tr"},
    {"Turkmen": "tk"},
    {"Ukrainian": "uk"},
    {"Urdu": "ur"},
    {"Uzbek": "uz"},
    {"Vietnamese": "vi"},
    {"Welsh": "cy"},
    {"Zulu": "zu"},
  ];

  final List<String> categoryList = [
    "Business",
    "Crime",
    "Domestic",
    "Education",
    "Entertainment",
    "Environment",
    "Food",
    "Health",
    "Lifestyle",
    "Other",
    "Politics",
    "Science",
    "Sports",
    "Technology",
    "Top",
    "Tourism",
    "World",
  ];

  Future<List<Article>> fetchNewsArticles(
      List<String> categories, List<String> countries, List<String> languages) async {
    String categoryParameter = categories.isNotEmpty ? categories.join(",") : "";
    String countryParameter = countries.isNotEmpty ? countries.join(",") : "";
    String languageParameter = languages.isNotEmpty ? languages.join(",") : "";

    try {
      final baseUrl =
          "https://newsdata.io/api/1/news?apikey=${Strings.key}&country=$countryParameter&language=$languageParameter&category=$categoryParameter";

      final response = await http.get(Uri.parse(baseUrl));

      print(response.statusCode);
      print(baseUrl);
      print(countryParameter);
      print(categoryParameter);
      print(languageParameter);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Article> articles = (data['results'] as List)
            .map((item) => Article.fromJson(item))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load news articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news articles: $e');
    }
  }

  Future<void> fetchNews() async {
    isLoading.value = true;
    try {
      newsArticles.assignAll(await fetchNewsArticles(
        selectedCategories,
        selectedCountries,
        selectedLanguages,
      ));
    } catch (e) {
      print('Error fetching news: $e');
      newsArticles.assignAll([]);
    } finally {
      isLoading.value = false;
    }
  }

  void refreshNews() {
    fetchNews();
  }

  @override
  void onInit() {
    super.onInit();
    initializeSelectedValues();
    fetchNews();
  }


  void initializeSelectedValues() {
    selectedCountries.assignAll(["in", "cn"]);
    selectedLanguages.assignAll(["en", "hi"]);
    selectedCategories.assignAll(["Education","Entertainment"]);
  }

  void updateSelectedCountries(List<String> countries) {
    selectedCountries.assignAll(countries);
  }

  void updateSelectedLanguages(List<String> languages) {
    selectedLanguages.assignAll(languages);
  }

  void updateSelectedCategories(List<String> categories) {
    selectedCategories.assignAll(categories);
  }

  // Map country code to country name
  String getCountryNameByCode(String code) {
    for (var country in countryList) {
      if (country.values.first == code) {
        return country.keys.first;
      }
    }
    return "";
  }

  // Map language code to language name
  String getLanguageNameByCode(String code) {
    for (var language in languageList) {
      if (language.values.first == code) {
        return language.keys.first;
      }
    }
    return "";
  }

  // Helper methods to convert codes to display names for selected items
  List<String> getSelectedCountryNames() {
    return selectedCountries
        .map((code) => getCountryNameByCode(code))
        .where((name) => name.isNotEmpty)
        .toList();
  }

  List<String> getSelectedLanguageNames() {
    return selectedLanguages
        .map((code) => getLanguageNameByCode(code))
        .where((name) => name.isNotEmpty)
        .toList();
  }


  void removeCountry(String countryName) {
    String codeToRemove = "";
    for (var country in countryList) {
      if (country.keys.first == countryName) {
        codeToRemove = country.values.first;
        break;
      }
    }

    if (codeToRemove.isNotEmpty) {
      selectedCountries.remove(codeToRemove);
      update();
    }
  }

// Remove a language by its display name
  void removeLanguage(String languageName) {
    String codeToRemove = "";
    for (var language in languageList) {
      if (language.keys.first == languageName) {
        codeToRemove = language.values.first;
        break;
      }
    }

    if (codeToRemove.isNotEmpty) {
      selectedLanguages.remove(codeToRemove);
      update();
    }
  }

// Remove a category
  void removeCategory(String category) {
    selectedCategories.remove(category);
    update();
  }



}