import 'package:flutter/material.dart';
import 'package:winsvold/models/reduced_product.dart';
import 'package:winsvold/views/summary_view/summary_card_view.dart';

class SummaryListView extends StatefulWidget {
  final Map<UniqueKey, ReducedProduct> reducedProductMap;
  const SummaryListView({required this.reducedProductMap, Key? key})
      : super(key: key);

  @override
  _SummaryListViewState createState() => _SummaryListViewState();
}

class _SummaryListViewState extends State<SummaryListView> {
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
              return SummaryCard(
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
                onPressed: (() => {}),
                child: const Text("Send epost til festkassen."),
              ),
            ),
          ),
        )
      ])),
    );
  }
}
