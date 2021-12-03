import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/product_view/product_bucket.dart';
import 'package:winsvold/data/product_repository.dart';
import 'package:winsvold/models/reduced_product.dart';
import 'package:winsvold/utils/navigator_arguments.dart';
import 'package:winsvold/views/ProductView/product.dart';
import 'package:winsvold/views/ProductView/product_view_tile.dart';

import '../routes.dart';

class ProductList extends StatefulWidget {
  final List<int> productList;
  const ProductList({required this.productList, Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final productRepository = ProductRepository();

  late List<int> productList = widget.productList;
  final Map<UniqueKey, ReducedProduct> reducedProductMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: const Text('Winsvold'),
          centerTitle: true,
          expandedHeight: 60.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: const Icon(Icons.add_circle_outlined),
                onPressed: (() => {
                      _buildDialog(context, productList, refresh),
                    }),
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return BlocProvider(
                  create: (context) =>
                      ProductBloc(repository: productRepository),
                  child: Product(
                    productId: productList[index],
                    reducedProductMap: reducedProductMap,
                  ));
            },
            childCount: productList.length,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: (() => {
                      Navigator.of(context).pushNamed(
                          ExtractAmountList.routeName,
                          arguments: AmountArguments(
                              reducedProductMap: reducedProductMap)),
                    }),
                child: const Text("Fortsett videre og sett inn antall"),
              ),
            ),
          ),
        )
      ])),
    );
  }

  void refresh() {
    setState(() {});
  }
}

Future<void> _buildDialog(BuildContext context, List<int> productList,
    Function() triggerRefresh) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Nytt produkt?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Vennligst skriv inn produktnummeret.'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (String input) {
                  productList.add(int.parse(input));
                  triggerRefresh();
                  Navigator.of(context).pop();
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF002025))),
                  hintText: 'Skriv inn produktnummer',
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
