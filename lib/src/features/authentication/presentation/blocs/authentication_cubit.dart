import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AsyncState<AuthenticationState>> {
  final AuthenticationRepository _authRepository;
  final AppRouter _appRouter;
  AuthenticationCubit(this._authRepository, this._appRouter)
      : super(const AsyncStateLoading());

  void login() {
    unawaited(_execLogin());
  }

  Future<void> _execLogin() async {
    AsyncState<AuthenticationState>? newState;
    try {
      emit(const AsyncStateLoading());
      final hasLoggedIn = await _authRepository.loginAnonymosly();

      newState = AsyncStateData(
        hasLoggedIn ? const Authenticated() : const Unauthenticated(),
      );
    } catch (e) {
      newState = AsyncStateFailure(e.toString());
    } finally {
      emit(newState ?? const AsyncStateFailure('Unknown error'));
      _appRouter.refresh();
    }
  }
}
