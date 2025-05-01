import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeem_project/core/utils/color_manager.dart';
import 'package:sadeem_project/core/utils/text_styles.dart';
import 'package:sadeem_project/presentation/tabs/home/view/widget/product_details_item.dart';

import '../../../../core/firebase/firebase_search.dart';
import '../../../../core/resuable_comp/product_card.dart';
import '../../../../domain/entity/product_entity.dart';
import '../view_model/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<ProductEntity> searchResults = [];
  bool isSearching = false;
  bool isLoadingSearch = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getProducts();
  }

  void onSearch(String keyword) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    setState(() {
      isSearching = keyword.isNotEmpty;
      isLoadingSearch = true;
    });


    if (keyword.isEmpty) {
      setState(() {
        isLoadingSearch = false;
        searchResults = [];
      });
      HomeCubit.get(context).getProducts();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
       final results = await ProductsFirebaseService.localSearchInAllProducts(keyword);
      setState(() {
        searchResults = results;
        isLoadingSearch = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.secondaryColor,
        title: Text(
          "Products",
          style: AppTextStyle.regular25.copyWith(color: ColorManager.white),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: searchController,
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    onSearch('');
                  },
                )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: isSearching
                  ? isLoadingSearch
                  ? const Center(child: CircularProgressIndicator())
                  : searchResults.isEmpty
                  ? const Center(child: Text("No results found"))
                  : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ProductCard(
                      productId: product.id?.toString() ?? "",
                      title: product.title,
                      price: product.price,
                      imgCover: product.thumbnail,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
                  : BlocConsumer<HomeCubit, HomeState>(
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
                            productId: product.id?.toString() ?? "",
                            title: product.title,
                            price: product.price,
                            imgCover: product.thumbnail,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailsScreen(product: product),
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
          ],
        ),
      ),
    );
  }
}
