import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/vinmonopolet/product_bucket.dart';
import 'package:winsvold/data/product_repository.dart';
import 'package:winsvold/views/Product/product.dart';
import 'package:winsvold/views/Product/product_tile.dart';

class ProductInvalidTile extends StatefulWidget {
  final BuildContext context;
  const ProductInvalidTile({required this.context, Key? key}) : super(key: key);

  @override
  _ProductInvalidTileState createState() => _ProductInvalidTileState();
}

class _ProductInvalidTileState extends State<ProductInvalidTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "Det ser ut som det leste produktnummeret er ugyldig.\n ",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Text(
            "Vennligst tast inn det korrekte produktnummeret.",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onSubmitted: (String input) {
                ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);
                productBloc.add(ProductRequested(productId: int.parse(input)));
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF002025))),
                hintText: 'Skriv inn produktnummer',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
