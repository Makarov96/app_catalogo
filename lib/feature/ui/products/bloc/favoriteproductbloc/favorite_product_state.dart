part of 'favorite_product_bloc.dart';

abstract class FavoriteProductState extends Equatable {
  const FavoriteProductState();
  
  @override
  List<Object> get props => [];
}

class FavoriteProductInitial extends FavoriteProductState {}


class FavoriteProductLoadingState extends FavoriteProductState {}

class FavoriteProductLoadedState extends FavoriteProductState {
  const FavoriteProductLoadedState(this.productModel);
  final List<Product> productModel;

  @override
  List<Object> get props => [productModel];
}

class FavoriteProductErrorState extends FavoriteProductState {
  const FavoriteProductErrorState(this.exception);
  final GenericException exception;

  @override
  List<Object> get props => [exception];
}

