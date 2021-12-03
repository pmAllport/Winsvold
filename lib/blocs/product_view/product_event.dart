import 'package:equatable/equatable.dart';
import 'package:winsvold/models/reduced_product.dart';

abstract class ProductEvent extends Equatable {
  ProductEvent();

  @override
  List get props => [];
}

class ProductRequested extends ProductEvent {
  final int productId;

  ProductRequested({required this.productId});

  @override

  // This defines the props you need to check to determine if the state has changed.
  List get props => [productId];
}
