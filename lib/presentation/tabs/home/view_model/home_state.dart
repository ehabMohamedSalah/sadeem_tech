part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class ProductsLoadingState extends HomeState {}
final class ProductsErrorState extends HomeState {
  String errMsg;
  ProductsErrorState(this.errMsg);
}
final class ProductsSuccessState extends HomeState {
  List<ProductEntity> products;
  ProductsSuccessState(this.products);
}



