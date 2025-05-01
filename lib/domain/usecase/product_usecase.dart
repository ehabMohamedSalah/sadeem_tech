
import 'package:injectable/injectable.dart';
import 'package:sadeem_project/domain/repo_contract/products_repo_contract.dart';

import '../../core/api/api_result.dart';
import '../entity/product_entity.dart';

@injectable
class ProductUsecase{
  ProductsRepo productsRepo;
  ProductUsecase(this.productsRepo);

  Future<ApiResult<List<ProductEntity>>> call(){
    return productsRepo.getProducts();
  }
}