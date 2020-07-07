import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/mixins/validators.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/shared/dialog_loader.dart';
import 'package:mycustomers/ui/views/home/sigin/signin_view.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/ui/shared/toast_widget.dart';

import 'business/business_view.dart';

class SignUpViewModel extends BaseViewModel with Validators {
  String phoneNumber;
  bool obscureText = true;
  final DialogService _dialogService = locator<DialogService>();

  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void getPhoneNumber(String phoneNumber) async {}

  Future onInputChange() async {}

  final NavigationService _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  // Navigation
  Future navigateToLogin() async {
    await _navigationService.replaceWithTransition(
      SignInView(),
      opaque: true,
      transition: 'righttoleftwithfade',
      duration: Duration(seconds: 1),
    );
  }

  Future completeSignup() async {
    await _navigationService.replaceWithTransition(
      MainView(),
      opaque: true,
      transition: 'rotate',
      duration: Duration(seconds: 1),
    );
  }

  Future<void> signUp(String phoneNumber, String password) async {
    bool busy = true;
    _dialogService.registerCustomDialogUi(buildLoaderDialog);
    _dialogService.showCustomDialog(
        title: 'Please hold on while we try to Sign you Up');
    try {
      await _authService.signUpWithPhoneNumber(phoneNumber, password);
      _dialogService.completeDialog(DialogResponse());
      showToastCustom(
        message: 'Your account has been created successfully',
        success: true,
      );
      busy = false;
      unawaited(completeSignup());
    } on AuthException catch (e) {
      showToastCustom(
        message: e.message,
      );
      Logger.e(e.message);
    } catch (e, s) {
      Logger.e('Unknown Error', e: e, s: s);
      showToastCustom(
        message: 'An error occured while signing up',
      );
    }
    if (busy) _dialogService.completeDialog(DialogResponse());
  }

  /// A test to check dialog service and Toast
  // Future<void> signUpTest() async {
  //   bool busy = true;
  //   _dialogService.registerCustomDialogUi(buildLoaderDialog);
  //   _dialogService.showCustomDialog(
  //       title: 'Please hold on while we try to Sign you Up');
  //   await Future.delayed(Duration(seconds: 30));
  //   showToastCustom(
  //       message: 'Your Account has been Created Successfully', success: true);
  //   if (busy) _dialogService.completeDialog(DialogResponse());
  // }
}
