import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/vinmonopolet/product_bucket.dart';
import 'package:winsvold/data/product_repository.dart';
import 'package:winsvold/views/AmountView/amount_card.dart';
import 'package:winsvold/views/ProductView/product.dart';
import 'package:winsvold/views/ProductView/product_view_tile.dart';

class AmountList extends StatefulWidget {
  final List<int> productList;
  const AmountList({required this.productList, Key? key}) : super(key: key);

  @override
  _AmountListState createState() => _AmountListState();
}

class _AmountListState extends State<AmountList> {
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
                  child: AmountCard(productId: productList[index]));
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
                      // Navigator.of(context).pushNamed(
                      //     ExtractAmountList.routeName,
                      //     arguments: ProductArguments(productList: productList))
                    }),
                child: const Text("Ferdig"),
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
