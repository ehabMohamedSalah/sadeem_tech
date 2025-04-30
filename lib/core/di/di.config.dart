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
import '../../data/datasource_impl/auth_datasource_impl.dart' as _i422;
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
    gh.factory<_i829.AuthDatasource>(
      () => _i422.AuthDatasourceImpl(
        gh<_i1047.ApiManager>(),
        gh<_i299.CacheHelper>(),
      ),
    );
    return this;
  }
}
