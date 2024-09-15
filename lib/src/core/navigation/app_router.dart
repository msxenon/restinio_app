import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/features/authentication/presentation/authentication_screen.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/food/presentation/food_screen.dart';
import 'package:restinio_app/src/features/home/presentation/home_screen.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/table_reservation_screen.dart';

class AppRouter {
  static AppRouter get instance => DependenciesContainer.get<AppRouter>();
  GoRouter? _goRouterInstance;
  GoRouter get router => _getRouter();

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static const _initialLocation = FoodScreen.path;
  static String? _lastPathBeforeAuthentication;

  GoRouter _getRouter() {
    _goRouterInstance ??= GoRouter(
      navigatorKey: rootNavigatorKey,
      redirect: (BuildContext context, GoRouterState state) async {
        final authState = context.read<AuthenticationCubit>().state;
        final isAuthenticated = authState.data is Authenticated;
        final isCurrentPathToAuthenticationScreen =
            state.matchedLocation == AuthenticationScreen.path;

        String? redirectPath;
        if (!isAuthenticated && !isCurrentPathToAuthenticationScreen) {
          _lastPathBeforeAuthentication = state.matchedLocation;
          redirectPath = AuthenticationScreen.path;
        } else if (isAuthenticated && isCurrentPathToAuthenticationScreen) {
          redirectPath = _lastPathBeforeAuthentication ?? _initialLocation;
          _lastPathBeforeAuthentication = null;
        }

        return redirectPath;
      },
      initialLocation: _initialLocation,
      routes: [
        GoRoute(
          name: AuthenticationScreen.path,
          path: AuthenticationScreen.path,
          builder: (_, __) => const AuthenticationScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return HomeScreen(
              navigationShell,
              key: Key(state.uri.toString()),
            );
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: FoodScreen.path,
                  path: FoodScreen.path,
                  builder: (context, state) => const FoodScreen(),
                ),
              ],
            ),
            StatefulShellBranch(routes: <RouteBase>[
              GoRoute(
                name: TableReservationScreen.path,
                path: TableReservationScreen.path,
                builder: (context, state) => const TableReservationScreen(),
              ),
            ])
          ],
        ),
      ],
    );

    return _goRouterInstance!;
  }
}
