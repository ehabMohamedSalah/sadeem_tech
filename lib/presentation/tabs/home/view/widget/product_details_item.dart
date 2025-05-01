import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeem_project/core/utils/text_styles.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';

import '../../../../../core/firebase/firebase_cart.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/string_manager.dart';



class ProductDetailsScreen extends StatelessWidget {

  ProductEntity product;
    ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.pop(context);} ,),
        title: Text(AppStrings.productDetails,style: AppTextStyle.regular25.copyWith(color: Colors.white),),
        backgroundColor: ColorManager.secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail??"",
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              product.title??"",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 10.h),
            Text(
              'EGP ${product.price}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(height: 20.h),
            Text(
              product.description ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
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
