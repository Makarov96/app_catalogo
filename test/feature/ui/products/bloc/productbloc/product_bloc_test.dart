import 'package:app_catalogo/feature/ui/products/bloc/productbloc/product_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:core_catalogo_module/feature/domain/usecases/search_by_product_name.dart';
import 'package:core_catalogo_module/feature/domain/usecases/search_by_tag_id.dart';
import 'package:core_catalogo_module/feature/domain/usecases/set_favorite_product.dart';
import 'package:dartz/dartz.dart';
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart';
import 'package:core_catalogo_module/feature/domain/usecases/get_all_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

@GenerateMocks(
  [
    SetFavoriteProduct,
    SearchByTagId,
    SearchByProductName,
    Product,
    ProductModel
  ],
  customMocks: [
    MockSpec<GetAllProducts>(returnNullOnMissingStub: true),
  ],
)
void main() {
  var mockGetCategoryUseCase = MockGetAllProducts();
  var mockNoParam = const ProductsParams(5, 0);
  var mockProductModel = MockProductModel();
  var mockProductBloc = MockProductBloc();
  MockGetAllProducts? mockGetAllProducts;
  MockSetFavoriteProduct? mockSetFavoriteProduct;
  MockSearchByTagId? mockSearchByTagId;
  MockSearchByProductName? mockSearchByProductName;

  setUp(() {
    mockGetAllProducts = MockGetAllProducts();
    mockSetFavoriteProduct = MockSetFavoriteProduct();
    mockSearchByTagId = MockSearchByTagId();
    mockSearchByProductName = MockSearchByProductName();
  });
  group(
    'should retunr product list',
    () {
      test('whenListen and return category list', () {
        whenListen(mockProductBloc,
            Stream.fromIterable(<ProductState>[ProductInitialState()]));
        expectLater(mockProductBloc.stream,
            emitsInOrder(<ProductState>[ProductInitialState()]));
      });
      test(
        'should list product response',
        () {
          when(mockGetCategoryUseCase(mockNoParam))
              .thenAnswer((realInvocation) async => Right(mockProductModel));
        },
      );
    },
  );
}
