import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/check_auth_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;

  AuthBloc(
    this.loginUseCase,
    this.logoutUseCase,
    this.checkAuthUseCase,
  ) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);

    on<LogoutRequested>(_onLogoutRequested);

    on<CheckAuthRequested>(_onCheckAuthRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await loginUseCase(
        email: event.email,
        password: event.password,
      );

      emit(AuthAuthenticated());
    } catch (_) {
      emit(
        AuthError(
          'Erro ao realizar login',
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await logoutUseCase();

    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckAuthRequested(
    CheckAuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isLogged = await checkAuthUseCase();

    if (isLogged) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
