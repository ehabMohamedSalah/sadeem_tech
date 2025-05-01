// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasource_contract/auth_datasource_contract.dart' as _i829;
import '../../data/datasource_contract/product_datasource_contract.dart'
    as _i920;
import '../../data/datasource_impl/auth_datasource_impl.dart' as _i422;
import '../../data/datasource_impl/product_datasource_impl.dart' as _i246;
import '../../data/repo_impl/auth_repo_impl.dart' as _i540;
import '../../data/repo_impl/product_repo_impl.dart' as _i650;
import '../../domain/repo_contract/auth_repo_contract.dart' as _i944;
import '../../domain/repo_contract/products_repo_contract.dart' as _i291;
import '../../domain/usecase/auth_usecases/login_usecase.dart' as _i219;
import '../../domain/usecase/product_usecase.dart' as _i397;
import '../../presentation/auth/view_model/auth_cubit.dart' as _i910;
import '../../presentation/tabs/home/view_model/home_cubit.dart' as _i1014;
import '../api/api_manager.dart' as _i1047;
import '../cache/shared_pref.dart' as _i299;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.singleton<_i299.CacheHelper>(() => _i299.CacheHelper());
    gh.factory<_i920.ProductDataSource>(
      () => _i246.ProductDatasourceImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i829.AuthDatasource>(
      () => _i422.AuthDatasourceImpl(
        gh<_i1047.ApiManager>(),
        gh<_i299.CacheHelper>(),
      ),
    );
    gh.factory<_i944.AuthRepo>(
      () => _i540.AuthRepoImpl(gh<_i829.AuthDatasource>()),
    );
    gh.factory<_i291.ProductsRepo>(
      () => _i650.ProductRepoImpl(gh<_i920.ProductDataSource>()),
    );
    gh.factory<_i397.ProductUsecase>(
      () => _i397.ProductUsecase(gh<_i291.ProductsRepo>()),
    );
    gh.factory<_i219.LoginUsecase>(
      () => _i219.LoginUsecase(gh<_i944.AuthRepo>()),
    );
    gh.factory<_i1014.HomeCubit>(
      () => _i1014.HomeCubit(gh<_i397.ProductUsecase>()),
    );
    gh.factory<_i910.AuthCubit>(
      () => _i910.AuthCubit(gh<_i219.LoginUsecase>()),
    );
    return this;
  }
}
