import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/product_entity.dart';

class CartFirebaseService {
  /// 🔥 Reference to "cart" collection with ProductEntity conversion
  static CollectionReference<ProductEntity> getCartCollection() {
    return FirebaseFirestore.instance
        .collection("cart")
        .withConverter<ProductEntity>(
      fromFirestore: (snapshot, _) =>
          ProductEntity.fromJson(snapshot.data()!),
      toFirestore: (product, _) => product.toJson(),
    );
  }

  /// ➕ Add product to cart
  static Future<void> addProductToCart(ProductEntity product) async {
    final cart = getCartCollection();
    await cart.doc(product.id.toString()).set(product);
  }

  /// ✏️ Update product in cart (example: update count)
  static Future<void> updateProductInCart(String productId, {int? newCount}) async {
    final cart = getCartCollection();
    final docRef = cart.doc(productId);
    final current = await docRef.get();
    if (current.exists) {
      ProductEntity product = current.data()!;
      if (newCount != null && product.meta != null) {
        product.meta!.count = newCount;
        await docRef.set(product);
      }
    }
  }

  /// 🗑️ Delete product from cart
  static Future<void> deleteProductFromCart(String productId) async {
    final cart = getCartCollection();
    await cart.doc(productId).delete();
  }

  /// 📥 Get all products in cart
  static Future<List<ProductEntity>> getCartProducts() async {
    final cart = getCartCollection();
    final snapshot = await cart.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// 🔼 Increment product count
  static Future<void> incrementProductCount(String productId) async {
    final cart = getCartCollection();
    final docRef = cart.doc(productId);
    final current = await docRef.get();
    if (current.exists) {
      ProductEntity product = current.data()!;
      product.meta?.count = (product.meta?.count ?? 0) + 1;
      await docRef.set(product);
    }
  }
}
