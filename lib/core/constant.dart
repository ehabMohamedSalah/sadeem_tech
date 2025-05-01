class Constant {
  static const String tokenKey = 'userId';
   static const String isRememberMe = 'isRememberMe';
  static const String baseUrl = "https://dummyjson.com";
  static const String regExValidateEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static RegExp regexPass = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$',
  );
  static const String questCacheKey = "is_quest";


}
