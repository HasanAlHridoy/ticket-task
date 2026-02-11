import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FiltersNotifier = NotifierProvider<FiltersProvider, void>;

final filtersProvider = FiltersNotifier(FiltersProvider.new);

class FiltersProvider extends Notifier<void> {
  @override
  void build() {
    debugPrint('FiltersProvider');
  }
}
