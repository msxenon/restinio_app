// import 'package:restinio_app/src/core/di/dependencies_container.dart';
// import 'package:restinio_app/src/core/navigation/app_router.dart';
// import 'package:restinio_app/src/features/table_reservation/data/models/table_model.dart';
// import 'package:restinio_app/src/features/table_reservation/presentation/table_reservation_screen.dart';
// import 'package:restinio_app/src/features/table_reservation/presentation/widgets/table_details.dart';

// class Navigation {
//   static Navigation get instance => DependenciesContainer.get<Navigation>();
//   final AppRouter _router;

//   Navigation(this._router);

//   // void goToTableReservation(DateTime datetime) {
//   //   _router.router.goNamed(
//   //     TableReservationScreen.path,
//   //     pathParameters: {
//   //       'datetime': datetime.millisecondsSinceEpoch.toString(),
//   //     },
//   //   );
//   // }

//   void goToInitialRoute() {
//     _router.router.go(AppRouter.instance.initialLocation);
//   }

//   void goToTableDetails(TableModel tableModel) {
//     _router.router.goNamed(
//       TableDetails.name,
//       pathParameters: {
//         'cid': tableModel.table.id.toString(),
//       },
//     );
//   }
// }
