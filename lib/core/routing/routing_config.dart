import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/errors/error_page.dart';
import 'package:tictactoe/core/routing/routes.dart';
import 'package:tictactoe/features/index.dart';
import 'package:tictactoe/features/shop/shop_page.dart';

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
      path: '${Routes.game}/:boardId',
      name: Routes.game,
      builder: (context, state) => GamePage(
        boardId: int.parse(state.params['boardId'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '${Routes.aiGame}/:boardId',
      name: Routes.aiGame,
      builder: (context, state) => AIGamePage(
        boardId: int.parse(state.params['boardId'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '${Routes.shop}/:shopBoardIndex',
      name: Routes.shop,
      builder: (context, state) => ShopPage(
        boardIndex: int.parse(state.params['shopBoardIndex'] ?? '0'),
      ),
    ),
  ],
);
