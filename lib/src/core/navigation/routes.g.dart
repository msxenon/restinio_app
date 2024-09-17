// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $authenticationRoute,
      $homeShellRoute,
      $foodDetailsRoute,
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
              path: '/table_reservations',
              factory: $SecondTabRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 's2/:date',
                  factory: $TableReservationStep2RouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 's3/:tableId',
                      name: 'xxxx',
                      factory: $TableReservationStep3RouteExtension._fromState,
                    ),
                  ],
                ),
              ],
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
        '/table_reservations',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TableReservationStep2RouteExtension on TableReservationStep2Route {
  static TableReservationStep2Route _fromState(GoRouterState state) =>
      TableReservationStep2Route(
        date: state.pathParameters['date']!,
      );

  String get location => GoRouteData.$location(
        '/table_reservations/s2/${Uri.encodeComponent(date)}',
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
        '/table_reservations/s2/${Uri.encodeComponent(date.toString())}/s3/${Uri.encodeComponent(tableId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $foodDetailsRoute => GoRouteData.$route(
      path: '/fd/:foodId',
      factory: $FoodDetailsRouteExtension._fromState,
    );

extension $FoodDetailsRouteExtension on FoodDetailsRoute {
  static FoodDetailsRoute _fromState(GoRouterState state) => FoodDetailsRoute(
        foodId: state.pathParameters['foodId']!,
      );

  String get location => GoRouteData.$location(
        '/fd/${Uri.encodeComponent(foodId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
