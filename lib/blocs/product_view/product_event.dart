import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List get props => [];
}

class ProductRequested extends ProductEvent {
  final int productId;

  const ProductRequested({required this.productId});

  @override

  // This defines the props you need to check to determine if the state has changed.
  List get props => [productId];
}
