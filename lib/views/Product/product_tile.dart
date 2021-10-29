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
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width - 100,
              child: Stack(
                children: [
                  Center(
                    child: Image.network(widget.reducedProduct.image.url,
                        fit: BoxFit.fitHeight),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.error,
                        color: Theme.of(context).colorScheme.error,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              )),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _isExpanded ? 220 : 65,
            width: MediaQuery.of(context).size.width - 80,
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ExpansionTile(
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          onExpansionChanged: (bool expanded) {
                            setState(() => _isExpanded = expanded);
                          },
                          trailing: Icon(
                              _isExpanded
                                  ? Icons.arrow_drop_down_circle
                                  : Icons.arrow_drop_down_circle_outlined,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary),
                          title: Padding(
                            padding: EdgeInsets.only(
                                left: (MediaQuery.of(context).size.width / 8)),
                            child: Text(
                              widget.reducedProduct.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Column(
                                children: [
                                  textCategoryString(
                                      "Alkoholtype: ",
                                      widget.reducedProduct.subCategory,
                                      context),
                                  textCategoryString(
                                      "Produksjonsland: ",
                                      widget.reducedProduct.mainCountry,
                                      context),
                                  textCategoryString(
                                      "Volum: ",
                                      (((widget.reducedProduct.volume * 100)
                                              .toInt()
                                              .toString()) +
                                          "cl"),
                                      context),
                                  textCategoryString(
                                      "Alkoholprosent: ",
                                      widget.reducedProduct.alcohol.toString() +
                                          "%",
                                      context),
                                  textCategoryString(
                                      "Literspris: ",
                                      widget.reducedProduct.litrePrice
                                              .toString() +
                                          "kr",
                                      context),
                                  textCategoryString(
                                      "Pris per flaske: ",
                                      widget.reducedProduct.price.toString() +
                                          "kr",
                                      context),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.reducedProduct.usesShots
                  ? Column(
                      children: [
                        textInfoString(
                            "Pris per shot",
                            (calculatePricePerShotWithSpoilage(
                                        widget.reducedProduct.price,
                                        widget.reducedProduct.volume)
                                    .toStringAsFixed(2) +
                                "kr"),
                            context),
                        textInfoString(
                            "Pris per shot avrundet",
                            (calculateFinalShotPriceCeiling(
                                        widget.reducedProduct.price,
                                        widget.reducedProduct.volume)
                                    .toStringAsFixed(2) +
                                "kr"),
                            context),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: textInfoString(
                              "Pris per flaske",
                              calculateBottlePrice(widget.reducedProduct.price)
                                      .toStringAsFixed(2) +
                                  "kr",
                              context),
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget productTile(BuildContext context, rp.ReducedProduct reducedProduct) extends StatefulWidget{
//   bool _isExpanded = false;
//   Widget build(BuildContext context){

//   return Contaner();
// }

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

double calculateBottlePrice(double price) {
  return (price / 5).ceilToDouble() * 5;
}


// name: name,
//       price: price,
//       image: image,
//       volume: volume,
//       alcohol: alcohol,
//       category: category,
//       mainCountry: country,
//       litrePrice: litrePrice,


