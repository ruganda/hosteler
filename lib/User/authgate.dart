import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hostel_booking/User/index.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            showAuthActionSwitch: true,
            headerBuilder: (context, constraints, _) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(''
                      'data:image/jpeg;base64,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'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome to the shopping verse! Please sign in to continue.'
                      : 'Welcome to shopping verse! Please create an account to continue',
                ),
              );
            },
            //footer
            footerBuilder: (context, _) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions of our shopping services.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            providerConfigs: const [
              EmailProviderConfiguration(),
              // GoogleProviderConfiguration(
              //   clientId: '...',
              // ),
            ],
          );
        }
        return const Index();
        
      },
    );
  }
}
