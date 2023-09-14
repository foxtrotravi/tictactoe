import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/constants/constants.dart';
import 'package:tictactoe/core/providers/index.dart';

final coinsProvider = StateProvider<int>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider).value;
  return sharedPrefs?.getInt(kCoins) ?? 0;
});
