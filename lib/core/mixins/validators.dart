
/// Class of validation functions that the app will use
///   - Note: This class should be used as a mixin using the `with` keyword
class Validators {
  final phoneNumberRegExp = RegExp(
      r'^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$');
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  String validatePhoneNumber(String value) {
    if (!phoneNumberRegExp.hasMatch(value.trim())) {
      return 'Invalid phone number';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is required';
    } else if (value.length <= 6){
      return 'Password must be more than 6 characters';
    }
    return null;
  }

  String validateEmail(String value) {
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Invalid email address';
    }
    return null;
  }
}
