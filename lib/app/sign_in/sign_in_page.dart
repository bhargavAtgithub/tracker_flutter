import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_flutter/app/sign_in/email_sign_in_page.dart';
import 'package:tracker_flutter/app/sign_in/sign_in_bloc.dart';
import 'package:tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:tracker_flutter/services/auth.dart';
import 'package:tracker_flutter/widgets/show_exception_alert_dialog.dart';

class SignInPage extends StatelessWidget {
  const  SignInPage({Key? key, required this.bloc}) : super(key: key);

  final SignInBloc bloc;

  // Why Static?
  // The sign in bloc is only useful when we use it with Sign In page.
  // Tip: Use a static create(context) method when creating widgets that require
  // a bloc.
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
          builder: (_, bloc, __) => SignInPage(
                bloc: bloc,
              )),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context, "Sign in failed!", exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true, builder: (context) => const EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data!);
          }),
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Center(
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50.0, child: _buildHeader(isLoading)),
          const SizedBox(
            height: 110.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with google',
            textColor: Colors.black87,
            onPressed: isLoading ? () {} : () => _signInWithGoogle(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/meta-logo.png',
            text: 'Sign in with meta',
            textColor: Colors.white,
            color: const Color.fromARGB(255, 100, 140, 248),
            onPressed: isLoading ? () {} : () => _signInWithFacebook(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[400]!,
            onPressed: isLoading ? () {} : () => _signInWithEmail(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'or',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.white,
            color: Colors.black54,
            onPressed: isLoading ? () {} : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return const Text(
      "Tracker",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.w200,
        letterSpacing: 10,
        color: Colors.cyan,
      ),
    );
  }
}
