import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core_catalogo_module/core/error/exception.dart';
import 'package:core_catalogo_module/core/usecase/use_case.dart';
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart';
import 'package:core_catalogo_module/feature/domain/usecases/get_by_favorite_status_product.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'favorite_product_event.dart';
part 'favorite_product_state.dart';

@injectable
class FavoriteProductBloc
    extends Bloc<FavoriteProductEvent, FavoriteProductState> {
  final List<Product> _listProducts = [];
  FavoriteProductBloc(this.getProductByFavoriteStatusProduct)
      : super(FavoriteProductInitial()) {
    on<FavoriteProductEvent>(getProductByFavoriteHandler);
  }
  final GetProductByFavoriteStatusProduct getProductByFavoriteStatusProduct;

  FutureOr<void> getProductByFavoriteHandler(event, emit) async {
    emit(FavoriteProductLoadingState());
    if (event is GetFavoriteProductEvent) {
        _listProducts.clear();
      final either = await getProductByFavoriteStatusProduct(NoParams());

      either.fold((failure) => emit(FavoriteProductErrorState(failure)),
          (success) {
      
        _listProducts.addAll(success.product);
        emit(FavoriteProductLoadedState(_listProducts));
      });
    }
  }
}
