import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';
import 'package:sadeem_project/domain/usecase/product_usecase.dart';

import '../../../../core/api/api_result.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  ProductUsecase productUsecase;
  HomeCubit(this.productUsecase) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getProducts()async{
    emit(ProductsLoadingState());

    var result=await productUsecase.call();
    switch (result) {
      case SuccessApiResult():
        emit(ProductsSuccessState( result.data??[]));
        break;
      case ErrorApiResult():
        emit(ProductsErrorState(  result.exception.toString()));
        print("=========================================================");

        print(result.exception.toString());
        break;
    }
  }
}