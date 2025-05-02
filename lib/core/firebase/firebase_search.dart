// firebase_search.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/product_entity.dart';

class ProductsFirebaseService {
  static Future<List<ProductEntity>> localSearchInAllProducts(String keyword) async {
    try {
      // Assuming you're using Firestore to store products
      final productCollection = FirebaseFirestore.instance.collection('products');
      final snapshot = await productCollection
          .where('keywords', arrayContains: keyword)  // Assuming you have a 'keywords' field for efficient search
          .get();

      // Mapping Firestore data to ProductEntity
      return snapshot.docs.map((doc) {
        return ProductEntity.fromJson(doc.data());
      }).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
