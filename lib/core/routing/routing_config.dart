import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/errors/error_page.dart';
import 'package:tictactoe/core/routing/routes.dart';
import 'package:tictactoe/features/index.dart';

final routerConfig = GoRouter(
  initialLocation: Routes.splashRoute,
  errorBuilder: (_, __) => const ErrorPage(),
  routes: [
    GoRoute(
      path: Routes.splashRoute,
      name: Routes.splashRoute,
      builder: (context, state) => const SplashPage(),
    ),
  ],
);
