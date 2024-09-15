// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef BlocDataWidgetBuilder<S> = Widget Function(
  BuildContext context,
  S state,
);

class AsyncBlocBuilder<B extends StateStreamable<AsyncState<S>>,
    S extends Object> extends StatelessWidget {
  const AsyncBlocBuilder(
    this.dataWidgetBuilder, {
    this.errorStateWidgetBuilder,
    this.dummyLoadingState,
    super.key,
  });

  // Used for the shimmer loading state effect
  final S? dummyLoadingState;
  final BlocDataWidgetBuilder<S> dataWidgetBuilder;
  final BlocDataWidgetBuilder<AsyncStateFailure>? errorStateWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, AsyncState<S>>(
      builder: (context, asyncState) {
        switch (asyncState) {
          case AsyncStateLoading():
            return dummyLoadingState != null
                ? Skeletonizer(
                    child: dataWidgetBuilder(context, dummyLoadingState!),
                  )
                : const Center(child: CupertinoActivityIndicator());
          case AsyncStateData(data: S data):
            return dataWidgetBuilder(context, data);
          case AsyncStateFailure(message: String message):
            return errorStateWidgetBuilder?.call(context, asyncState) ??
                Center(child: Text(message));
        }
      },
    );
  }
}
