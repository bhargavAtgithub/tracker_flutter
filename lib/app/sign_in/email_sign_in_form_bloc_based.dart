import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_flutter/app/sign_in/email_sign_in_bloc.dart';
import 'package:tracker_flutter/app/sign_in/email_sign_in_modal.dart';
import 'package:tracker_flutter/services/auth.dart';
import 'package:tracker_flutter/widgets/show_exception_alert_dialog.dart';

import '../../widgets/FormSubmitButton.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  const EmailSignInFormBlocBased({Key? key, required this.bloc})
      : super(key: key);
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
    );
  }

  @override
  State<EmailSignInFormBlocBased> createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, 'Sign In failed!', e);
    }
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModal modal) {
    final newFocus = modal.emailValidator.isValid(modal.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildChildren(EmailSignInModal modal) {
      return [
        _buildEmailTextField(modal),
        const SizedBox(
          height: 8.0,
        ),
        _buildPasswordTextField(modal),
        const SizedBox(
          height: 32.0,
        ),
        FormSubmitButton(
            text: modal.primaryButtonText,
            onPressed: modal.canSubmit ? _submit : null),
        const SizedBox(
          height: 8.0,
        ),
        TextButton(
            onPressed: !modal.isLoading ? _toggleFormType : null,
            child: Text(
              modal.secondaryButtonText,
              style: TextStyle(color: Colors.teal[200]!),
            ))
      ];
    }

    return StreamBuilder<EmailSignInModal>(
        stream: widget.bloc.modalStream,
        initialData: EmailSignInModal(),
        builder: (context, snapshot) {
          final EmailSignInModal modal = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(modal),
            ),
          );
        });
  }

  TextField _buildPasswordTextField(EmailSignInModal modal) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: modal.passwordErrorText,
          enabled: !modal.isLoading),
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
      onChanged: widget.bloc.updatePassword,
    );
  }

  TextField _buildEmailTextField(EmailSignInModal modal) {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText: modal.emailErrorText,
          enabled: !modal.isLoading),
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingComplete(modal),
      onChanged: widget.bloc.updateEmail,
    );
  }
}
