import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart'; // For Provider
import 'package:sadeem_project/core/resuable_comp/custom_text_button.dart';
import 'package:sadeem_project/core/utils/color_manager.dart';
import 'package:sadeem_project/core/utils/routes_manager.dart';
import 'package:sadeem_project/core/utils/string_manager.dart';
import 'package:sadeem_project/core/utils/text_styles.dart';
import 'package:sadeem_project/domain/entity/auth_entity/login_entity.dart';
import '../../../../core/firebase/firebase_user_model.dart';
import '../../../auth/view_model/auth_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<LoginEntity?> _userModelFuture;

  @override
  void initState() {
    super.initState();
    _userModelFuture = _fetchUserData();
  }

  // Fetch the user data from Firebase using the stored user ID
  Future<LoginEntity?> _fetchUserData() async {
    return await FirebaseFunc.ReadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginEntity?>(
      future: _userModelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(

            appBar: AppBar(
                centerTitle: true,
                title:  Text(AppStrings.profile,style: AppTextStyle.regular25.copyWith(color: ColorManager.secondaryColor))),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.profile,style: AppTextStyle.regular25.copyWith(color: ColorManager.secondaryColor))),
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.profile,style: AppTextStyle.regular25.copyWith(color: ColorManager.secondaryColor))),
            body: Center(child: Text("No User Data Found")),
          );
        }

        final userModel = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings.profile,style: AppTextStyle.regular25.copyWith(color: ColorManager.secondaryColor),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundImage: userModel.image != null && userModel.image!.isNotEmpty
                      ? NetworkImage(userModel.image!)
                      : AssetImage('assets/images/default_profile.png') as ImageProvider,
                  onBackgroundImageError: (_, __) => const Icon(Icons.person),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Row(
                    children: [
                      Text('Name: ',style: AppTextStyle.medium20,),
                      Text('${userModel.username ?? "N/A"}',style: AppTextStyle.medium18.copyWith(color: ColorManager.secondaryColor),),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text('Email: ',style: AppTextStyle.medium20),
                      Text('${userModel.email ?? "N/A"}',style: AppTextStyle.medium16.copyWith(color: ColorManager.secondaryColor)),
                    ],
                  ),
                ),
              SizedBox(height: 40.h,),
                CustomTextButton(
                    color: ColorManager.secondaryColor,
                    borderColor:ColorManager.secondaryColor ,
                    text: "LOG OUT",
                    textColor: ColorManager.white ,
                    onPressed: (){
                  Navigator.pushNamed(context, RouteManager.loginScreen);
                },),
              ],
            ),
          ),
        );
      },
    );
  }
}
