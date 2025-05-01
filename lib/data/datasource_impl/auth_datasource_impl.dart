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
class AuthDatasourceImpl extends AuthDatasource {
  final ApiManager apiManager;
  final CacheHelper cacheHelper;

  AuthDatasourceImpl(this.apiManager, this.cacheHelper);

  @override
  Future<ApiResult<LoginEntity>> Login({
    required String userName,
    required String password,
  }) async {
    try {
       var apiResponse = await apiManager.postRequest(
        endpoint: EndPoint.LoginEndpoint,

        body: {
          'username': userName,
          'password': password,
        },

      );

      if (apiResponse.statusCode == 200) {
        print("======================================");
        print("success");
        print("======================================");

        var response = LoginResponse.fromJson(apiResponse.data ?? {});
        LoginEntity loginEntity = response.toLoginEntity();

        if (response.token != null) {
          await cacheHelper.setData<String>(
            Constant.tokenKey,
            response.token ?? "",
          );
          print('Token saved successfully ✅');
        } else {
          print('Token not available in response ⛔');
        }

        return SuccessApiResult(loginEntity);
      } else {
        final errorMessage = apiResponse.data?['message'] ??
            'Login failed with status: ${apiResponse.statusCode}';
        print('API Error: $errorMessage');
        return ErrorApiResult(Exception(errorMessage));
      }
    } catch (error, stackTrace) {
      print('Login failed ❌: $error');
      print('Stack Trace: $stackTrace');
      return ErrorApiResult(Exception("Login error: ${error.toString()}"));
    }
  }
}