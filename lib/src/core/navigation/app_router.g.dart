// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $authenticationRoute,
      $homeShellRoute,
      $tableReservationRoute,
    ];

RouteBase get $authenticationRoute => GoRouteData.$route(
      path: '/auth',
      factory: $AuthenticationRouteExtension._fromState,
    );

extension $AuthenticationRouteExtension on AuthenticationRoute {
  static AuthenticationRoute _fromState(GoRouterState state) =>
      AuthenticationRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeShellRoute => StatefulShellRouteData.$route(
      factory: $HomeShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/',
              factory: $FoodTabRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/tables',
              factory: $TableTabRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

extension $FoodTabRouteExtension on FoodTabRoute {
  static FoodTabRoute _fromState(GoRouterState state) => FoodTabRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TableTabRouteExtension on TableTabRoute {
  static TableTabRoute _fromState(GoRouterState state) => TableTabRoute();

  String get location => GoRouteData.$location(
        '/tables',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tableReservationRoute => GoRouteData.$route(
      path: '/table_reservation/:date',
      factory: $TableReservationRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'table_details/:tid',
          factory: $TableDetailsRouteExtension._fromState,
        ),
      ],
    );

extension $TableReservationRouteExtension on TableReservationRoute {
  static TableReservationRoute _fromState(GoRouterState state) =>
      TableReservationRoute(
        date: state.pathParameters['date']!,
      );

  String get location => GoRouteData.$location(
        '/table_reservation/${Uri.encodeComponent(date)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TableDetailsRouteExtension on TableDetailsRoute {
  static TableDetailsRoute _fromState(GoRouterState state) => TableDetailsRoute(
        tid: state.pathParameters['tid']!,
        date: int.parse(state.pathParameters['date']!),
      );

  String get location => GoRouteData.$location(
        '/table_reservation/${Uri.encodeComponent(date.toString())}/table_details/${Uri.encodeComponent(tid)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
