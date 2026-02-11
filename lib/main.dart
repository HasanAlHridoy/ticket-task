import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gian_ticket_task/src/core/router/go_router.export.dart';
import 'package:gian_ticket_task/src/core/utils/extensions/context.dart';
import 'package:gian_ticket_task/src/core/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  runApp(const ProviderScope(child: MyApp()));
}

void configEasyLoading(BuildContext context) {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.transparent
    ..boxShadow = const <BoxShadow>[]
    ..indicatorColor = Colors.teal
    ..progressColor = Colors.teal
    ..textColor = Colors.white
    ..textStyle = const TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)
    ..dismissOnTap = false
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withValues(alpha: 0.8)
    ..indicatorWidget = SizedBox(
      height: 40.h,
      width: 40.w,
      child: CircularProgressIndicator(color: context.theme.scaffoldBackgroundColor, strokeWidth: 2),
    )
    ..indicatorType = EasyLoadingIndicatorType.spinningCircle;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: ref.watch(goRouterProvider),
        title: 'Tickets',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(
          builder: (context, child) {
            configEasyLoading(context);

            return child!;
          },
        ),
      ),
    );
  }
}
