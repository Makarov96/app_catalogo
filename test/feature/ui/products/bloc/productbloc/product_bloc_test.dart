import 'package:app_catalogo/feature/ui/products/bloc/productbloc/product_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core_catalogo_module/core/error/exception.dart';
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
    SearchByProductName,
    Product,
    ProductModel,
    SearchByTagId,
    SearchByParams,
  ],
  customMocks: [
    MockSpec<GetAllProducts>(returnNullOnMissingStub: true),
  ],
)
void main() {
  var mockGetCategoryUseCase = MockGetAllProducts();
  var mockNoParam = const ProductsParams(5, 0);
  final mockSearchByParams = MockSearchByParams();
  var tProductModel = ProductModel(
    product: [],
  );
  var tSetFavoriteRequestModel = const FavoriteParams(true, 3);
  var mockProductModel = MockProductModel();
  var mockProductBloc = MockProductBloc();
  late MockGetAllProducts mockGetAllProducts;
  late MockSetFavoriteProduct mockSetFavoriteProduct;
  late MockSearchByTagId mockSearchByTagId;
  late MockSearchByProductName mockSearchByProductName;
  late ProductBloc tProductBloc;
  final List<Product> _listProducts = [];

  setUp(() {
    mockSetFavoriteProduct = MockSetFavoriteProduct();
    mockGetAllProducts = MockGetAllProducts();
    mockSearchByTagId = MockSearchByTagId();
    mockSearchByProductName = MockSearchByProductName();
    tProductBloc = ProductBloc(
      mockGetAllProducts,
      mockSetFavoriteProduct,
      mockSearchByTagId,
      mockSearchByProductName,
    );
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

      blocTest<ProductBloc, ProductState>(
        'should a list product when send [GetProductEvent]',
        build: () {
          when(mockGetAllProducts(const ProductsParams(0, 5))).thenAnswer(
            (_) async => Left(ServerException()),
          );
          when(mockGetAllProducts(const ProductsParams(0, 5))).thenAnswer(
            (_) async => Right(tProductModel),
          );

          return tProductBloc;
        },
        act: (bloc) => bloc.add(const GetProductEvent(5, 0)),
        expect: () => [
          ProductLoadingState(),
          const ProductLoadedState([], true),
        ],
      );

      blocTest<ProductBloc, ProductState>(
        'should a new status when set favorite product',
        build: () {
          //
          when(mockSetFavoriteProduct(tSetFavoriteRequestModel))
              .thenAnswer((_) async => Left(ServerException()));
          when(mockSetFavoriteProduct(tSetFavoriteRequestModel))
              .thenAnswer((_) async {
            return const Right(true);
          });

          when(mockGetAllProducts(const ProductsParams(0, 0))).thenAnswer(
            (_) async => Left(ServerException()),
          );
          when(mockGetAllProducts(const ProductsParams(0, 0))).thenAnswer(
            (_) async => Right(tProductModel),
          );

          return tProductBloc;
        },
        act: (bloc) {
          bloc.add(const ProductFavoriteSetEvent(3, true));
          bloc.add(const GetProductEvent(0, 0));
        },
        expect: () => [
          ProductLoadingState(),
          const ProductSetFavoriteProductState(true),
          const ProductLoadedState([], true),
          ProductLoadingState(),
          const ProductLoadedState([], true)
        ],
      );

      blocTest<ProductBloc, ProductState>(
        'should a array with products of one category',
        build: () {
          when(mockSearchByTagId(const SearchByParams(3)))
              .thenAnswer((_) async => Left(ServerException()));
          when(mockSearchByTagId(const SearchByParams(3)))
              .thenAnswer((_) async {
            _listProducts.clear();
            _listProducts.addAll(tProductModel.product);
            return Right(tProductModel);
          });

          return tProductBloc;
        },
        setUp: () {},
        act: (bloc) => bloc.add(const ProductFilterByTagEvent(3)),
        expect: () => [
          ProductLoadingState(),
          const ProductLoadedState([], true),
        ],
      );

      // Test of search by product name

      blocTest<ProductBloc, ProductState>(
        'should a array with products filtered by name',
        build: () {
          when(mockSearchByProductName(const SearchProductsParams('nike')))
              .thenAnswer(
            (_) async => Left(ServerException()),
          );
          when(mockSearchByProductName(const SearchProductsParams('nike')))
              .thenAnswer(
            (_) async => Right(tProductModel),
          );
          return tProductBloc;
        },
        act: (bloc) => bloc.add(const ProductFilterByNameEvent('nike')),
        expect: () => [
          ProductSearchByNameState(),
          ProductLoadedState(tProductModel.product,false)
        ],
      );
    },
  );
}
