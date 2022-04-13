part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductInitialEvent extends ProductEvent {}

class GetProductEvent extends ProductEvent {
  final int limit;
  final int offset;

  const GetProductEvent(this.limit, this.offset);

  @override
  List<Object> get props => [offset, limit];
}

class ProductFavoriteSetEvent extends ProductEvent {
  final int productId;
  final bool setBoolValue;

  const ProductFavoriteSetEvent(this.productId, this.setBoolValue);

  @override
  List<Object> get props => [productId, setBoolValue];
}

class ProductFilterByTagEvent extends ProductEvent {
  final int tagId;

  const ProductFilterByTagEvent(
    this.tagId,
  );

  @override
  List<Object> get props => [tagId];
}

class ProductFilterByNameEvent extends ProductEvent {
  const ProductFilterByNameEvent(this.productName);
  final String productName;
  @override
  List<Object> get props => [productName];
}
