
import 'package:injectable/injectable.dart';
import 'package:sadeem_project/core/api/api_manager.dart';
import 'package:sadeem_project/core/api/api_result.dart';
import 'package:sadeem_project/core/api/endpoints.dart';
import 'package:sadeem_project/data/datasource_contract/auth_datasource_contract.dart';
import 'package:sadeem_project/data/model/auth/login_response/LoginResponse.dart';
import 'package:sadeem_project/domain/entity/auth_entity/login_entity.dart';

import '../../core/cache/shared_pref.dart';
import '../../core/constant.dart';

@Injectable(as: AuthDatasource)
class AuthDatasourceImpl extends AuthDatasource{
  ApiManager apiManager;
  final CacheHelper cacheHelper;
  AuthDatasourceImpl(this.apiManager,this.cacheHelper);
  @override
  Future<ApiResult<LoginEntity>> Login({required String userName, required String password})async {
 try{
   var apiResponse=await apiManager.postRequest(
     endpoint: EndPoint.LoginEndpoint,
     body: {
       'username': userName,
       'password': password,
     },
   );
   var response = LoginResponse.fromJson(apiResponse.data ?? {});
   LoginEntity loginEntity = response.toLoginEntity();
   // ============ Save Token ===============\\
   if (response.token != null) {
     bool setToken = await cacheHelper.setData<String>(
         Constant.tokenKey, response.token ?? "");
   } else {
       print('Token not saved⛔⛔');
     }
   return SuccessApiResult(loginEntity);
 }catch(error){
   return ErrorApiResult(
       Exception("Server connection error: ${error.toString()}"));
 }
  }
}