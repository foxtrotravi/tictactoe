import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/core/constants/constants.dart';
import 'package:tictactoe/core/providers/coins/coins_provider.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/routing/routes.dart';
import 'package:tictactoe/core/themes/theme.dart';
import 'package:tictactoe/features/onboarding/pages/index.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  int index = 0;
  int currentPage = 0;
  final pageController = PageController();
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    animateBoard();
    super.initState();
  }

  Future<void> animateBoard() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      index = (index + 1) % gradients.length;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    sharedPreferences = ref.watch(sharedPreferencesProvider).value!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  FirstOnboardingPage(index: index),
                  const SecondOnboardingPage(),
                  const ThirdOnboardingPage(),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: ElevatedButton(
                child: const Text('Next'),
                onPressed: () async {
                  pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    curve: Curves.easeIn,
                  );

                  if (pageController.page == 2) {
                    // await sharedPreferences.setInt(kCoins, 0);
                    // ref.read(coinsProvider.notifier).state += 250;
                    // if (mounted) {
                    //   context.go(Routes.home);
                    // }
                    onPressed(context, ref);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPressed(BuildContext context, WidgetRef ref) async {
    context.goNamed(Routes.home);
    await sharedPreferences.setBool(kIsNewUser, false);
    // Set default coins
    await sharedPreferences.setInt(kCoins, 250);
    ref.read(coinsProvider.notifier).state += 250;
  }
}
