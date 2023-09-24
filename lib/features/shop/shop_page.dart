import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/core/constants/constants.dart';
import 'package:tictactoe/core/providers/board/board_provider.dart';
import 'package:tictactoe/core/providers/coins/coins_provider.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/widgets/custom_app_bar.dart';
import 'package:tictactoe/core/widgets/game_button.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({
    super.key,
    required this.boardIndex,
  });
  final int boardIndex;

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
  late final PageController _pageController;

  late SharedPreferences sharedPreferences;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 500),
    );

    _pageController = PageController(initialPage: widget.boardIndex);
  }

  @override
  Widget build(BuildContext context) {
    final boards = ref.watch(boardsProvider);
    sharedPreferences = ref.watch(sharedPreferencesProvider).value!;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: boards.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  final isLocked = ref.watch(
                    boardsProvider.select((boards) => boards[index].isLocked),
                  );

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IgnorePointer(
                        child: Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.6,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Stack(
                              children: [
                                Board(
                                  gradientColors: boards[index].gradientColors,
                                  gameState: boards[index].gameState,
                                ),
                                Visibility(
                                  visible: isLocked,
                                  child: _buildLock(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GameButton(
                            color: boards[index].gradientColors[0],
                            child: Text(isLocked
                                ? 'Buy ${boards[index].cost}'
                                : 'Purchased'),
                            onPressed: () async {
                              if (!isLocked) return;
                              final coins =
                                  ref.read(coinsProvider.notifier).state;

                              if (coins >= boards[index].cost) {
                                ref.read(coinsProvider.notifier).state =
                                    (coins - boards[index].cost);

                                sharedPreferences.setInt(
                                    kCoins, coins - boards[index].cost);
                              } else if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Not enough coins'),
                                  ),
                                );
                                return;
                              }

                              await sharedPreferences.setInt('board_$index', 1);

                              ref
                                  .read(boardsProvider.notifier)
                                  .buyBoard(id: boards[index].id);
                              setState(() {});
                              _confettiController.play();
                            },
                          ),
                          ConfettiWidget(
                            confettiController: _confettiController,
                            blastDirectionality: BlastDirectionality.explosive,
                            shouldLoop: false,
                            numberOfParticles: 35,
                            colors: const [
                              Colors.green,
                              Colors.blue,
                              Colors.pink,
                              Colors.orange,
                              Colors.purple
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            _buildPageControls(
              context: context,
              left: 20,
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
              ),
              iconData: FeatherIcons.chevronLeft,
            ),
            _buildPageControls(
              context: context,
              right: 20,
              onPressed: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
              ),
              iconData: FeatherIcons.chevronRight,
            ),
            const CustomAppbar(),
          ],
        ),
      ),
    );
  }

  Positioned _buildPageControls({
    required BuildContext context,
    required void Function() onPressed,
    required IconData iconData,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2,
      left: left,
      right: right,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(iconData),
      ),
    );
  }

  Widget _buildLock() {
    return Center(
      child: Transform.rotate(
        angle: -pi / 12,
        child: Icon(
          FeatherIcons.lock,
          size: 100,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }
}
