import 'package:flutter/material.dart';
import 'package:winsvold/models/reduced_product.dart';

class ProductArguments {
  final List<int> productList;
  ProductArguments({required this.productList});
}

class AmountArguments {
  final Map<UniqueKey, ReducedProduct> reducedProductMap;
  AmountArguments({required this.reducedProductMap});
}
