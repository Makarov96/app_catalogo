// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:app_catalogo/feature/ui/products/bloc/categorybloc/category_bloc.dart'
    as _i3;
import 'package:app_catalogo/feature/ui/products/bloc/favoriteproductbloc/favorite_product_bloc.dart'
    as _i5;
import 'package:app_catalogo/feature/ui/products/bloc/productbloc/product_bloc.dart'
    as _i7;
import 'package:core_catalogo_module/feature/domain/usecases/get_all_product.dart'
    as _i8;
import 'package:core_catalogo_module/feature/domain/usecases/get_by_favorite_status_product.dart'
    as _i6;
import 'package:core_catalogo_module/feature/domain/usecases/get_category_use_case.dart'
    as _i4;
import 'package:core_catalogo_module/feature/domain/usecases/search_by_product_name.dart'
    as _i11;
import 'package:core_catalogo_module/feature/domain/usecases/search_by_tag_id.dart'
    as _i10;
import 'package:core_catalogo_module/feature/domain/usecases/set_favorite_product.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $storeInitGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.CategoryBloc>(
      () => _i3.CategoryBloc(get<_i4.GetCategoryUseCase>()));
  gh.factory<_i5.FavoriteProductBloc>(() =>
      _i5.FavoriteProductBloc(get<_i6.GetProductByFavoriteStatusProduct>()));
  gh.factory<_i7.ProductBloc>(() => _i7.ProductBloc(
      get<_i8.GetAllProducts>(),
      get<_i9.SetFavoriteProduct>(),
      get<_i10.SearchByTagId>(),
      get<_i11.SearchByProductName>()));
  return get;
}
