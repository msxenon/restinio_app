import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  static const String path = '/authentication_screen';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationCubit>().login();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: AsyncBlocBuilder<AuthenticationCubit, AuthenticationState>(
        (context, state) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You are authenticated!'),
              ],
            ),
          );
        },
        errorStateWidgetBuilder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                CupertinoButton(
                  onPressed: () {
                    context.read<AuthenticationCubit>().login();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
