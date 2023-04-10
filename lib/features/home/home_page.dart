import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/routing/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.aiGame);
                },
                child: const Text('vs AI'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.game);
                },
                child: const Text('vs Human'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
