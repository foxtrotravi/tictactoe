import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/constants/constants.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/routing/routes.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text('Onboarding'),
            ),
            ElevatedButton(
              onPressed: () => onPressed(context, ref),
              child: const Text('Home page'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPressed(BuildContext context, WidgetRef ref) async {
    context.goNamed(Routes.home);
    await ref.read(sharedPreferencesProvider).value!.setBool(kIsNewUser, false);
  }
}
