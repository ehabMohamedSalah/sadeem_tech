// home_cubit.dart
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
  final ProductUsecase productUsecase;
  HomeCubit(this.productUsecase) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<ProductEntity> allProducts = [];
  String selectedCategory = "all";
  bool sortByPriceAsc = true;

  Future<void> getProducts() async {
    emit(ProductsLoadingState());

    var result = await productUsecase.call();
    switch (result) {
      case SuccessApiResult():
        allProducts = result.data ?? [];
        emit(ProductsSuccessState(allProducts));
        break;
      case ErrorApiResult():
        emit(ProductsErrorState(result.exception.toString()));
        break;
    }
  }

  List<ProductEntity> filterAndSortProducts({
    required String keyword,
    String category = "all",
    bool sortAsc = true,
  }) {
    List<ProductEntity> filtered = allProducts.where((product) {
      final matchesKeyword = product.title!.toLowerCase().contains(keyword.toLowerCase());
      final matchesCategory = category == "all" || product.category == category;
      return matchesKeyword && matchesCategory;
    }).toList();

    filtered.sort((a, b) => sortAsc
        ? (a.price ?? 0).compareTo(b.price ?? 0)
        : (b.price ?? 0).compareTo(a.price ?? 0));
    return filtered;
  }
}

