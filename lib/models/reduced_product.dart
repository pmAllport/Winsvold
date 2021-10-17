import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:winsvold/models/product.dart' as Prod;

class ReducedProduct {
  ReducedProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.volume,
    required this.alcohol,
    required this.category,
    required this.mainCountry,
    required this.litrePrice,
  });

  final String name;
  final double price;
  final Image image;
  final double volume;
  final double alcohol;
  final String category;
  final String mainCountry;
  final double litrePrice;

  factory ReducedProduct.fromJson(Map<String, dynamic> json) {
    String name = json['name'].toString();
    double price = json['price']['value'].toDouble();
    Image image = Image.fromJson(json['images']);
    double volume = json['volume']['value'].toDouble();
    double alcohol = json['alcohol']['value'].toDouble();
    String category = (json['main_sub_category'] != null
            ? json['main_sub_category']['name']
            : json['main_category']['name'])
        .toString();
    String country = json['main_country']['name'].toString();
    double litrePrice = json['litrePrice']['value'].toDouble();
    return ReducedProduct(
      name: name,
      price: price,
      image: image,
      volume: volume,
      alcohol: alcohol,
      category: category,
      mainCountry: country,
      litrePrice: litrePrice,
    );
  }
}

class Image {
  Image({
    required this.url,
    required this.altText,
  });
  final String url;
  final String altText;
  // This needs to be fixed. It is bad to use "List<dynamic".
  factory Image.fromJson(List<dynamic> json) {
    return Image(
        url: json[0]['url'].toString(), altText: json[0]['altText'].toString());
  }
}
