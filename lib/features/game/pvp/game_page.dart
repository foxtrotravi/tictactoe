import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/core/constants/constants.dart';
import 'package:tictactoe/core/enums/enums.dart';
import 'package:tictactoe/core/keys/keys.dart';
import 'package:tictactoe/core/providers/board/board_provider.dart';
import 'package:tictactoe/core/providers/coins/coins_provider.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/utils/utils.dart';
import 'package:tictactoe/core/widgets/coins.dart';
import 'package:tictactoe/core/widgets/custom_app_bar.dart';
import 'package:tictactoe/core/widgets/game_button.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({
    super.key,
    required this.boardId,
  });
  final int boardId;

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  bool isGameOver = false;
  late SharedPreferences sharedPreferences;
  var gamePlayed = 0;
  double left = 0, top = 0;
  Offset? to;
  bool showCoins = false;

  @override
  void initState() {
    super.initState();
    final _ = ref.refresh(gameProvider);
  }

  @override
  Widget build(BuildContext context) {
    sharedPreferences = ref.watch(sharedPreferencesProvider).value!;
    final boards = ref
        .watch(boardsProvider)
        .where((board) => !board.isLocked)
        .toList()
        .reversed
        .toList();

    ref.listen(
      gameProvider,
      (previous, next) {
        checkWinner(context, next.gameState);
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppbar(),
            Positioned(
              right: 20,
              bottom: 10,
              child: Row(
                children: [
                  Text(
                    showText(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  Visibility(
                    visible: gamePlayed != 0,
                    child: Opacity(
                      opacity: (gamePlayed % 5) * 0.25,
                      child: Container(
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
                          onPressed: (gamePlayed % 4) != 0
                              ? null
                              : () async {
                                  gamePlayed = 0;
                                  setState(() {});
                                  // increase coins
                                  var coins =
                                      sharedPreferences.getInt(kCoins) ?? 0;
                                  final cashback =
                                      boards[widget.boardId].cashback;
                                  coins += cashback;
                                  await sharedPreferences.setInt(kCoins, coins);
                                  ref.read(coinsProvider.notifier).state +=
                                      cashback;
                                  initCoinsPath();
                                  playCoinAnimation();
                                  setState(() {});
                                },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return Board(
                      gameState: ref.watch(gameProvider).gameState,
                      gradientColors: boards[widget.boardId].gradientColors,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: GameButton(
                    color: boards[widget.boardId].gradientColors.first,
                    onPressed: () {
                      final _ = ref.refresh(gameProvider);
                      isGameOver = false;
                    },
                    child: const Text('Restart'),
                  ),
                ),
              ],
            ),
            for (var i = 0; i < kNumberOfCoins; i++)
              AnimatedPositioned(
                height: 30,
                width: 30,
                top: top == 0
                    ? MediaQuery.of(context).size.height + Random().nextInt(100)
                    : top,
                left: left == 0
                    ? (MediaQuery.of(context).size.width) * (i / kNumberOfCoins)
                    : left,
                duration: Duration(
                  milliseconds: 500 + Random().nextInt(500),
                ),
                curve: Curves.easeOutCirc,
                onEnd: () {
                  if (i == kNumberOfCoins - 1) {
                    resetCoinAnimation();
                    setState(() {});
                  }
                },
                child: Visibility(
                  visible: showCoins,
                  child: const Coin(),
                ),
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

  // Need to find location of widget as it can vary when coins increase or
  // decrease
  void initCoinsPath() {
    final toWidget = toCoinKey.currentContext?.findRenderObject() as RenderBox?;
    if (toWidget == null) return;
    to = toWidget.localToGlobal(Offset.zero);
  }

  void playCoinAnimation() {
    toggleCoins(true);
    top = to!.dy - 46;
    left = to!.dx;
  }

  void toggleCoins(bool show) {
    showCoins = show;
  }

  void resetCoinAnimation() {
    toggleCoins(false);
    top = left = 0;
  }

  String showText() {
    if (gamePlayed == 4) {
      return 'Claim your gift';
    }
    return '${gamePlayed % 5} / 4';
  }
}
