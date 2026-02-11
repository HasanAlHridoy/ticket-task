import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ContatcsNotifier = NotifierProvider<ContatcsProvider, void>;

final contatcsProvider = ContatcsNotifier(ContatcsProvider.new);

class ContatcsProvider extends Notifier<void> {
  @override
  void build() {
    debugPrint('ContatcsProvider');
  }
}
