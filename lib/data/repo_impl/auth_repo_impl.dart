
import 'package:injectable/injectable.dart';
import 'package:sadeem_project/core/api/api_result.dart';
import 'package:sadeem_project/data/datasource_contract/auth_datasource_contract.dart';
import 'package:sadeem_project/domain/entity/auth_entity/login_entity.dart';

import '../../domain/repo_contract/auth_repo_contract.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo{
  AuthDatasource authDatasource;
  AuthRepoImpl(this.authDatasource);

  @override
  Future<ApiResult<LoginEntity>> Login({required String userName, required String password}) {
    return authDatasource.Login(userName: userName, password: password);
  }

}