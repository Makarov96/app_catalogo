import 'dart:io';

import 'package:app_catalogo/feature/ui/products/bloc/categorybloc/category_bloc.dart';
import 'package:app_catalogo/feature/ui/products/widget/custom_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 50,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            return CustomTabBar(
              categories: state.category.listProductCategory,
            );
          } else if (state is CategoryLoading) {
            return Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  );
          } else {
            return Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  );
          }
        },
      ),
    );
  }
}
