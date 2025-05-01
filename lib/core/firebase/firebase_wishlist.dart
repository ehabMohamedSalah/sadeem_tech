import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/product_entity.dart';

class WishlistFirebaseService {
  /// 📁 Reference to "wishlist" collection with ProductEntity
  static CollectionReference<ProductEntity> getWishlistCollection() {
    return FirebaseFirestore.instance
        .collection("wishlist")
        .withConverter<ProductEntity>(
      fromFirestore: (snapshot, _) =>
          ProductEntity.fromJson(snapshot.data()!),
      toFirestore: (product, _) => product.toJson(),
    );
  }

  /// ➕ Add product to wishlist
  static Future<void> addProductToWishlist(ProductEntity product) async {
    final wishlist = getWishlistCollection();
    await wishlist.doc(product.id.toString()).set(product);
  }

  /// 🗑️ Remove product from wishlist
  static Future<void> removeProductFromWishlist(String productId) async {
    final wishlist = getWishlistCollection();
    await wishlist.doc(productId).delete();
  }

  /// 📥 Get all products in wishlist
  static Future<List<ProductEntity>> getWishlistProducts() async {
    final wishlist = getWishlistCollection();
    final snapshot = await wishlist.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
