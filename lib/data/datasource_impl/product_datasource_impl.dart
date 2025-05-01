
import 'package:injectable/injectable.dart';
import 'package:sadeem_project/core/api/api_manager.dart';
import 'package:sadeem_project/core/api/api_result.dart';
import 'package:sadeem_project/core/api/endpoints.dart';
import 'package:sadeem_project/data/datasource_contract/product_datasource_contract.dart';
import 'package:sadeem_project/data/model/products_response/Products_response.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';

@Injectable(as:ProductDataSource)
class ProductDatasourceImpl extends ProductDataSource{
  ApiManager apiManager;
  ProductDatasourceImpl(this.apiManager);
  @override
  Future<ApiResult<List<ProductEntity>>> getProducts() async{
  try{
    var apiResponse= await apiManager.getRequest(endpoint: EndPoint.productsEndpoint);
    if (apiResponse.statusCode == 200) {
      print("======================================");
      print("success");
      print("======================================");

      var response = ProductsResponse.fromJson(apiResponse.data ?? {});
      List<ProductEntity> productEntities = response.products!.map((product) => product.toEntity()).toList();
      return SuccessApiResult(productEntities);
    } else {
      final errorMessage = apiResponse.data?['message'] ??
          'failed to get Products: ${apiResponse.statusCode}';
      print('Api Error: $errorMessage');
      return ErrorApiResult(Exception(errorMessage));
    }
  }catch(err){
    return ErrorApiResult(Exception(err.toString()));
  }

  }

}