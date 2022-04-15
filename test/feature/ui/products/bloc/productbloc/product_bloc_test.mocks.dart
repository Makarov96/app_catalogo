// Mocks generated by Mockito 5.1.0 from annotations
// in app_catalogo/test/feature/ui/products/bloc/productbloc/product_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core_catalogo_module/core/error/exception.dart' as _i5;
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart'
    as _i7;
import 'package:core_catalogo_module/feature/domain/usecases/get_all_product.dart'
    as _i9;
import 'package:core_catalogo_module/feature/domain/usecases/search_by_product_name.dart'
    as _i6;
import 'package:core_catalogo_module/feature/domain/usecases/search_by_tag_id.dart'
    as _i8;
import 'package:core_catalogo_module/feature/domain/usecases/set_favorite_product.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [SetFavoriteProduct].
///
/// See the documentation for Mockito's code generation for more information.
class MockSetFavoriteProduct extends _i1.Mock
    implements _i3.SetFavoriteProduct {
  MockSetFavoriteProduct() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.GenericException, bool>> call(
          _i3.FavoriteParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i2.Either<_i5.GenericException, bool>>.value(
                  _FakeEither_0<_i5.GenericException, bool>()))
          as _i4.Future<_i2.Either<_i5.GenericException, bool>>);
}

/// A class which mocks [SearchByProductName].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchByProductName extends _i1.Mock
    implements _i6.SearchByProductName {
  MockSearchByProductName() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.GenericException, _i7.ProductModel>> call(
          _i6.SearchProductsParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                      _i2.Either<_i5.GenericException, _i7.ProductModel>>.value(
                  _FakeEither_0<_i5.GenericException, _i7.ProductModel>()))
          as _i4.Future<_i2.Either<_i5.GenericException, _i7.ProductModel>>);
}

/// A class which mocks [Product].
///
/// See the documentation for Mockito's code generation for more information.
class MockProduct extends _i1.Mock implements _i7.Product {
  MockProduct() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isFavorite =>
      (super.noSuchMethod(Invocation.getter(#isFavorite), returnValue: false)
          as bool);
  @override
  num get productCategory =>
      (super.noSuchMethod(Invocation.getter(#productCategory), returnValue: 0)
          as num);
  @override
  String get productDescription => (super
          .noSuchMethod(Invocation.getter(#productDescription), returnValue: '')
      as String);
  @override
  String get productImage =>
      (super.noSuchMethod(Invocation.getter(#productImage), returnValue: '')
          as String);
  @override
  String get productName =>
      (super.noSuchMethod(Invocation.getter(#productName), returnValue: '')
          as String);
  @override
  String get productPrice =>
      (super.noSuchMethod(Invocation.getter(#productPrice), returnValue: '')
          as String);
  @override
  num get quantityAvailable =>
      (super.noSuchMethod(Invocation.getter(#quantityAvailable), returnValue: 0)
          as num);
  @override
  String get urlMoreDetail =>
      (super.noSuchMethod(Invocation.getter(#urlMoreDetail), returnValue: '')
          as String);
  @override
  int get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: 0) as int);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}

/// A class which mocks [ProductModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductModel extends _i1.Mock implements _i7.ProductModel {
  MockProductModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i7.Product> get product =>
      (super.noSuchMethod(Invocation.getter(#product),
          returnValue: <_i7.Product>[]) as List<_i7.Product>);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}

/// A class which mocks [SearchByTagId].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchByTagId extends _i1.Mock implements _i8.SearchByTagId {
  MockSearchByTagId() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.GenericException, _i7.ProductModel>> call(
          _i8.SearchByParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                      _i2.Either<_i5.GenericException, _i7.ProductModel>>.value(
                  _FakeEither_0<_i5.GenericException, _i7.ProductModel>()))
          as _i4.Future<_i2.Either<_i5.GenericException, _i7.ProductModel>>);
}

/// A class which mocks [SearchByParams].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchByParams extends _i1.Mock implements _i8.SearchByParams {
  MockSearchByParams() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get tagId =>
      (super.noSuchMethod(Invocation.getter(#tagId), returnValue: 0) as int);
  @override
  List<Object?> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <Object?>[])
          as List<Object?>);
}

/// A class which mocks [GetAllProducts].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllProducts extends _i1.Mock implements _i9.GetAllProducts {
  @override
  _i4.Future<_i2.Either<_i5.GenericException, _i7.ProductModel>> call(
          _i9.ProductsParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                      _i2.Either<_i5.GenericException, _i7.ProductModel>>.value(
                  _FakeEither_0<_i5.GenericException, _i7.ProductModel>()))
          as _i4.Future<_i2.Either<_i5.GenericException, _i7.ProductModel>>);
}
