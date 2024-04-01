import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/toast_service.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:movie_app/core/ui/custom_decoration.dart';
import 'package:movie_app/presentation/auth/screen/sign_up_screen.dart';
import 'package:movie_app/presentation/auth/widget/app_title_widget.dart';
import 'package:movie_app/presentation/movie/screen/all_movies_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/common_widget/app_button.dart';
import '../../../core/ui/app_strings.dart';
import '../bloc/auth_cubit.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = 'signin';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formGroup = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(8)]),
  });

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: AppBar(),
        body: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  formControlName: 'password',
                  obscureText: true,
                  decoration: CustomDecorations.fieldDecoration(
                      prefix: Icon(Icons.password_outlined)),
                ),
                const SizedBox(height: 8),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    //Show error message when message is not null
                    if (state.message != null &&
                        state.message?.isNotEmpty == true) {
                      ToastService.showError(state.message!);
                    }
                    _moveToAllMoviesWhenLoggedIn(state.status);
                  },
                  builder: (context, state) {
                    return FormSubmitButton(
                      onTap: _onSignIn,
                      loading: state.loading,
                      label: AppStrings.labelSignIn,
                    );
                  },
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed(SignUpScreen.routeName);
                    },
                    child: Text(AppStrings.labelSignUp))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignIn() async {
    if (formGroup.valid) {
      final email = formGroup.value['email'] as String;
      final password = formGroup.value['password'] as String;
      _authCubit.signInWithEmailPassword(email: email, password: password);
    }
  }

  void _moveToAllMoviesWhenLoggedIn(AuthStatus status) {
    if (status == AuthStatus.authenticated) {
      context.goNamed(AllMoviesScreen.routeName);
    }
  }
}
