
 import 'package:injectable/injectable.dart';
import 'package:sadeem_project/domain/repo_contract/auth_repo_contract.dart';

import '../../../core/api/api_result.dart';
import '../../entity/auth_entity/login_entity.dart';

@injectable
class LoginUsecase{
  AuthRepo authRepo;
  @factoryMethod
  LoginUsecase(this.authRepo);
  Future<ApiResult<LoginEntity>> call({required String userName, required String password}) {
    return authRepo.Login(userName: userName, password: password);
  }
}