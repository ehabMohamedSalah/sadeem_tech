import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sadeem_project/core/di/di.dart';
import 'package:sadeem_project/presentation/auth/view_model/auth_cubit.dart';
import 'package:sadeem_project/presentation/tabs/cart/view/cart_screen.dart';
import 'package:sadeem_project/presentation/tabs/home/view/home_screen.dart';
import 'package:sadeem_project/presentation/tabs/home/view_model/home_cubit.dart';
import 'package:sadeem_project/presentation/tabs/profile/view/profile_screen.dart';
import 'package:sadeem_project/presentation/tabs/wishlist/view/wishlist_screen.dart';
import '../../../core/utils/color_manager.dart';
import '../../tabs/profile/provider/profile_provider.dart'; // Import Flutter Icons package

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
     BlocProvider(
      create: (context) => getIt<HomeCubit>()..getProducts(),
      child: HomeScreen(),
    ),
    CartScreen(),
    WishListScreen(),
    ChangeNotifierProvider(
        create: (context) => SettingProvider(), // Providing SettingProvider at a higher level
        child: ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        index: _currentIndex,
        backgroundColor: ColorManager.white,
        color: ColorManager.secondaryColor,
        items: <Widget>[
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.shopping_bag_sharp, color: Colors.white, size: 30),
          Icon(Icons.menu, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
