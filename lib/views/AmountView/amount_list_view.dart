import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:winsvold/models/reduced_product.dart';
import 'package:winsvold/utils/navigator_arguments.dart';
import 'package:winsvold/views/AmountView/amount_card.dart';
import 'package:winsvold/views/routes.dart';

class AmountList extends StatefulWidget {
  final Map<UniqueKey, ReducedProduct> reducedProductMap;
  const AmountList({required this.reducedProductMap, Key? key})
      : super(key: key);

  @override
  _AmountListState createState() => _AmountListState();
}

class _AmountListState extends State<AmountList> {
  late final Map<UniqueKey, ReducedProduct> reducedProductMap =
      widget.reducedProductMap;

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
              return AmountCard(
                  reducedProduct: reducedProductMap.values.elementAt(index));
            },
            childCount: reducedProductMap.values.length,
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
                          ExtractSummaryList.routeName,
                          arguments: SummaryArguments(
                              reducedProductMap: reducedProductMap))
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
