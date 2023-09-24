import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/keys/keys.dart';
import 'package:tictactoe/core/widgets/coins.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          CoinsWidget(key: toCoinKey),
        ],
      ),
    );
  }
}
