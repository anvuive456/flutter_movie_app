import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/dependency_injection/dependency_injection.dart';
import 'package:movie_app/core/navigation/routes.dart';
import 'package:movie_app/core/ui/app_strings.dart';
import 'package:movie_app/core/ui/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'core/firebase/firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await configureDependencies();

    runApp(const MyApp());
  }, (error, stack) {
    Logger().w(error);
    Logger().w(stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //Configure globally validation messages for all forms
        //the error must parse to map for getting values of error
        ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.email: (error) => AppStrings.errInvalidEmail,
        ValidationMessage.minLength: (error) =>
            AppStrings.errInvalidLength((error as Map)['requiredLength']),
        ValidationMessage.required: (error) => AppStrings.errInvalidRequired,
        ValidationMessage.mustMatch: (error) => AppStrings.errInvalidMatch(
            (error as Map)['controlName'], (error)['matchingControlName'])
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.mainTheme,
        routerConfig: router,
        builder: BotToastInit(),
      ),
    );
  }
}
