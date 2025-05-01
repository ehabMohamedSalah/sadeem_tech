import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sadeem_project/data/model/auth/login_response/LoginResponse.dart';
import 'package:sadeem_project/domain/entity/auth_entity/login_entity.dart';
import 'package:sadeem_project/domain/usecase/auth_usecases/login_usecase.dart';
import '../../../core/api/api_result.dart';
import '../../../core/cache/shared_pref.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;


  AuthCubit(this.loginUsecase,  ) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);



  Future<void> Login({required String userName, required String password}) async {
    emit(LoginLoadingState());

    final result = await loginUsecase.call(userName: userName, password: password);

    switch (result) {
      case SuccessApiResult<LoginEntity>():

        final userModel = result.data;
         emit(LoginSuccessState( userModel:userModel ));
        break;
      case ErrorApiResult():
         emit(LoginErrorState(message: result.exception.toString()));
        print("=========================================================");
        print(result.exception.toString());
        break;
    }
  }


}
