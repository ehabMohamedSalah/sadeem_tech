import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeem_project/core/firebase/firebase_cart.dart';
import 'package:sadeem_project/core/utils/color_manager.dart';
import 'package:sadeem_project/core/utils/string_manager.dart';
import 'package:sadeem_project/core/utils/text_styles.dart';
import 'package:sadeem_project/domain/entity/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const CartProductDetailsScreen({super.key, required this.product});

  @override
  State<CartProductDetailsScreen> createState() => _CartProductDetailsScreenState();
}

class _CartProductDetailsScreenState extends State<CartProductDetailsScreen> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.product.meta?.count ?? 1;
  }

  void updateCount() async {
    await CartFirebaseService.updateProductInCart(widget.product.id.toString(), newCount: count);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product updated successfully!')),
    );
  }

  void deleteProduct() async {
    await CartFirebaseService.deleteProductFromCart(widget.product.id.toString());
    Navigator.pop(context); // Close the details screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product deleted from cart.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back),color: Colors.white,),
        backgroundColor: ColorManager.secondaryColor,
        title:   Text("Product in Cart",style: AppTextStyle.regular24.copyWith(color: Colors.white),),
        actions: [
          IconButton(
            icon:   Icon(Icons.delete, color: Colors.white),
            onPressed: deleteProduct,
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
            Text('EGP ${product.price}', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),
            Text(product.description ?? "", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 30.h),


            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (count > 1) setState(() => count--);
                  },
                ),
                Text('$count', style: TextStyle(fontSize: 18.sp)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => count++),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton.icon(
                onPressed: updateCount,
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text("Update", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: ColorManager.secondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
