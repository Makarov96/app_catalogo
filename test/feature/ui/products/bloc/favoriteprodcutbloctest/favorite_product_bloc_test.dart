import 'package:app_catalogo/feature/ui/products/bloc/favoriteproductbloc/favorite_product_bloc.dart';
import 'package:core_catalogo_module/core/usecase/use_case.dart';
import 'package:core_catalogo_module/feature/data/model/response/product_model.dart';
import 'package:core_catalogo_module/feature/domain/usecases/get_by_favorite_status_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'favorite_product_bloc_test.mocks.dart';

class MockFavoriteProductBloc
    extends MockBloc<FavoriteProductEvent, FavoriteProductState>
    implements FavoriteProductBloc {}

@GenerateMocks(
  [
    GetProductByFavoriteStatusProduct,
  ],
)
void main() {
  late GetProductByFavoriteStatusProduct mockUseCase;
  late FavoriteProductBloc tFavoriteBloc;
  late MockFavoriteProductBloc mockFPBloc;
  var mockProductModel = ProductModel(product: <Product>[]);
  var mockProductList = <Product>[];

  setUp(() {
    mockUseCase = MockGetProductByFavoriteStatusProduct();
    mockFPBloc = MockFavoriteProductBloc();
    tFavoriteBloc = FavoriteProductBloc(mockUseCase);
  });

  group(
    'test favorite bloc ',
    () {
      test(
        'should a init state',
        () {
          whenListen(
            mockFPBloc,
            Stream.fromIterable(
              [FavoriteProductInitial(), FavoriteProductLoadingState()],
            ),
            initialState: FavoriteProductInitial(),
          );
        },
      );

      blocTest<FavoriteProductBloc, FavoriteProductState>(
        'expect a list of product',
        build: () {
          when(mockUseCase(NoParams())).thenAnswer(
            (realInvocation) async => Right(mockProductModel),
          );
          mockProductList.clear();
          return tFavoriteBloc;
        },
        act: (bloc) => bloc.add(GetFavoriteProductEvent()),
        expect: () => [
          FavoriteProductLoadingState(),
          FavoriteProductLoadedState(mockProductModel.product)
        ],
      );
    },
  );
}
