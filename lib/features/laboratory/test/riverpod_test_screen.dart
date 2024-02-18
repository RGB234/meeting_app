import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonNotifier extends AutoDisposeAsyncNotifier<int> {
  late int count;
  @override
  FutureOr<int> build() {
    count = 5;
    return count;
  }

  Future<void> pressBtn() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));
    count++;
    print(count);
    state = AsyncData(count);
  }

  void refresh() {
    ref.invalidateSelf();
  }
}

final buttonProvider = AutoDisposeAsyncNotifierProvider<ButtonNotifier, int>(
  () => ButtonNotifier(),
);

// ###################### view ###################################
class RiverpodTestScreen extends ConsumerStatefulWidget {
  static String routePath = "/lab/test";
  static String routeName = "test";
  const RiverpodTestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RiverpodTestScreenState();
}

class _RiverpodTestScreenState extends ConsumerState<RiverpodTestScreen> {
  void _countUp() {
    ref.read(buttonProvider.notifier).pressBtn();
  }

  void _refresh() {
    ref.read(buttonProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(buttonProvider);
    final state = ref.watch(buttonProvider.notifier).state;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text("state.value: ${state.value}"),
              onPressed: () => _countUp(),
            ),
            TextButton(
              child: const Text("refresh"),
              onPressed: () => _refresh(),
            ),
          ],
        ),
      ),
    );
  }
}
