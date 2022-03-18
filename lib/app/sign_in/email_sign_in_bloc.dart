import 'dart:async';
import 'package:tracker_flutter/app/sign_in/email_sign_in_modal.dart';
import 'package:tracker_flutter/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});
  final AuthBase auth;

  final StreamController<EmailSignInModal> _modalController =
      StreamController<EmailSignInModal>();
  Stream<EmailSignInModal> get modalStream => _modalController.stream;
  EmailSignInModal _modal = EmailSignInModal();

  void dispose() {
    _modalController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_modal.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_modal.email, _modal.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _modal.email, _modal.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = _modal.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    updateWith(
      email: '',
      password: '',
      submitted: false,
      formType: formType,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    // update modal
    // Add updated modal to _modalController
    _modal = _modal.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );

    _modalController.add(_modal);
  }
}
