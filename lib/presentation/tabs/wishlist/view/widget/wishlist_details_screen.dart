import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeem_project/core/firebase/firebase_wishlist.dart';
import 'package:sadeem_project/core/utils/color_manager.dart';
import 'package:sadeem_project/core/utils/text_styles.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../core/firebase/firebase_cart.dart';
import '../../../../../core/utils/string_manager.dart';

class WishlistDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const WishlistDetailsScreen({super.key, required this.product});

  @override
  State<WishlistDetailsScreen> createState() => _WishlistDetailsScreenState();
}

class _WishlistDetailsScreenState extends State<WishlistDetailsScreen> {

  // Method to add product to wishlist
  void addProductToWishlist() async {
    await WishlistFirebaseService.addProductToWishlist(widget.product);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added to wishlist!')),
    );
  }

   void removeProductFromWishlist() async {
    await WishlistFirebaseService.removeProductFromWishlist(widget.product.id.toString());
    Navigator.pop(context); // Close the details screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product removed from wishlist.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: ColorManager.secondaryColor,
        title: Text(
          "Product in Wishlist",
          style: AppTextStyle.regular24.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: removeProductFromWishlist,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
              ),
            ),
            SizedBox(height: 20.h),
            Text(product.title ?? "", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10.h),
            Text(
              'EGP ${product.price}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Text(product.description ?? "", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 30.h),

             SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton.icon(
                onPressed: () async{
                  await CartFirebaseService.addProductToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} added to cart!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                label: Text(AppStrings.addtocart, style: const TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.secondaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
