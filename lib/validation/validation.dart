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
    String passPtn = r'(^[a-zA-Z0-9]{6,15}$)';
    RegExp regExp = new RegExp(passPtn);
    if (value.length == 0) {
      return "$type is required";
    } else if (value.length > length) {
      return "$type less then $length character";
    } else if (!regExp.hasMatch(passPtn)) {
      return "$type is invalid";
    }
    return null;
  }

  static String? emailValidator(String value, String type, int length) {
    String emailPtn = r'(^[a-zA-Z0-9]{6,15}$)';
    RegExp regExp = new RegExp(emailPtn);
    if (value.length == 0) {
      return "$type is required";
    } else if (value.length > length) {
      return "$type less then $length character";
    } else if (!regExp.hasMatch(emailPtn)) {
      return "$type is invalid";
    }
    return null;
  }

  static String? ContactNumberValidator(String value, String type) {
    if (value.isEmpty) {
      return "$type can't be null";
    } else if (value.length > 10) {
      return "$type can't be more than 10 ";
    }
    return null;
  }
}
