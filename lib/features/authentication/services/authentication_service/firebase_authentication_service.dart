import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:injectable/injectable.dart';
import 'package:astrolex/app/get_it.dart';
import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/features/authentication/services/authentication_service/fast_authentication_service.dart';
import 'package:astrolex/firebase_options.dart';

@Singleton(as: FastAuthenticationService)
class FirebaseAuthenticationService extends FastAuthenticationService {
  @override
  bool get loggedIn => FirebaseAuth.instance.currentUser != null;

  @override
  String? get id => FirebaseAuth.instance.currentUser?.uid;

  @override
  String? get email => FirebaseAuth.instance.currentUser?.email;

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget forgotPasswordScreen(String? email) {
    return ForgotPasswordScreen(email: email);
  }

  @override
  Widget profileScreen() {
    return ProfileScreen(
      showMFATile: false,
      avatar: const SizedBox.shrink(),
      appBar: AppBar(title: const Text('Profile')),
      actions: [
        SignedOutAction((context) {
          router.pushAndPopUntil(
            const SignInRoute(),
            predicate: (route) => false,
          );
        }),
      ],
    );
  }

  @override
  Widget registerScreen() {
    return RegisterScreen(
      providers: [EmailAuthProvider()],
      headerBuilder: (context, constraints, shrinkOffset) {
        return authHeader();
      },
      sideBuilder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(child: Image.asset('assets/images/logo.png')),
            const SizedBox(height: 24),
            const Text('astrolex'),
          ],
        );
      },
      actions: [
        AuthStateChangeAction<UserCreated>((context, state) async {
          await createAccountNavigation();
        }),
      ],
    );
  }

  @override
  Widget signInScreen() {
    return SignInScreen(
      providers: [EmailAuthProvider()],
      headerBuilder: (context, constraints, shrinkOffset) {
        return authHeader();
      },
      sideBuilder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 24),
            const Text('astrolex'),
          ],
        );
      },
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          signInNavigation();
        }),
        AuthStateChangeAction<UserCreated>((context, state) async {
          await createAccountNavigation();
        })
      ],
    );
  }

  Widget authHeader() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: [
            Expanded(flex: 3, child: ClipOval(child: Image.asset('assets/images/logo.png'))),
            const Flexible(child: gap12),
            Flexible(
                child: Text(
              'AstroLex',
              style: context.bodyMedium.bold,
            ))
          ],
        ),
      );
    });
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
