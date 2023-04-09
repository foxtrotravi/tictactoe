import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/constants/constants.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/routing/routes.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      sharedPreferencesProvider,
      (prev, current) async {
        final sharedPrefs = current.value;
        if (sharedPrefs == null) return;
        if (sharedPrefs.getBool(kIsNewUser) ?? true) {
          context.goNamed(Routes.onboarding);
        } else {
          context.goNamed(Routes.home);
        }
      },
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Icon(Icons.home),
      ),
    );
  }
}
