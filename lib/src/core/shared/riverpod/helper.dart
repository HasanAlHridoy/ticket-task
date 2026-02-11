import 'package:flutter/material.dart';
import 'package:gian_ticket_task/src/core/shared/button/app_button.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/gap.dart';
import 'package:go_router/go_router.dart';

Widget riverpodError(e, _) => KError(e);

Widget riverpodLoading() => const KLoading();

Widget riverpodErrorSliver(e, _) => SliverToBoxAdapter(child: KError(e));

Widget riverpodLoadingSliver() => const SliverToBoxAdapter(child: KLoading());

class KLoading extends StatelessWidget {
  const KLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.scaffoldBackgroundColor,
      child: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(color: context.theme.scaffoldBackgroundColor, strokeWidth: 2),
        ),
      ),
    );
  }
}

class KError extends StatelessWidget {
  const KError(this.e, {super.key});

  final dynamic e;

  @override
  Widget build(BuildContext context) {
    // log(e);
    return Material(
      color: context.theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, size: 20.0, color: Colors.red),
              const SizedBox(height: 5.0),
              Text(
                e.toString(),
                style: context.text.bodyMedium?.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              16.ph,
              // back button
              AppButton.outlined(child: Text('Back'), onPressed: () => context.pop()),
            ],
          ),
        ),
      ),
    );
  }
}
