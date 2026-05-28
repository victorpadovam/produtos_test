import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:produtos_test/app/router/app_router.dart';
import 'package:produtos_test/core/app_localizations.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../domain/usecases/login_usecase.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import 'package:produtos_test/app/di/injection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        getIt<LoginUseCase>(),
        getIt(),
        getIt(),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            AppRouter.router.go('/produtos');
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            appBar: AppBar(
              title: Text('LOJA'),
            ),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Semantics(
                          label: 'Campo de e-mail',
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: context.l10n.email,
                              border: OutlineInputBorder(),
                            ),
                            validator: Validators.email,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Semantics(
                          label: 'Campo de senha',
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: context.l10n.password,
                              border: OutlineInputBorder(),
                            ),
                            validator: Validators.password,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    final isValid =
                                        _formKey.currentState?.validate() ??
                                            false;

                                    if (!isValid) {
                                      return;
                                    }

                                    context.read<AuthBloc>().add(
                                          LoginRequested(
                                            email: _emailController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
                                          ),
                                        );
                                  },
                            child: isLoading
                                ? const AppLoading()
                                : Text(
                                    context.l10n.login,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
