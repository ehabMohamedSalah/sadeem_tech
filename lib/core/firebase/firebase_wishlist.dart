import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/product_entity.dart';

class WishlistFirebaseService {
  /// 📁 Reference to "wishlist" collection with ProductEntity
  static CollectionReference<ProductEntity> getWishlistCollection() {
    return FirebaseFirestore.instance
        .collection("wishlist")
        .withConverter<ProductEntity>(
      fromFirestore: (snapshot, _) => ProductEntity.fromJson(snapshot.data()!),
      toFirestore: (product, _) => product.toJson(),
    );
  }

  /// ➕ Add product to wishlist
  static Future<void> addProductToWishlist(ProductEntity product) async {
    try {
      final wishlist = getWishlistCollection();
      // Save the whole product object with its ID
      await wishlist.doc(product.id.toString()).set(product);
    } catch (e) {
      print("Error adding product to wishlist: $e");
    }
  }

  /// 🗑️ Remove product from wishlist
  static Future<void> removeProductFromWishlist(String productId) async {
    try {
      final wishlist = getWishlistCollection();
      await wishlist.doc(productId).delete();
    } catch (e) {
      print("Error removing product from wishlist: $e");
    }
  }

  /// 📥 Get all products in wishlist
  static Future<List<ProductEntity>> getWishlistProducts() async {
    try {
      final wishlist = getWishlistCollection();
      final snapshot = await wishlist.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching wishlist products: $e");
      return [];
    }
  }

  /// 🔍 Check if product is already in wishlist
  static Future<bool> isProductInWishlist(String productId) async {
    try {
      final wishlist = getWishlistCollection();
      final docSnapshot = await wishlist.doc(productId).get();
      return docSnapshot.exists; // If the product document exists in wishlist, return true
    } catch (e) {
      print("Error checking product in wishlist: $e");
      return false;
    }
  }
}
