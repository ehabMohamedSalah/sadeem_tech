import 'package:flutter/material.dart';
import 'package:sadeem_project/core/utils/text_styles.dart';

import '../../../../core/firebase/firebase_cart.dart';
import '../../../../core/resuable_comp/product_card.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../domain/entity/product_entity.dart';
import '../../home/view/widget/product_details_item.dart';
import 'cart_widget/cart_product_details_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.secondaryColor,
centerTitle: true,
        title: Text(AppStrings.cart,style: AppTextStyle.regular24.copyWith(color: Colors.white),), // استخدم النص المناسب
      ),
      body: FutureBuilder<List<ProductEntity>>(
        future: CartFirebaseService.getCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading cart'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final cartProducts = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartProducts.length,
            itemBuilder: (context, index) {
              final product = cartProducts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ProductCard(
                  title: product.title,
                  price: product.price,
                  imgCover: product.thumbnail,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartProductDetailsScreen(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
