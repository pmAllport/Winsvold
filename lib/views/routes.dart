import 'package:flutter/material.dart';
import 'package:winsvold/utils/navigator_arguments.dart';
import 'package:winsvold/views/AmountView/amount_list_view.dart';
import 'package:winsvold/views/ProductView/product_list.dart';

class ExtractProductList extends StatelessWidget {
  static const routeName = '/productList';
  const ExtractProductList();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    return ProductList(productList: args.productList);
  }
}

class ExtractAmountList extends StatelessWidget {
  static const routeName = '/amountList';
  const ExtractAmountList();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    return AmountList(productList: args.productList);
  }
}
