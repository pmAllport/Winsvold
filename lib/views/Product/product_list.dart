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

  late List<int> productList = widget.productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomScrollView(slivers: <Widget>[
        const SliverAppBar(
          title: Text('Winsvold'),
          centerTitle: true,
          expandedHeight: 60.0,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return BlocProvider(
                  create: (context) =>
                      ProductBloc(repository: productRepository),
                  child: Product(productId: productList[index]));
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
                      _buildDialog(context, productList, refresh),
                    }),
                child: const Text("Legg til nytt produkt"),
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
