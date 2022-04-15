import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core_catalogo_module/core/error/exception.dart';
import 'package:core_catalogo_module/feature/data/model/request/set_favorite_request_model.dart';
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart';
import 'package:core_catalogo_module/feature/domain/usecases/get_all_product.dart';
import 'package:core_catalogo_module/feature/domain/usecases/search_by_product_name.dart';
import 'package:core_catalogo_module/feature/domain/usecases/search_by_tag_id.dart';
import 'package:core_catalogo_module/feature/domain/usecases/set_favorite_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product> _listProducts = [];
  int _count = 0;

  final GetAllProducts getAllProductsUseCase;
  final SetFavoriteProduct setFavoriteProduct;
  final SearchByTagId searchByTagId;
  final SearchByProductName searchByProductName;
  var scrollcontroller = ScrollController();

  ProductBloc(
    this.getAllProductsUseCase,
    this.setFavoriteProduct,
    this.searchByTagId,
    this.searchByProductName,
  ) : super(ProductInitialState()) {
    on<GetProductEvent>(_getProductHandler);
    on<ProductInitialEvent>(_productInitStateHandler);
    on<ProductFavoriteSetEvent>(_productFavoriteSetEventHandler);
    on<ProductFilterByTagEvent>(_productFilterByTagHandler);
    on<ProductFilterByNameEvent>(_productFilterByNameHandler);
  }

  FutureOr<void> _productFilterByNameHandler(
      ProductFilterByNameEvent event, emit) async {
    _listProducts.clear();

    if (event.productName.isNotEmpty && event.productName.length > 3) {
      emit(ProductSearchByNameState());
      final either = await searchByProductName(
        SearchProductsParams(event.productName),
      );
      either.fold(
        (error) => emit(ProductErrorState(error)),
        (success) {
          _listProducts.clear();
          _listProducts.addAll(success.product);

          _count = _listProducts.length;
          emit(ProductLoadedState(_listProducts, false));
        },
      );
    } else if (event.productName.isEmpty) {
      add(const GetProductEvent(5, 0));
    }
  }

  void _listenerScrollView() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent)) {
      add(const GetProductEvent(5, 0));
    }
  }

  FutureOr<void> _productInitStateHandler(ProductInitialEvent event, emit) {
    scrollcontroller.addListener(_listenerScrollView);
    add(const GetProductEvent(5, 0));
  }

  FutureOr<void> _productFilterByTagHandler(
      ProductFilterByTagEvent event, emit) async {
    emit(ProductLoadingState());
    final either = await searchByTagId(SearchByParams(event.tagId));

    either.fold(
      (error) => emit(ProductErrorState(error)),
      (success) {
        _listProducts.clear();
        _listProducts.addAll(success.product);

        _count = _listProducts.length;
        emit(ProductLoadedState(_listProducts, true));
      },
    );

    scrollcontroller.removeListener(_listenerScrollView);
  }

  FutureOr<void> _getProductHandler(event, emit) async {
    if (event is GetProductEvent) {
      emit(ProductLoadingState());
      final either = await getAllProductsUseCase(
          ProductsParams(event.offset, _count + event.limit));

      either.fold(
        (error) => emit(ProductErrorState(error)),
        (success) {
          if (_count == 50) {
            _listProducts = success.product;
          }
          _listProducts.clear();
          _listProducts.addAll(success.product);

          _count = _listProducts.length;
          emit(ProductLoadedState(_listProducts, true));
        },
      );
    }
  }

  FutureOr<void> _productFavoriteSetEventHandler(
      ProductFavoriteSetEvent event, emit) async {
    emit(ProductLoadingState());
    final either = await setFavoriteProduct(
      FavoriteParams(event.setBoolValue,event.productId),
    );

    either.fold(
      (error) => emit(ProductErrorState(error)),
      (success) {
        emit(ProductSetFavoriteProductState(success));
      },
    );
    add(const GetProductEvent(0, 0));
  }
}

