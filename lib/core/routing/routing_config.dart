import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/errors/error_page.dart';
import 'package:tictactoe/core/routing/routes.dart';
import 'package:tictactoe/features/index.dart';

final routerConfig = GoRouter(
  initialLocation: Routes.splash,
  errorBuilder: (_, __) => const ErrorPage(),
  routes: [
    GoRoute(
      path: Routes.splash,
      name: Routes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.onboarding,
      name: Routes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: Routes.home,
      name: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Routes.game,
      name: Routes.game,
      builder: (context, state) => const GamePage(),
    ),
  ],
);
