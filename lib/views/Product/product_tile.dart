import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/models/reduced_product.dart' as rp;
import 'dart:core';

class ProductTile extends StatefulWidget {
  final rp.ReducedProduct reducedProduct;
  const ProductTile({required this.reducedProduct, Key? key}) : super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return productTile(context, widget.reducedProduct);
  }
}

Widget productTile(BuildContext context, rp.ReducedProduct reducedProduct) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
            height: 100,
            width: 100,
            child:
                Image.network(reducedProduct.image.url, fit: BoxFit.fitHeight)),
        Flexible(
          fit: FlexFit.loose,
          child: ExpansionTile(
              title: Text(
                reducedProduct.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      textCategoryString(
                          "Alkoholtype: ", reducedProduct.category, context),
                      textCategoryString("Produksjonsland: ",
                          reducedProduct.mainCountry, context),
                      textCategoryString(
                          "Volum: ",
                          (((reducedProduct.volume * 100).toInt().toString()) +
                              "cl"),
                          context),
                      textCategoryString("Alkoholprosent: ",
                          reducedProduct.alcohol.toString() + "%", context),
                      textCategoryString("Literspris: ",
                          reducedProduct.litrePrice.toString() + "kr", context),
                      textCategoryString("Pris per flaske: ",
                          reducedProduct.price.toString() + "kr", context),
                    ],
                  ),
                ),
              ]),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                textInfoString(
                    "Pris per shot",
                    (calculatePricePerShotWithSpoilage(
                                reducedProduct.price, reducedProduct.volume)
                            .toStringAsFixed(2) +
                        "kr"),
                    context),
                textInfoString(
                    "Pris per shot avrundet",
                    (calculateFinalShotPriceCeiling(
                                reducedProduct.price, reducedProduct.volume)
                            .toStringAsFixed(2) +
                        "kr"),
                    context),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget textInfoString(String text, String value, context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: Theme.of(context).textTheme.subtitle1),
      ),
      Align(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(value, style: Theme.of(context).textTheme.subtitle2),
            )),
      ),
    ],
  );
}

Widget textCategoryString(String category, String value, context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Text(category, style: Theme.of(context).textTheme.subtitle1),
        Text(value, style: Theme.of(context).textTheme.subtitle2)
      ],
    ),
  );
}

double calculateAmountShots(double volume) {
  return volume * 100 / 4;
}

double calculatePricePerShot(double price, double amountShots) {
  return price / amountShots;
}

double calculatePricePerShotWithSpoilage(double price, double volume) {
  return calculatePricePerShot(price, calculateAmountShots(volume)) * 1.4;
}

double calculateFinalShotPriceCeiling(double price, double volume) {
  return (calculatePricePerShotWithSpoilage(price, volume) / 5).ceilToDouble() *
      5;
}


// name: name,
//       price: price,
//       image: image,
//       volume: volume,
//       alcohol: alcohol,
//       category: category,
//       mainCountry: country,
//       litrePrice: litrePrice,
