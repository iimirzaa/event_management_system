class AuthValidator {
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
}
