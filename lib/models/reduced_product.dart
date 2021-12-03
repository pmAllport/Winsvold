class ReducedProduct {
  ReducedProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.volume,
    required this.alcohol,
    required this.subCategory,
    required this.mainCategory,
    required this.mainCountry,
    required this.litrePrice,
    required this.usesShots,
    this.amount,
  });

  final String name;
  final double price;
  final Image image;
  final double volume;
  final double alcohol;
  final String subCategory;
  final String mainCategory;
  final String mainCountry;
  final double litrePrice;
  final bool usesShots;
  int? amount;

  factory ReducedProduct.fromJson(Map<String, dynamic> json) {
    String name = json['name'].toString();
    double price = json['price']['value'].toDouble();
    Image image = Image.fromJson(json['images']);
    double volume = json['volume']['value'].toDouble();
    double alcohol = json['alcohol']['value'].toDouble();
    String mainCategory = json['main_category']['name'].toString();

    // If we dont have a sub_category, like "vodka" for "brennevin", then we use their main category
    String subCategory = (json['main_sub_category'] != null
        ? (json['main_sub_category']['name']).toString()
        : mainCategory);

    // We use shots for brennevin and sake, and strong wine, but not for anything else
    bool usesShots = (mainCategory == 'Brennevin' ||
            mainCategory == 'Sake' ||
            mainCategory == 'Sterkvin')
        ? true
        : false;
    String country = json['main_country']['name'].toString();
    double litrePrice = json['litrePrice']['value'].toDouble();
    return ReducedProduct(
        name: name,
        price: price,
        image: image,
        volume: volume,
        alcohol: alcohol,
        mainCategory: mainCategory,
        subCategory: subCategory,
        mainCountry: country,
        litrePrice: litrePrice,
        usesShots: usesShots);
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
