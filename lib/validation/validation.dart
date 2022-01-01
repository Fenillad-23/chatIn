class Validators {
  static String? userNameValidator(String value, String type, int length) {
    String namePtn = r'(^[a-zA-Z0-9]{6,15}$)';
    RegExp regExp = new RegExp(namePtn);
    if (value.isEmpty) {
      return "$type is required";
    } else if (value.length > length) {
      return "$type less then $length character";
    } else if (!regExp.hasMatch(value)) {
      return "$type is invalid";
    }

    return null;
  }

  static String? passwordValidator(String value, String type, int length) {
    String passPtn = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp =  RegExp(passPtn);
    if (value.isEmpty) {
      return "$type is required";
    } else if (value.length > length) {
      return "$type less then $length character";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid - please follow this formate UserName@47";
    }
    return null;
  }

  static String? ContactNumberValidator(String value, String type) {
    int v = value.length;
    if (value.isEmpty) {
      return "$type can't be null";
    } else if (v > 10) {
      return "$type can't be more than 10 ";
    } else if (v < 10){
      return "$type can't be less than 10";
    }
    return null;
  }
}
