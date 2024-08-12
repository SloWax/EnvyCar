import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginVM with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // credential 정보를 사용하여 로그인 처리
      print('Apple SignIn authorizationCode: ${credential.authorizationCode}');
      final token = credential.userIdentifier ?? "user";

      CarManager().setToken(token);
    } catch (e) {
      print('Apple SignIn Error: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // googleAuth.accessToken 및 googleAuth.idToken을 사용하여 로그인 처리
        print('Google SignIn accessToken: ${googleAuth.accessToken}');
        final token = googleUser.email;

        CarManager().setToken(token);
      }
    } catch (error) {
      print('Google SignIn Error: $error');
    }
  }
}
