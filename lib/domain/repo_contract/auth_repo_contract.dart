import '../../core/api/api_result.dart';
import '../entity/auth_entity/login_entity.dart';

abstract class AuthRepo{

  Future<ApiResult<LoginEntity>> Login({required String userName,required String password});

}