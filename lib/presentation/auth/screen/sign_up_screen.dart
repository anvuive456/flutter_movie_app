import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/common_widget/app_button.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/toast_service.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/custom_decoration.dart';
import 'package:movie_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:movie_app/presentation/movie/screen/all_movies_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../widget/app_title_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formGroup = FormGroup(
    {
      'email': FormControl<String>(
          validators: [Validators.required, Validators.email]),
      'name': FormControl<String>(validators: [Validators.required]),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(8)]),
    },
  );

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ReactiveForm(
            formGroup: formGroup,
            child: Column(
              children: [
                AppTitle(),
                ReactiveTextField<String>(
                  keyboardType: TextInputType.emailAddress,
                  formControlName: 'email',
                  decoration: CustomDecorations.fieldDecoration(
                      prefix: Icon(Icons.email_outlined)),
                ),
                const SizedBox(height: 8),
                ReactiveTextField<String>(
                  formControlName: 'name',
                  decoration: CustomDecorations.fieldDecoration(
                      prefix: Icon(Icons.person_outlined)),
                ),
                const SizedBox(height: 8),
                ReactiveTextField<String>(
                  formControlName: 'password',
                  obscureText: true,
                  decoration: CustomDecorations.fieldDecoration(
                    prefix: Icon(Icons.password_outlined),
                  ),
                ),
                const SizedBox(height: 8),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: _authCubit,
                  builder: (context, state) {
                    return FormSubmitButton(
                      form: formGroup,
                      onTap: _onSignUp,
                      loading: state.loading,
                      label: AppStrings.labelSignUp,
                    );
                  },
                  listener: (BuildContext context, AuthState state) {
                    if (state.message != null) {
                      ToastService.showError(state.message!);
                      return;
                    }
                    if (state.status == AuthStatus.authenticated) {
                      context.goNamed(AllMoviesScreen.routeName);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUp() async {
    if (formGroup.valid) {
      context.unFocus();
      final email = formGroup.value['email'] as String;
      final password = formGroup.value['password'] as String;
      _authCubit.signUpWithEmailPassword(email: email, password: password);
    }
  }
}
