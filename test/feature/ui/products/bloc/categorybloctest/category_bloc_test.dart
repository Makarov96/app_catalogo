import 'package:app_catalogo/feature/ui/products/bloc/categorybloc/category_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core_catalogo_module/core/error/exception.dart';
import 'package:core_catalogo_module/core/usecase/use_case.dart';

import 'package:core_catalogo_module/feature/data/model/response/category_model.dart';

import 'package:core_catalogo_module/feature/domain/repositories/store_repository.dart';

import 'package:core_catalogo_module/feature/domain/usecases/get_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'category_bloc_test.mocks.dart';

class MockCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements CategoryBloc {}

@GenerateMocks(
  [CategoryModel, ProductCategory, StoreRepository],
  customMocks: [
    MockSpec<GetCategoryUseCase>(returnNullOnMissingStub: false),
  ],
)
void main() {
  var mockGetCategoryUseCase = MockGetCategoryUseCase();
  var categoryBloc = MockCategoryBloc();
  //List<ProductCategory> _listProductCategory = [];
  var tCategoryModel = MockCategoryModel();
  var tNoParams = NoParams();

  test('test use case response', () {
    when(mockGetCategoryUseCase(tNoParams))
        .thenAnswer((_) async => Right(tCategoryModel));
  });

  group('test category bloc group', () {
    test('whenListen and return category list', () {
      whenListen(categoryBloc,
          Stream.fromIterable(<CategoryState>[CategoryInitial()]));
      expectLater(categoryBloc.stream,
          emitsInOrder(<CategoryState>[CategoryInitial()]));
    });

    /**
    * 
     blocTest<CategoryBloc, CategoryState>(
      'when send Caegory initial bloc',
      build: () {
        return CategoryBloc(mockGetCategoryUseCase);
      },
      setUp: () {
        _listProductCategory.add(
          ProductCategory('All', 1),
        );
      },
      act: (bloc) => bloc.add(CategoryInitialEvent()),
      expect: () => [
        CategoryLoading(),
        CategoryLoaded(tCategoryModel),
      ],
    );
    */

    blocTest<CategoryBloc, CategoryState>(
      'when send refresh event bloc',
      build: () => CategoryBloc(mockGetCategoryUseCase),
      act: (bloc) => bloc.add(CategoryRefreshlEvent(tCategoryModel)),
      expect: () => [CategoryLoaded(tCategoryModel)],
    );
  });

  group('test category bloc group whit error', () {
    test('test use case error', () {
      when(mockGetCategoryUseCase(tNoParams))
          .thenAnswer((_) async => Left(ServerException()));
    });

    blocTest<CategoryBloc, CategoryState>(
      'when send Caegory initial bloc and return error',
      build: () => CategoryBloc(mockGetCategoryUseCase),
      act: (bloc) => bloc.add(CategoryInitialEvent()),
      expect: () => [CategoryLoading(), CategoryError(ServerException())],
    );
  });
}
