import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:produtos_test/features/produtos/presentation/pages/pagina_produto.dart';
import 'package:produtos_test/features/produtos/presentation/pages/produto_detalhes_page.dart';
import '../../core/storage/secure_storage_service.dart';
import '../../features/login/presentation/pages/login_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/produtos',
    redirect: (BuildContext context, GoRouterState state) async {
      final secureStorage = SecureStorageService();

      final token = await secureStorage.readToken();

      final isLogged = token != null;

      final isGoingToLogin = state.fullPath == '/login';

      // não autenticado
      if (!isLogged && !isGoingToLogin) {
        return '/login';
      }

      // token salvo no cache
      if (isLogged && isGoingToLogin) {
        return '/produtos';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/produtos',
        name: 'produtos',
        builder: (context, state) {
          return const PaginaProduto();
        },
      ),
      GoRoute(
        path: '/produtos/:id',
        name: 'produtos-detalhes',
        builder: (context, state) {
          final id = int.parse(
            state.pathParameters['id']!,
          );

          return DetalhesDoProduto(
            productId: id,
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Erro'),
        ),
        body: const Center(
          child: Text('Página não encontrada'),
        ),
      );
    },
  );
}
