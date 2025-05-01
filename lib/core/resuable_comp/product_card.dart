import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entity/product_entity.dart';
import '../firebase/firebase_wishlist.dart';
import '../utils/color_manager.dart';
import '../utils/string_manager.dart';

class ProductCard extends StatefulWidget {
  final String? title;
  final String? imgCover;
  final num? price;
  final num? priceAfterDiscount;
  final num? discount;
  final String productId; // إضافة ID المنتج
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    this.title,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    required this.productId,
    required this.onTap,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isInWishlist = false;

  // التحقق من وجود المنتج في الـ wishlist
  @override
  void initState() {
    super.initState();
    _checkIfProductInWishlist();
  }

  Future<void> _checkIfProductInWishlist() async {
    bool exists = await WishlistFirebaseService.isProductInWishlist(widget.productId);
    setState(() {
      isInWishlist = exists;
    });
  }

  // إضافة أو إزالة المنتج من الـ wishlist
  Future<void> _toggleWishlist() async {
    if (isInWishlist) {
      await WishlistFirebaseService.removeProductFromWishlist(widget.productId);
    } else {
      // تأكد من أن المنتج يحتوي على كل البيانات اللازمة
      // استخدم الكائن الكامل ProductEntity هنا
      await WishlistFirebaseService.addProductToWishlist(ProductEntity(

        id: num.tryParse(widget.productId) ?? 0, // تحويل إلى num أو تعيين 0 إذا فشل التحويل
        title: widget.title,
        price: widget.price,
        thumbnail: widget.imgCover,

      ));
    }
    _checkIfProductInWishlist(); // التحقق من الحالة بعد التغيير
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorManager.white70,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 8,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: widget.imgCover ?? "",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.title ?? "",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 10.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "EGP ${widget.price ?? "0"}",
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          IconButton(
                            icon: Icon(
                              isInWishlist ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: _toggleWishlist,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorManager.secondaryColor),
                  ),
                  onPressed: widget.onTap,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          AppStrings.viewMore,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
