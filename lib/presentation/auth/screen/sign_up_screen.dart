import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/common_widget/app_button.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../widget/app_title_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formGroup = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'name': FormControl<String>(
        validators: [Validators.required, Validators.minLength(10)]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
    'confirm_password': FormControl<String>(validators: [Validators.required]),
  }, validators: [
    //validator for matching confirm password and password field
    Validators.mustMatch('password', 'confirm_password')
  ]);

  late AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    formGroup.dispose();
    super.dispose();
  }

  final _showPasswordNotifier = ValueNotifier(false);
  final _showConfirmPasswordNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReactiveForm(
        formGroup: formGroup,
        child: Column(
          children: [
            AppTitle(),
            ReactiveTextField<String>(
              keyboardType: TextInputType.emailAddress,
              formControlName: 'email',
            ),
            ReactiveTextField<String>(
              formControlName: 'name',
            ),
            ReactiveTextField<String>(
              formControlName: 'password',
              obscureText: true,
            ),
            ReactiveTextField<String>(
              formControlName: 'confirm_password',
              obscureText: true,
            ),
            BlocBuilder<AuthCubit, AuthState>(
              bloc: _authCubit,
              builder: (context, state) {
                return FormSubmitButton(
                  onTap: _onSignUp,
                  loading: state.loading,
                  label: AppStrings.labelSignUp,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSignUp() async {
    if (formGroup.valid) {
      final email = formGroup.value['email'] as String;
      final password = formGroup.value['password'] as String;
      _authCubit.signUpWithEmailPassword(email: email, password: password);
    }
  }
}
