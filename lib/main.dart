import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/routing/routing_config.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Tic Tac Toe - Blues',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: routerConfig,
      ),
    );
  }
}
