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

  static String? validateEventName(String eventName) {
    final regex = RegExp(r"^[A-Za-z'&-]+(?:\s+[A-Za-z'&-]+){1,}\s*$");
    if (!regex.hasMatch(eventName)) {
      return "Event name should have at least two words without any special character";
    }
    return null;
  }

  static String? validateEventDetail(String eventName) {
    final RegExp detailsRegex = RegExp(r'''^[a-zA-Z0-9.,'"!?\s()&@%:;\-]*$''');

    if (eventName.trim().isEmpty) return 'Please enter details';
    if (eventName.trim().isEmpty) return 'Please enter details';
    if (!detailsRegex.hasMatch(eventName)) {
      return 'Details contain invalid characters';
    }
    if (eventName.length > 500) return 'Details must be 500 characters or less';
    return null;
  }

  static String? validateCapacity(String capacity) {
    final regex = RegExp(r"^(?:[1-9]\d{0,2}|1[0-4]\d{2}|1500)$");
    if (!regex.hasMatch(capacity)) {
      return "Please! enter Capacity between 1 to 1500";
    }
    return null;
  }

  static String? validateImages(List<XFile> images) {
    if (images.isEmpty) {
      return "Please Select at least one image";
    }
    return null;
  }

  static String? validateCategories(List<String> category) {
    if (category.isEmpty) {
      return "Please select at least one category";
    }
    return null;
  }

  static String? validateServices(List<String> service) {
    if (service.isEmpty) {
      return "Please select at least one service";
    }
    return null;
  }

  static String? validateLocation(String street, String town, String city) {
    if (street.isEmpty || town.isEmpty || city.isEmpty) {
      return "Please enter a valid location";
    } else {
      final streetRegex = RegExp(r'^[A-Za-z0-9]+(?:\s+[A-Za-z0-9]+)*$');
      final townRegex = RegExp(r'^[A-Za-z]+(?:[ \-][A-Za-z]+)*$');
      final cityRegex = RegExp(r'^[A-Za-z]+(?:\s+[A-Za-z]+)*$');
      if (!streetRegex.hasMatch(street)) {
        return "Please enter a valid Street name";
      } else if (!cityRegex.hasMatch(city)) {
        return "Please enter a valid City name";
      } else if (!townRegex.hasMatch(town)) {
        return "Please enter a valid Town name";
      }
    }
    return null;
  }
}
