// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:produtos_test/core/network/dio_client.dart' as _i962;
import 'package:produtos_test/core/network/interceptors/auth_interceptor.dart'
    as _i1002;
import 'package:produtos_test/core/network/interceptors/logging_interceptor.dart'
    as _i160;
import 'package:produtos_test/core/network/interceptors/retry_interceptor.dart'
    as _i293;
import 'package:produtos_test/core/storage/hive_service.dart' as _i73;
import 'package:produtos_test/core/storage/secure_storage_service.dart'
    as _i867;
import 'package:produtos_test/features/login/data/datasources/auth_local_datasource.dart'
    as _i360;
import 'package:produtos_test/features/login/data/repositories/auth_repository_impl.dart'
    as _i564;
import 'package:produtos_test/features/login/domain/repositories/auth_repository.dart'
    as _i466;
import 'package:produtos_test/features/login/domain/usecases/check_auth_usecase.dart'
    as _i306;
import 'package:produtos_test/features/login/domain/usecases/login_usecase.dart'
    as _i903;
import 'package:produtos_test/features/login/domain/usecases/logout_usecase.dart'
    as _i633;
import 'package:produtos_test/features/login/presentation/bloc/auth_bloc.dart'
    as _i623;
import 'package:produtos_test/features/produtos/data/datasources/busca_produtos_em_cache_hive_datasource.dart'
    as _i250;
import 'package:produtos_test/features/produtos/data/datasources/busca_produtos_na_api_datasource.dart'
    as _i1053;
import 'package:produtos_test/features/produtos/data/repositories/produtos_repository_impl.dart'
    as _i950;
import 'package:produtos_test/features/produtos/domain/repositories/produto_repository.dart'
    as _i211;
import 'package:produtos_test/features/produtos/domain/usecases/busca_detalhes_do_produto_usecase.dart'
    as _i266;
import 'package:produtos_test/features/produtos/domain/usecases/busca_produto_usecase.dart'
    as _i206;
import 'package:produtos_test/features/produtos/presentation/bloc/produto_bloc.dart'
    as _i916;
import 'package:produtos_test/features/produtos/presentation/bloc/produto_detail_bloc.dart'
    as _i506;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i293.RetryInterceptor>(() => _i293.RetryInterceptor());
    gh.lazySingleton<_i160.LoggingInterceptor>(
        () => _i160.LoggingInterceptor());
    gh.lazySingleton<_i73.HiveService>(() => _i73.HiveService());
    gh.lazySingleton<_i867.SecureStorageService>(
        () => _i867.SecureStorageService());
    gh.lazySingleton<_i360.AuthLocalDatasource>(
        () => _i360.AuthLocalDatasourceImpl(gh<_i867.SecureStorageService>()));
    gh.lazySingleton<_i1002.AuthInterceptor>(
        () => _i1002.AuthInterceptor(gh<_i867.SecureStorageService>()));
    gh.lazySingleton<_i466.AuthRepository>(
        () => _i564.AuthRepositoryImpl(gh<_i360.AuthLocalDatasource>()));
    gh.lazySingleton<_i250.BuscaProdutosEmCacheHiveDatasource>(
        () => _i250.ProductsLocalDatasourceImpl(gh<_i73.HiveService>()));
    gh.lazySingleton<_i962.DioClient>(() => _i962.DioClient(
          gh<_i1002.AuthInterceptor>(),
          gh<_i160.LoggingInterceptor>(),
          gh<_i293.RetryInterceptor>(),
        ));
    gh.lazySingleton<_i1053.BuscaProdutosNaApiDatasource>(
        () => _i1053.ProductsRemoteDatasourceImpl(gh<_i962.DioClient>()));
    gh.lazySingleton<_i306.CheckAuthUseCase>(
        () => _i306.CheckAuthUseCase(gh<_i466.AuthRepository>()));
    gh.lazySingleton<_i903.LoginUseCase>(
        () => _i903.LoginUseCase(gh<_i466.AuthRepository>()));
    gh.lazySingleton<_i633.LogoutUseCase>(
        () => _i633.LogoutUseCase(gh<_i466.AuthRepository>()));
    gh.factory<_i623.AuthBloc>(() => _i623.AuthBloc(
          gh<_i903.LoginUseCase>(),
          gh<_i633.LogoutUseCase>(),
          gh<_i306.CheckAuthUseCase>(),
        ));
    gh.lazySingleton<_i211.ProdutoRepository>(
        () => _i950.ProdutosRepositoryImpl(
              gh<_i1053.BuscaProdutosNaApiDatasource>(),
              gh<_i250.BuscaProdutosEmCacheHiveDatasource>(),
            ));
    gh.lazySingleton<_i206.BuscaProdutoUsecase>(
        () => _i206.BuscaProdutoUsecase(gh<_i211.ProdutoRepository>()));
    gh.lazySingleton<_i266.BuscaDetalhesDoProdutoUsecase>(() =>
        _i266.BuscaDetalhesDoProdutoUsecase(gh<_i211.ProdutoRepository>()));
    gh.factory<_i916.ProductsBloc>(
        () => _i916.ProductsBloc(gh<_i206.BuscaProdutoUsecase>()));
    gh.factory<_i506.ProductDetailBloc>(() =>
        _i506.ProductDetailBloc(gh<_i266.BuscaDetalhesDoProdutoUsecase>()));
    return this;
  }
}
