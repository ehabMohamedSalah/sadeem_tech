
import 'package:injectable/injectable.dart';
import 'package:sadeem_project/core/api/api_result.dart';
import 'package:sadeem_project/data/datasource_contract/product_datasource_contract.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';
import 'package:sadeem_project/domain/repo_contract/products_repo_contract.dart';
@Injectable(as: ProductsRepo)
class ProductRepoImpl extends ProductsRepo{

  ProductDataSource productDataSource;
  ProductRepoImpl(this.productDataSource);
  @override
  Future<ApiResult<List<ProductEntity>>> getProducts()  {
   return productDataSource.getProducts();
  }

}