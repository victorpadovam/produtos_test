import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:produtos_test/features/login/domain/usecases/check_auth_usecase.dart';
import 'package:produtos_test/features/login/domain/usecases/login_usecase.dart';
import 'package:produtos_test/features/login/domain/usecases/logout_usecase.dart';
import 'package:produtos_test/features/login/presentation/bloc/auth_bloc.dart';
import 'package:produtos_test/features/login/presentation/bloc/auth_event.dart';
import 'package:produtos_test/features/login/presentation/bloc/auth_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockCheckAuthUseCase extends Mock implements CheckAuthUseCase {}

void main() {
  late AuthBloc bloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockCheckAuthUseCase mockCheckAuthUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockCheckAuthUseCase = MockCheckAuthUseCase();

    bloc = AuthBloc(
      mockLoginUseCase,
      mockLogoutUseCase,
      mockCheckAuthUseCase,
    );
  });

  blocTest<AuthBloc, AuthState>(
    'should emit loading and authenticated when login succeeds',
    build: () {
      when(
        () => mockLoginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        LoginRequested(
          email: 'test@test.com',
          password: '123456',
        ),
      );
    },
    expect: () => [
      AuthLoading(),
      AuthAuthenticated(),
    ],
  );
}
