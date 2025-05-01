import 'package:flutter/material.dart';
import 'package:sadeem_project/core/firebase/firebase_wishlist.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';
import 'package:sadeem_project/presentation/tabs/wishlist/view/widget/wishlist_details_screen.dart';
import '../../../../core/resuable_comp/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late Future<List<ProductEntity>> _wishlistProducts;

  @override
  void initState() {
    super.initState();
     _wishlistProducts = WishlistFirebaseService.getWishlistProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: FutureBuilder<List<ProductEntity>>(
        future: _wishlistProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products in wishlist.'));
          }

           final products = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
               itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  productId: product.id?.toString() ?? "",

                  title: product.title,
                  imgCover: product.thumbnail,
                  price: product.price,
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WishlistDetailsScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
