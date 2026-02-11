import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContacsView extends ConsumerWidget {
  static const String name = 'contacts';
  const ContacsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacs'),
      ),
      body: Center(
        child: Text('Contacs'),
      ),
    );
  }
}
