part of 'favorite_product_bloc.dart';

abstract class FavoriteProductEvent extends Equatable {
  const FavoriteProductEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteProductEvent extends FavoriteProductEvent {}
