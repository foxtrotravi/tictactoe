import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/providers/coins/coins_provider.dart';

class CoinsWidget extends ConsumerWidget {
  const CoinsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Coin(),
        const SizedBox(width: 8),
        Text(
          ref.watch(coinsProvider).toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class Coin extends StatelessWidget {
  const Coin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.amber,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orange,
        ),
        height: 25,
        width: 25,
        alignment: Alignment.center,
        child: const Icon(
          FeatherIcons.dollarSign,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
