import 'package:flutter/foundation.dart';
import 'package:winsvold/models/reduced_product.dart';
import 'package:equatable/equatable.dart';

enum Status { product, amount, overview }

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductFailed extends ProductState {}

class ProductSuccess extends ProductState {
  final ReducedProduct reducedProduct;

  ProductSuccess({required this.reducedProduct});

  @override
  List<Object> get props => [reducedProduct];

  @override
  String toString() => 'Success { categories: $reducedProduct }';
}

class ProductInvalid extends ProductState {}
