part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}


class CategoryInitialEvent extends CategoryEvent {}

class CategoryRefreshlEvent extends CategoryEvent {
  final  CategoryModel category;

  const CategoryRefreshlEvent(this.category);

  @override

  List<Object> get props => [category];
}