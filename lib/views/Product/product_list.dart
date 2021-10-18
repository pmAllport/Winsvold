import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/vinmonopolet/product_bucket.dart';
import 'package:winsvold/data/product_repository.dart';
import 'package:winsvold/views/Product/product.dart';
import 'package:winsvold/views/Product/product_tile.dart';

class ProductList extends StatefulWidget {
  final List<int> productList;
  const ProductList({required this.productList, Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Winsvold")),
      ),
      body: Center(
        child: ListView.builder(
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            itemCount: widget.productList.length,
            itemBuilder: (BuildContext context, int index) {
              return BlocProvider(
                  create: (context) =>
                      ProductBloc(repository: productRepository),
                  child: Product(productId: widget.productList[index]));
            }),
      ),
    );
  }
}
