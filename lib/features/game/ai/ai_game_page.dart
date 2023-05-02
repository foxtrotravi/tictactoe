import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/core/constants/constants.dart';
import 'package:tictactoe/core/enums/enums.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/utils/utils.dart';
import 'package:tictactoe/core/widgets/game_button.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class AIGamePage extends ConsumerStatefulWidget {
  const AIGamePage({super.key});

  @override
  ConsumerState<AIGamePage> createState() => _AIGamePageState();
}

class _AIGamePageState extends ConsumerState<AIGamePage> {
  bool isGameOver = false;
  var gamePlayed = 0;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    final _ = ref.refresh(gameProvider);
  }

  @override
  Widget build(BuildContext context) {
    sharedPreferences = ref.watch(sharedPreferencesProvider).value!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 20,
              right: 20,
              top: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  Text('${sharedPreferences.getInt(kCoins) ?? 0}'),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 10,
              child: gamePlayed != 4
                  ? CircularProgressIndicator(
                      color: Colors.pink,
                      backgroundColor: Colors.red[200],
                      value: 0.25 * gamePlayed,
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink,
                            Colors.red,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.card_giftcard,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          gamePlayed = 0;
                          setState(() {});
                          // increase coins
                          var coins = sharedPreferences.getInt(kCoins) ?? 0;
                          coins += 100;
                          await sharedPreferences.setInt(kCoins, coins);
                          setState(() {});
                        },
                      ),
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    ref.listen(
                      gameProvider,
                      (previous, next) {
                        checkWinner(context, next.gameState);
                      },
                    );
                    return Board(
                      isAi: true,
                      gameState: ref.watch(gameProvider).gameState,
                      gradientColors: const [
                        Colors.indigo,
                        Colors.blue,
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: GameButton(
                    onPressed: () {
                      final _ = ref.refresh(gameProvider);
                      isGameOver = false;
                    },
                    child: const Text('Restart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void checkWinner(BuildContext context, List<List<Player>> gameState) {
    final winner = gameWinner(gameState);
    late String player;
    if (winner != GameWinner.none) {
      switch (winner) {
        case GameWinner.x:
          player = 'X wins';
          break;
        case GameWinner.o:
          player = 'O wins';
          break;
        case GameWinner.draw:
          player = 'Game Draw';
          break;
        default:
          break;
      }

      if (!isGameOver) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(player),
          ),
        );
        gamePlayed = (gamePlayed + 1) % 5;
        setState(() {});
        Timer(
          const Duration(seconds: 2),
          () {
            final _ = ref.refresh(gameProvider);
            isGameOver = false;
          },
        );
        isGameOver = true;
      }
    }
  }
}
