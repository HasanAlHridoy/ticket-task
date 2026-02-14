part of 'go_router.export.dart';

final goNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.homeRoute,
    // initialLocation: AppRoutes.onboardingScreenOneRoute,
    navigatorKey: goNavigatorKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(path: AppRoutes.filters, name: FiltersView.name, builder: (_, _) => FiltersView()),

      ShellRoute(
        builder: (context, state, child) {
          return CustomBottomNavBar(child: child);
        },

        routes: [
          GoRoute(path: AppRoutes.contacts, name: ContacsView.name, builder: (_, _) => ContacsView()),
          GoRoute(path: AppRoutes.profile, name: ProfileView.name, builder: (_, _) => ProfileView()),
          GoRoute(path: AppRoutes.homeRoute, name: HomeView.name, builder: (_, _) => HomeView()),
        ],
      ),
    ],
  );
});
