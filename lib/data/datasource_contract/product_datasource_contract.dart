

import 'package:sadeem_project/core/api/api_result.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';

abstract class ProductDataSource{
  Future<ApiResult<List<ProductEntity>>> getProducts();
}