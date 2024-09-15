import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';
import 'package:restinio_app/src/features/food/presentation/blocs/food_bloc.dart';
import 'package:restinio_app/src/features/food/presentation/food_screen.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/blocs/tables_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await DependenciesContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const theme = CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xff50AE5A),
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.black,
      ),
    );
    final router = AppRouter.instance.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
            AuthenticationRepository.instance,
            AppRouter.instance,
          ),
        ),
        BlocProvider<FoodBloc>(
          create: (context) => FoodBloc(FoodRepository.instance),
        ),
        BlocProvider<TablesCubit>(
          create: (context) => TablesCubit(TableRepository.instance),
        ),
      ],
      child: CupertinoApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        theme: theme,
        builder: (context, child) {
          return SkeletonizerConfig(
            data: SkeletonizerConfigData(
              enableSwitchAnimation: true,
              ignoreContainers: false,
              effect: ShimmerEffect(
                baseColor: Colors.grey[300]!,
                highlightColor: theme.scaffoldBackgroundColor,
              ),
            ),
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: CupertinoTheme.of(context).barBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: CupertinoTheme.of(context).barBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.circle),
              label: 'Food',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.table),
              label: 'Tables',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return IndexedStack(
            index: index,
            children: <Widget>[
              const FoodScreen(),
              Container(
                color: CupertinoColors.systemYellow,
              ),
            ],
          );
        },
      ),
    );
  }
}
