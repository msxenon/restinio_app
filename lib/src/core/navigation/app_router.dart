import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/navigation/wolt_modal_page.dart';
import 'package:restinio_app/src/features/authentication/presentation/authentication_screen.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/food/presentation/food_screen.dart';
import 'package:restinio_app/src/features/home/presentation/home_screen.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/table_reservation_tab.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/table_reservation_screen.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_details_content.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_reservation_modal_content.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
part 'app_router.g.dart';

class AppRouter {
  static AppRouter get instance => DependenciesContainer.get<AppRouter>();
  GoRouter? _goRouterInstance;
  GoRouter get router => _getRouter();

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  String? _lastPathBeforeAuthentication;
  final String _initialLocation = FoodTabRoute().location;
  final String _authenticationPath = AuthenticationRoute().location;
  GoRouter _getRouter() {
    _goRouterInstance ??= GoRouter(
      navigatorKey: rootNavigatorKey,
      routes: $appRoutes,
      initialLocation: _initialLocation,
      redirect: (BuildContext context, GoRouterState state) async {
        final authState = context.read<AuthenticationCubit>().state;
        final isAuthenticated = authState.data is Authenticated;
        final isCurrentPathToAuthenticationScreen =
            state.matchedLocation == _authenticationPath;

        String? redirectPath;
        if (!isAuthenticated && !isCurrentPathToAuthenticationScreen) {
          _lastPathBeforeAuthentication = state.matchedLocation;
          redirectPath = _authenticationPath;
        } else if (isAuthenticated && isCurrentPathToAuthenticationScreen) {
          redirectPath = _lastPathBeforeAuthentication ?? _initialLocation;
          _lastPathBeforeAuthentication = null;
        }

        return redirectPath;
      },
    );
    return _goRouterInstance!;
  }
}

@TypedGoRoute<AuthenticationRoute>(
  path: '/auth',
)
class AuthenticationRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AuthenticationScreen();
}

@TypedStatefulShellRoute<HomeShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<TabsData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<FoodTabRoute>(path: '/'),
      ],
    ),
    TypedStatefulShellBranch<TabsData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TableTabRoute>(path: '/tables'),
      ],
    ),
  ],
)
class HomeShellRoute extends StatefulShellRouteData {
  const HomeShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return HomeScreen(
      navigationShell,
      key: Key(state.uri.toString()),
    );
  }
}

class TabsData extends StatefulShellBranchData {}

class FoodTabRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FoodScreen();
  }
}

class TableTabRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SecondTabScreen();
  }
}

@TypedGoRoute<TableReservationRoute>(
  path: '/table_reservation/:date',
  routes: [
    TypedGoRoute<TableDetailsRoute>(path: 'table_details/:tableId'),
  ],
)
class TableReservationRoute extends GoRouteData {
  final String date;

  TableReservationRoute({required this.date});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final milliseconds = int.parse((state.pathParameters['date'] as String));
    final selectedDateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return TableReservationScreen(selectedDateTime);
  }
}

class TableDetailsRoute extends GoRouteData {
  final String tableId;
  final int date;
  TableDetailsRoute({required this.tableId, required this.date});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return WoltModalPage(
      key: state.pageKey,
      pageListBuilderNotifier: ValueNotifier(
        (context) {
          return [
            SliverWoltModalSheetPage(
              isTopBarLayerAlwaysVisible: true,
              topBarTitle: const Text('Table Details'),
              mainContentSliversBuilder: (context) => [
                SliverToBoxAdapter(
                  child: TableDetailsContent(
                    tableId: tableId,
                    date: date,
                    onNavigateToReservation: () =>
                        WoltModalSheet.of(context).showNext(),
                  ),
                ),
              ],
            ),
            SliverWoltModalSheetPage(
              isTopBarLayerAlwaysVisible: true,
              topBarTitle: const Text('Table Reservation'),
              hasTopBarLayer: true,
              mainContentSliversBuilder: (context) => [
                SliverToBoxAdapter(
                  child: TableReservationModalContent(
                      tableId: tableId, date: date),
                ),
              ],
            )
          ];
        },
      ),
    );
  }
}
