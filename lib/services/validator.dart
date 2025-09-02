import 'package:image_picker/image_picker.dart';

class Validator {
  static String? validateUsername(String username) {
    final regex = RegExp(r"^[A-Za-z]{2,}(?: [A-Za-z]{2,})+\s?$");
    if (!regex.hasMatch(username)) {
      return "Enter your full name (first and last, letters only, each at least 2 characters)";
    }
    return null;
  }

  static String? validateEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(email)) return "Enter a valid email address";
    return null;
  }

  static String? validatePassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,16}$');
    if (!regex.hasMatch(password)) {
      return "Password must have 8–16 chars, upper, lower, number";
    }
    return null;
  }
  static String? validateEventName(String eventName){
    final regex = RegExp(r"^[A-Za-z'&-]+(?:\s+[A-Za-z'&-]+){1,}\s*$");
      if(! regex.hasMatch(eventName)){
        return "Event name should have at least two words without any special character";
      }
      return null;

    }


  static String? validateCapacity(String capacity){
  final regex = RegExp(r"^(?:[1-9]\d{0,2}|1[0-4]\d{2}|1500)$");
  if(! regex.hasMatch(capacity)){
  return "Enter a valid Capacity";
  }
  return null;
  }
  static String? validateImages(List<XFile> images){
    if(images.isEmpty){
      return "Lexi is hot";
    }
    return null;
  }
  static String? validateCategories(List<String> category){
    if(category.isEmpty){
      return "Please select at least one category";
    }
    return null;
  }
  static String? validateServices(List<String> service){
    if(service.isEmpty){
      return "Please select at least one service";
    }
    return null;
  }
  static String? validateLocation(String street,String town,String city){
    if(street.length<1||town.length<3||city.length<3)
  }

}
