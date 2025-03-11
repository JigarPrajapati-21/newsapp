import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../controller/all_news_controller.dart';

class FilterModalBottomSheet extends StatelessWidget {
  final AllNewsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 0, right: 16, bottom: 80),
      child: Wrap(
        children: [
          Center(
            child: Text(
              'Filter Articles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 10,
            color: Colors.blue.shade900,
            thickness: 2,
          ),
          const SizedBox(height: 20),

          // Country dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              Text("Select Country",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 18,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 10,),

              GetBuilder<AllNewsController>(
                builder: (ctrl) => MultiSelectDialogField(
                  items: ctrl.countryList
                      .map((item) => MultiSelectItem<String>(item.keys.first, item.keys.first))
                      .toList(),
                  title:  Text("Select Country",
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 22,
                      letterSpacing: 2,
                    ),
                  ),
                  selectedColor: Colors.blue.shade500,
                  selectedItemsTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.white,itemsTextStyle: TextStyle(
                  color: Colors.blue.shade900,
                ),
                  // unselectedColor: Colors.blue.shade100,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.blue.shade900,
                      width: 1.5,
                    ),
                  ),
                  buttonIcon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.blue,
                  ),
                  listType: MultiSelectListType.CHIP,
                  initialValue: ctrl.getSelectedCountryNames(),
                  chipDisplay: MultiSelectChipDisplay(
                    chipColor: Colors.blue.withOpacity(0.15),
                    textStyle: const TextStyle(color: Colors.blue),
                    onTap: (item) {
                      ctrl.removeCountry(item.toString());
                    },
                  ),
                  buttonText: Text(
                    ctrl.selectedCountries.isEmpty
                        ? "Select Country"
                        : "${ctrl.selectedCountries.length} Countries Selected",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onConfirm: (results) {
                    if (results.length <= 3) {
                      List<String> selectedCodes = results.map((countryName) {
                        for (var country in ctrl.countryList) {
                          if (country.keys.first == countryName) {
                            return country.values.first;
                          }
                        }
                        return "";
                      }).where((code) => code.isNotEmpty).toList();

                      ctrl.updateSelectedCountries(selectedCodes);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please select only 3 options",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),

          // Language dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("Select Language",
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 18,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold
                  ),
              ),

              SizedBox(height: 10,),

              GetBuilder<AllNewsController>(
                builder: (ctrl) => MultiSelectDialogField(
                  items: ctrl.languageList
                      .map((item) => MultiSelectItem<String>(item.keys.first, item.keys.first))
                      .toList(),
                  title:  Text("Select Language",
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 22,
                      letterSpacing: 2,
                    ),

                  ),
                  selectedColor: Colors.blue.shade500,
                  selectedItemsTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.white,itemsTextStyle: TextStyle(
                  color: Colors.blue.shade900,
                ),

                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.blue.shade900,
                      width: 1.5,
                    ),
                  ),
                  buttonIcon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.blue,
                  ),
                  listType: MultiSelectListType.CHIP,
                  initialValue: ctrl.getSelectedLanguageNames(),
                  chipDisplay: MultiSelectChipDisplay(
                    chipColor: Colors.blue.withOpacity(0.15),
                    textStyle: const TextStyle(color: Colors.blue),
                    onTap: (item) {
                      ctrl.removeLanguage(item.toString());
                    },
                  ),
                  buttonText: Text(
                    ctrl.selectedLanguages.isEmpty
                        ? "Select Language"
                        : "${ctrl.selectedLanguages.length} Languages Selected",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onConfirm: (results) {
                    if (results.length <= 3) {
                      List<String> selectedCodes = results.map((languageName) {
                        for (var language in ctrl.languageList) {
                          if (language.keys.first == languageName) {
                            return language.values.first;
                          }
                        }
                        return "";
                      }).where((code) => code.isNotEmpty).toList();

                      ctrl.updateSelectedLanguages(selectedCodes);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please select only 3 options",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),

          // Category dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              Text("Select Category",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 18,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 10,),

              GetBuilder<AllNewsController>(
                builder: (ctrl) => MultiSelectDialogField(
                  items: ctrl.categoryList
                      .map((category) => MultiSelectItem<String>(category, category))
                      .toList(),
                  title:  Text("Select Category",
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 22,
                      letterSpacing: 2,
                    ),
                  ),
                  selectedColor: Colors.blue.shade500,
                  selectedItemsTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.white,itemsTextStyle: TextStyle(
                  color: Colors.blue.shade900,
                ),

                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.blue.shade900,
                      width: 1.5,
                    ),
                  ),
                  buttonIcon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.blue,
                  ),
                  listType: MultiSelectListType.CHIP,
                  initialValue: ctrl.selectedCategories,
                  chipDisplay: MultiSelectChipDisplay(
                    chipColor: Colors.blue.withOpacity(0.15),
                    textStyle: const TextStyle(color: Colors.blue),
                    onTap: (item) {
                      ctrl.removeCategory(item.toString());
                    },
                  ),
                  buttonText: Text(
                    ctrl.selectedCategories.isEmpty
                        ? "Select Category"
                        : "${ctrl.selectedCategories.length} Categories Selected",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onConfirm: (results) {
                    if (results.length <= 3) {
                      ctrl.updateSelectedCategories(results.cast<String>());
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please select only 3 options",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),

          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.refreshNews();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Apply Filters",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
