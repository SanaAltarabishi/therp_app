// ignore_for_file: public_member_api_docs, sort_constructors_first
class BagContainerModel {
  double sliderValue;
  double fullness;
  List<bool> checkboxValues;
  List<String> checkboxTexts; // List to store checkbox texts
  String bagName;
  BagContainerModel({
    required this.sliderValue,
    required this.fullness,
    required this.checkboxValues,
    required this.checkboxTexts,
    required this.bagName,
  });
}
