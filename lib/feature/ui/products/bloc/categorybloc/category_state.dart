part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final CategoryModel category;

  const CategoryLoaded(this.category);
  @override

  List<Object> get props => [category];
}

class CategoryError extends CategoryState {
final GenericException generic;

  const CategoryError(this.generic);
}

