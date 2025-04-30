
import 'package:sadeem_project/core/api/api_result.dart';

import '../../domain/entity/auth_entity/login_entity.dart';

abstract class AuthDatasource{
 Future<ApiResult<LoginEntity>> Login({required String userName,required String password});


}