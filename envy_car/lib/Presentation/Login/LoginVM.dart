import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginVM with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<void> signInWithApple() async {
  //   try {
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     // credential 정보를 사용하여 로그인 처리
  //     print('Apple SignIn authorizationCode: ${credential.authorizationCode}');
  //     print('Apple SignIn email: ${credential.email}');
  //     print('Apple SignIn name: ${credential.givenName}');
  //   } catch (e) {
  //     print('Apple SignIn Error: $e');
  //   }
  // }

  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId:
              'com.example.envyCar', // Apple Developer Console에서 등록한 클라이언트 ID
          redirectUri: Uri.parse(
              'https://envycar-57c04.firebaseapp.com/__/auth/handler'), // Firebase에서 제공한 리디렉트 URI
        ),
      );

      // OAuthProvider를 사용하여 Firebase에 Apple 자격 증명을 전달합니다.
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      print(
          'Apple SignIn authorizationCode: ${appleCredential.authorizationCode}');
      print('Apple SignIn email: ${appleCredential.email}');
      print('Apple SignIn name: ${appleCredential.givenName}');

      // Firebase Auth에서 Apple 자격 증명으로 로그인합니다.
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on PlatformException catch (e) {
      print('Error during sign-in with Apple: $e');
      return null;
    } catch (e) {
      print('General error during sign-in with Apple: $e');
      return null;
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
      }
    } catch (error) {
      print('Google SignIn Error: $error');
    }
  }
}
