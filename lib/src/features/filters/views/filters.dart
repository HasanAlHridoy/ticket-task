import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersView extends ConsumerWidget {
  const FiltersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Center(
        child: Text('Filters'),
      ),
    );
  }
}
