import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';
import 'package:restinio_app/src/features/food/presentation/blocs/food_screen_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestinioApp extends StatelessWidget {
  const RestinioApp({super.key});

  @override
  Widget build(BuildContext context) {
    const theme = CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.primarySurface,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.onSurface,
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
        BlocProvider<FoodScreenBloc>(
          create: (context) => FoodScreenBloc(FoodRepository.instance),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CupertinoApp.router(
          routerConfig: router,
          title: 'Restinio',
          theme: theme,
          builder: (context, child) {
            return SkeletonizerConfig(
              data: SkeletonizerConfigData(
                enableSwitchAnimation: true,
                ignoreContainers: true,
                effect: ShimmerEffect(
                  baseColor: AppColors.secondaryOnSurface.withOpacity(0.3),
                  highlightColor: theme.scaffoldBackgroundColor,
                ),
              ),
              child: child ?? const SizedBox(),
            );
          },
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('en', 'US'),
          ],
        ),
      ),
    );
  }
}
