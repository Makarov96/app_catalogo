part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSearchByNameState extends ProductState {}

class ProductLoadedState extends ProductState {
  const ProductLoadedState(
    this.productModel,
    this.ineedApplyPop,
  );
  final List<Product> productModel;
  final bool ineedApplyPop;

  @override
  List<Object> get props => [productModel, ineedApplyPop];
}

class ProductErrorState extends ProductState {
  const ProductErrorState(this.exception);
  final GenericException exception;

  @override
  List<Object> get props => [exception];
}

class ProductSetFavoriteProductState extends ProductState {
  const ProductSetFavoriteProductState(this.status);
  final bool status;

  @override
  List<Object> get props => [status];
}
