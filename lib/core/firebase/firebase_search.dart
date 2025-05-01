import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/product_entity.dart';

class ProductsFirebaseService {
  /// 🔥 Reference to "products" collection with ProductEntity conversion
  static CollectionReference<ProductEntity> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection("products")
        .withConverter<ProductEntity>(
      fromFirestore: (snapshot, _) =>
          ProductEntity.fromJson(snapshot.data()!),
      toFirestore: (product, _) => product.toJson(),
    );
  }

  /// 🔍 Local search in all products by title (contains, case-insensitive)
  static Future<List<ProductEntity>> localSearchInAllProducts(String keyword) async {
    final products = await getProductsCollection().get();
    return products.docs
        .map((doc) => doc.data())
        .where((product) =>
    product.title != null &&
        product.title!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}
