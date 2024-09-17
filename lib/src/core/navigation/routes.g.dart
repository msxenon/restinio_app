// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $authenticationRoute,
      $homeShellRoute,
      $tableReservationStep2Route,
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
              factory: $FirstTabRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/tables',
              factory: $SecondTabRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

extension $FirstTabRouteExtension on FirstTabRoute {
  static FirstTabRoute _fromState(GoRouterState state) => FirstTabRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SecondTabRouteExtension on SecondTabRoute {
  static SecondTabRoute _fromState(GoRouterState state) => SecondTabRoute();

  String get location => GoRouteData.$location(
        '/tables',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tableReservationStep2Route => GoRouteData.$route(
      path: '/tr/:date',
      factory: $TableReservationStep2RouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'td/:tableId',
          factory: $TableReservationStep3RouteExtension._fromState,
        ),
      ],
    );

extension $TableReservationStep2RouteExtension on TableReservationStep2Route {
  static TableReservationStep2Route _fromState(GoRouterState state) =>
      TableReservationStep2Route(
        date: state.pathParameters['date']!,
      );

  String get location => GoRouteData.$location(
        '/tr/${Uri.encodeComponent(date)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TableReservationStep3RouteExtension on TableReservationStep3Route {
  static TableReservationStep3Route _fromState(GoRouterState state) =>
      TableReservationStep3Route(
        tableId: state.pathParameters['tableId']!,
        date: int.parse(state.pathParameters['date']!),
      );

  String get location => GoRouteData.$location(
        '/tr/${Uri.encodeComponent(date.toString())}/td/${Uri.encodeComponent(tableId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
