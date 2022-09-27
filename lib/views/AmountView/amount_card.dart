import 'package:flutter/material.dart';
import 'package:winsvold/models/reduced_product.dart';

import 'amount_list_tile.dart';

class AmountCard extends StatefulWidget {
  final ReducedProduct reducedProduct;
  const AmountCard({
    required this.reducedProduct,
    Key? key,
  }) : super(key: key);

  @override
  _AmountCardState createState() => _AmountCardState();
}

class _AmountCardState extends State<AmountCard>
    with AutomaticKeepAliveClientMixin {
  late ReducedProduct reducedProduct;

  @override
  void initState() {
    super.initState();
    reducedProduct = widget.reducedProduct;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Card(
            borderOnForeground: true,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AmountListTile(
                    reducedProduct: reducedProduct,
                    context: context,
                  )),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
