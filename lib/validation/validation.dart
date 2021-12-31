class Validators {
  static String? userNameValidator(String value, String type, int length) {
    String namePtn = r'(^[a-zA-Z0-9]{6,15}$)';
    RegExp regExp = new RegExp(namePtn);
    if (value.length == 0) {
      return "$type is required";
    } else if (value.length > length) {
      return "$type less then $length character";
    } else if (!regExp.hasMatch(namePtn)) {
      return "$type is invalid";
    }
    return null;
  }

  static String? passwordValidator(String value, String type, int length) {
    String namePtn = r'(^[a-zA-Z0-9]{6,15}$)';
    RegExp regExp = new RegExp(namePtn);
    if (value.length == 0) {
      return "$type is required";
    } else if (value.length > length) {
      return "$type less then $length character";
    } else if (!regExp.hasMatch(namePtn)) {
      return "$type is invalid";
    }
    return null;
  }
}
