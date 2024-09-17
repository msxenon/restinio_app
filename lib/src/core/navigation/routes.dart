import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';
import 'package:restinio_app/src/core/navigation/wolt_modal_page.dart';
import 'package:restinio_app/src/features/authentication/presentation/authentication_screen.dart';
import 'package:restinio_app/src/features/food/presentation/food_details_screen.dart';
import 'package:restinio_app/src/features/food/presentation/food_screen.dart';
import 'package:restinio_app/src/features/home/presentation/home_screen.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/table_reservation_screen_step_1.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/table_reservation_screen_step_2.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_details_modal_content.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_reservation_modal_content.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

part 'routes.g.dart';

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
        TypedGoRoute<FirstTabRoute>(path: '/'),
      ],
    ),
    TypedStatefulShellBranch<TabsData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SecondTabRoute>(path: '/tables'),
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

class FirstTabRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FoodScreen();
  }
}

@TypedGoRoute<FoodDetailsRoute>(path: '/fd/:foodId')
class FoodDetailsRoute extends GoRouteData {
  final String foodId;

  FoodDetailsRoute({required this.foodId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FoodDetailsScreen(foodId);
  }
}

class SecondTabRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TableReservationScreenStep1();
  }
}

@TypedGoRoute<TableReservationStep2Route>(
  path: '/tr/:date',
  routes: [
    TypedGoRoute<TableReservationStep3Route>(path: 'td/:tableId'),
  ],
)
class TableReservationStep2Route extends GoRouteData {
  final String date;

  TableReservationStep2Route({required this.date});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final milliseconds = int.parse((state.pathParameters['date'] as String));
    final selectedDateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return TableReservationScreenStep2(selectedDateTime);
  }
}

class TableReservationStep3Route extends GoRouteData {
  final String tableId;
  final int date;
  TableReservationStep3Route({required this.tableId, required this.date});

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
              leadingNavBarWidget: CupertinoButton(
                child: const Icon(CupertinoIcons.xmark),
                onPressed: () => AppRouter.instance.pop(),
              ),
              mainContentSliversBuilder: (context) => [
                SliverToBoxAdapter(
                  child: TableDetailsModalContent(
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
              leadingNavBarWidget: CupertinoNavigationBarBackButton(
                onPressed: () => WoltModalSheet.of(context).showPrevious(),
              ),
              mainContentSliversBuilder: (context) => [
                SliverToBoxAdapter(
                  child: TableReservationModalContent(
                    tableId: tableId,
                    date: date,
                  ),
                ),
              ],
            )
          ];
        },
      ),
    );
  }
}
