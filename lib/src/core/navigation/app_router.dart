import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/navigation/routes.dart';
import 'package:restinio_app/src/core/presentation/on_error_screen.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';

class AppRouter {
  static AppRouter get instance => DependenciesContainer.get<AppRouter>();
  GoRouter? _goRouterInstance;
  GoRouter get router => _getRouter();

  void refresh() {
    router.refresh();
  }

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  String? _lastPathBeforeAuthentication;
  final String _initialLocation = FirstTabRoute().location;
  final String _authenticationPath = AuthenticationRoute().location;
  GoRouter _getRouter() {
    _goRouterInstance ??= GoRouter(
      navigatorKey: rootNavigatorKey,
      routes: $appRoutes,
      initialLocation: _initialLocation,
      errorBuilder: (context, state) {
        return const OnErrorScreen();
      },
      redirect: (BuildContext context, GoRouterState state) async {
        final authState = context.read<AuthenticationCubit>().state;
        final isAuthenticated = authState.data is Authenticated;
        final isCurrentPathToAuthenticationScreen =
            state.matchedLocation == _authenticationPath;

        String? newRedirectionPath;
        if (!isAuthenticated && !isCurrentPathToAuthenticationScreen) {
          _lastPathBeforeAuthentication = state.matchedLocation;
          newRedirectionPath = _authenticationPath;
        } else if (isAuthenticated && isCurrentPathToAuthenticationScreen) {
          newRedirectionPath =
              _lastPathBeforeAuthentication ?? _initialLocation;
          _lastPathBeforeAuthentication = null;
        }

        return newRedirectionPath;
      },
    );
    return _goRouterInstance!;
  }
}
