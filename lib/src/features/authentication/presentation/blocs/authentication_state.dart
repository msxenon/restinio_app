part of 'authentication_cubit.dart';

sealed class AsyncState<T> {
  const AsyncState();
}

class AsyncStateLoading<T> extends AsyncState<T> {
  const AsyncStateLoading() : super();
}

class AsyncStateData<T> extends AsyncState<T> {
  final T data;

  const AsyncStateData(this.data) : super();
}

class AsyncStateFailure<T> extends AsyncState<T> {
  final String message;

  const AsyncStateFailure(this.message) : super();
}

sealed class AuthenticationState {
  const AuthenticationState();
}

class Authenticated extends AuthenticationState {
  const Authenticated() : super();
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated() : super();
}


extension AsyncStateX<T> on AsyncState<T> {
  bool get isLoading => this is AsyncStateLoading<T>;
  bool get isData => this is AsyncStateData<T>;
  bool get isFailure => this is AsyncStateFailure<T>;
  T? get data =>  this is AsyncStateData<T> ? (this as AsyncStateData<T>).data : null;
}