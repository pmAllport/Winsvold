import 'package:flutter/material.dart';
import 'package:winsvold/utils/navigator_arguments.dart';
import 'package:winsvold/views/Product/product_list.dart';

class ExtractProductList extends StatelessWidget {
  static const routeName = '/productList';
  const ExtractProductList();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    return ProductList(productList: args.productList);
  }
}
