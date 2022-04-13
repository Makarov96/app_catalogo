import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core_catalogo_module/core/error/exception.dart';
import 'package:core_catalogo_module/core/usecase/use_case.dart';
import 'package:core_catalogo_module/feature/data/model/response/category_model.dart';
import 'package:core_catalogo_module/feature/domain/usecases/get_category_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'category_event.dart';
part 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase getCategoryUseCase;
    List<ProductCategory> _listProductCategory=[];
  CategoryBloc(this.getCategoryUseCase) : super(CategoryInitial()) {
    on<CategoryEvent>(callCategory);
    on<CategoryRefreshlEvent>(buildSomething);
  }

  FutureOr<void> buildSomething(event, emit) async {
    emit(CategoryLoaded(event.category));
  }

  FutureOr<void> callCategory(event, emit) async {
    if (event is CategoryInitialEvent) {
      emit(CategoryLoading());
      final either = await getCategoryUseCase(NoParams());

      either.fold(
        (error) => emit(CategoryError(error)),
        (category) {
          _listProductCategory = [
            ProductCategory('All', 1),
            ...category.listProductCategory
          ];
          return emit(
            CategoryLoaded(
              CategoryModel(listProductCategory: _listProductCategory),
            ),
          );
        },
      );
    }
  }
}
