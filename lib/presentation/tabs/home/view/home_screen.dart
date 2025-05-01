import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeem_project/core/utils/color_manager.dart';
import 'package:sadeem_project/core/utils/string_manager.dart';
import 'package:sadeem_project/core/utils/text_styles.dart';
import 'package:sadeem_project/presentation/tabs/home/view/widget/product_details_item.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resuable_comp/product_card.dart';
import '../view_model/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context)..getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: ColorManager.secondaryColor,
          title:   Text("Products",style: AppTextStyle.regular25.copyWith(color: ColorManager.white),)),
      body: Padding(
        padding:   REdgeInsets.all(16.0),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is ProductsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMsg)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsSuccessState) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ProductCard(
                       title: product.title,
                      price: product.price,
                      imgCover: product.thumbnail,

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(product: product,),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Products Found"));
            }
          },
        ),
      ),
    );
  }
}
