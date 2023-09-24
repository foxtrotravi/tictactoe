import 'dart:math';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/core/providers/board/board_provider.dart';
import 'package:tictactoe/core/providers/coins/coins_provider.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/routing/routes.dart';
import 'package:tictactoe/core/widgets/coins.dart';
import 'package:tictactoe/core/widgets/game_button.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Color color;
  int currentPage = 0;
  late SharedPreferences sharedPreferences;
  int shopBoardIndex = 0;

  @override
  void initState() {
    color = Colors.indigo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dimension = min(width, height);

    final boards = ref
        .watch(boardsProvider)
        .where((board) => !board.isLocked)
        .toList()
        .reversed
        .toList();

    calculateBoard(ref);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tic Tac ',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RandomTextReveal(
                              text: 'Toe',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              duration: Duration(
                                seconds: 1,
                                milliseconds: 250,
                              ),
                              randomString: 'xo',
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: dimension * 0.7,
                            width: width,
                            child: Consumer(
                              builder: (context, ref, child) {
                                return PageView.builder(
                                  itemCount: boards.length,
                                  onPageChanged: (int index) {
                                    setState(() {
                                      currentPage = index;
                                    });
                                  },
                                  controller:
                                      PageController(viewportFraction: 0.7),
                                  pageSnapping: true,
                                  itemBuilder: (context, index) {
                                    return IgnorePointer(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Board(
                                          gradientColors:
                                              boards[index].gradientColors,
                                          gameState:
                                              GameState.initial().gameState,
                                          dimension: dimension * 0.7,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: IgnorePointer(
                                child: Board(
                                  gradientColors: const [
                                    Colors.blue,
                                    Colors.indigo
                                  ],
                                  gameState: GameState.initial().gameState,
                                  dimension: dimension * 0.7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        GameButton(
                          color: boards[currentPage].gradientColors.first,
                          onPressed: () async {
                            context.pushNamed(
                              Routes.aiGame,
                              params: {'boardId': '$currentPage'},
                            );
                          },
                          child: const Text('vs AI'),
                        ),
                        const SizedBox(height: 20),
                        GameButton(
                          color: boards[currentPage].gradientColors.first,
                          onPressed: () {
                            context.pushNamed(
                              Routes.game,
                              params: {'boardId': '$currentPage'},
                            );
                          },
                          child: const Text('vs Human'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                Routes.shop,
                params: {'shopBoardIndex': '$shopBoardIndex'},
              );
            },
            icon: const Icon(FeatherIcons.shoppingCart),
          ),
          const Spacer(),
          const CoinsWidget(),
        ],
      ),
    );
  }

  void calculateBoard(WidgetRef ref) {
    final boards = ref.watch(boardsProvider);

    for (int i = 0; i < boards.length; i++) {
      if (boards[i].isLocked) {
        shopBoardIndex = i;
        break;
      }
    }

    setState(() {});
  }
}
