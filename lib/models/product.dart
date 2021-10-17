import 'package:flutter/foundation.dart';

class Product {
  Product({
    required this.code,
    required this.name,
    required this.url,
    required this.description,
    required this.summary,
    required this.price,
    required this.images,
    required this.tags,
    required this.isGoodFor,
    required this.expiredDate,
    required this.distributor,
    required this.distributorId,
    required this.ageLimit,
    required this.volume,
    required this.storeCategory,
    required this.color,
    required this.smell,
    required this.taste,
    required this.year,
    required this.method,
    required this.alcohol,
    required this.eco,
    required this.wholeSaler,
    required this.packageType,
    required this.cork,
    required this.environmentalPackaging,
    required this.fairTrade,
    required this.bioDynamic,
    required this.raastoff,
    required this.productSelection,
    required this.status,
    required this.mainCategory,
    required this.mainSubCategory,
    required this.mainSubSubCategory,
    required this.mainCountry,
    required this.mainProducer,
    required this.district,
    required this.litrePrice,
    required this.buyable,
    required this.gluten,
    required this.kosher,
    required this.availability,
    required this.expired,
    required this.similarProducts,
    required this.statusNotification,
  });
  late final String code;
  late final String name;
  late final String url;
  late final String description;
  late final String summary;
  late final Price price;
  late final List<Images> images;
  late final List<String> tags;
  late final List<dynamic> isGoodFor;
  late final String expiredDate;
  late final String distributor;
  late final int distributorId;
  late final int ageLimit;
  late final Volume volume;
  late final String storeCategory;
  late final String color;
  late final String smell;
  late final String taste;
  late final String year;
  late final String method;
  late final Alcohol alcohol;
  late final bool eco;
  late final String wholeSaler;
  late final String packageType;
  late final String cork;
  late final bool environmentalPackaging;
  late final bool fairTrade;
  late final bool bioDynamic;
  late final List<Raastoff> raastoff;
  late final String productSelection;
  late final String status;
  late final MainCategory mainCategory;
  late final MainSubCategory mainSubCategory;
  late final MainSubSubCategory mainSubSubCategory;
  late final MainCountry mainCountry;
  late final MainProducer mainProducer;
  late final District district;
  late final LitrePrice litrePrice;
  late final bool buyable;
  late final bool gluten;
  late final bool kosher;
  late final Availability availability;
  late final bool expired;
  late final bool similarProducts;
  late final bool statusNotification;

  Product.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    url = json['url'];
    description = json['description'];
    summary = json['summary'];
    price = Price.fromJson(json['price']);
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    isGoodFor = List.castFrom<dynamic, dynamic>(json['isGoodFor']);
    expiredDate = json['expiredDate'];
    distributor = json['distributor'];
    distributorId = json['distributorId'];
    ageLimit = json['ageLimit'];
    volume = Volume.fromJson(json['volume']);
    storeCategory = json['storeCategory'];
    color = json['color'];
    smell = json['smell'];
    taste = json['taste'];
    year = json['year'];
    method = json['method'];
    alcohol = Alcohol.fromJson(json['alcohol']);
    eco = json['eco'];
    wholeSaler = json['wholeSaler'];
    packageType = json['packageType'];
    cork = json['cork'];
    environmentalPackaging = json['environmentalPackaging'];
    fairTrade = json['fairTrade'];
    bioDynamic = json['bioDynamic'];
    raastoff =
        List.from(json['raastoff']).map((e) => Raastoff.fromJson(e)).toList();
    productSelection = json['product_selection'];
    status = json['status'];
    mainCategory = MainCategory.fromJson(json['main_category']);
    mainSubCategory = MainSubCategory.fromJson(json['main_sub_category']);
    mainSubSubCategory =
        MainSubSubCategory.fromJson(json['main_sub_sub_category']);
    mainCountry = MainCountry.fromJson(json['main_country']);
    mainProducer = MainProducer.fromJson(json['main_producer']);
    district = District.fromJson(json['district']);
    litrePrice = LitrePrice.fromJson(json['litrePrice']);
    buyable = json['buyable'];
    gluten = json['gluten'];
    kosher = json['kosher'];
    availability = Availability.fromJson(json['availability']);
    expired = json['expired'];
    similarProducts = json['similarProducts'];
    statusNotification = json['statusNotification'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['name'] = name;
    _data['url'] = url;
    _data['description'] = description;
    _data['summary'] = summary;
    _data['price'] = price.toJson();
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['tags'] = tags;
    _data['isGoodFor'] = isGoodFor;
    _data['expiredDate'] = expiredDate;
    _data['distributor'] = distributor;
    _data['distributorId'] = distributorId;
    _data['ageLimit'] = ageLimit;
    _data['volume'] = volume.toJson();
    _data['storeCategory'] = storeCategory;
    _data['color'] = color;
    _data['smell'] = smell;
    _data['taste'] = taste;
    _data['year'] = year;
    _data['method'] = method;
    _data['alcohol'] = alcohol.toJson();
    _data['eco'] = eco;
    _data['wholeSaler'] = wholeSaler;
    _data['packageType'] = packageType;
    _data['cork'] = cork;
    _data['environmentalPackaging'] = environmentalPackaging;
    _data['fairTrade'] = fairTrade;
    _data['bioDynamic'] = bioDynamic;
    _data['raastoff'] = raastoff.map((e) => e.toJson()).toList();
    _data['product_selection'] = productSelection;
    _data['status'] = status;
    _data['main_category'] = mainCategory.toJson();
    _data['main_sub_category'] = mainSubCategory.toJson();
    _data['main_sub_sub_category'] = mainSubSubCategory.toJson();
    _data['main_country'] = mainCountry.toJson();
    _data['main_producer'] = mainProducer.toJson();
    _data['district'] = district.toJson();
    _data['litrePrice'] = litrePrice.toJson();
    _data['buyable'] = buyable;
    _data['gluten'] = gluten;
    _data['kosher'] = kosher;
    _data['availability'] = availability.toJson();
    _data['expired'] = expired;
    _data['similarProducts'] = similarProducts;
    _data['statusNotification'] = statusNotification;
    return _data;
  }
}

class Price {
  Price({
    required this.value,
    required this.formattedValue,
    required this.readableValue,
  });
  late final double value;
  late final String formattedValue;
  late final String readableValue;

  Price.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    formattedValue = json['formattedValue'];
    readableValue = json['readableValue'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['formattedValue'] = formattedValue;
    _data['readableValue'] = readableValue;
    return _data;
  }
}

class Images {
  Images({
    required this.imageType,
    required this.format,
    required this.url,
    required this.altText,
  });
  late final String imageType;
  late final String format;
  late final String url;
  late final String altText;

  Images.fromJson(Map<String, dynamic> json) {
    imageType = json['imageType'];
    format = json['format'];
    url = json['url'];
    altText = json['altText'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageType'] = imageType;
    _data['format'] = format;
    _data['url'] = url;
    _data['altText'] = altText;
    return _data;
  }
}

class Volume {
  Volume({
    required this.value,
    required this.formattedValue,
    required this.readableValue,
  });
  late final double value;
  late final String formattedValue;
  late final String readableValue;

  Volume.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    formattedValue = json['formattedValue'];
    readableValue = json['readableValue'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['formattedValue'] = formattedValue;
    _data['readableValue'] = readableValue;
    return _data;
  }
}

class Alcohol {
  Alcohol({
    required this.value,
    required this.formattedValue,
  });
  late final double value;
  late final String formattedValue;

  Alcohol.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    formattedValue = json['formattedValue'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['formattedValue'] = formattedValue;
    return _data;
  }
}

class Raastoff {
  Raastoff({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  Raastoff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class MainCategory {
  MainCategory({
    required this.code,
    required this.name,
    required this.url,
  });
  late final String code;
  late final String name;
  late final String url;

  MainCategory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class MainSubCategory {
  MainSubCategory({
    required this.code,
    required this.name,
    required this.url,
  });
  late final String code;
  late final String name;
  late final String url;

  MainSubCategory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class MainSubSubCategory {
  MainSubSubCategory({
    required this.code,
    required this.name,
    required this.url,
  });
  late final String code;
  late final String name;
  late final String url;

  MainSubSubCategory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class MainCountry {
  MainCountry({
    required this.code,
    required this.name,
    required this.url,
  });
  late final String code;
  late final String name;
  late final String url;

  MainCountry.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class MainProducer {
  MainProducer({
    required this.code,
    required this.name,
    required this.url,
  });
  late final String code;
  late final String name;
  late final String url;

  MainProducer.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class District {
  District({
    required this.code,
    required this.name,
    required this.url,
  });
  late final String code;
  late final String name;
  late final String url;

  District.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class LitrePrice {
  LitrePrice({
    required this.value,
    required this.formattedValue,
    required this.readableValue,
  });
  late final double value;
  late final String formattedValue;
  late final String readableValue;

  LitrePrice.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    formattedValue = json['formattedValue'];
    readableValue = json['readableValue'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['formattedValue'] = formattedValue;
    _data['readableValue'] = readableValue;
    return _data;
  }
}

class Availability {
  Availability({
    required this.storeAvailability,
    required this.deliveryAvailability,
  });
  late final StoreAvailability storeAvailability;
  late final DeliveryAvailability deliveryAvailability;

  Availability.fromJson(Map<String, dynamic> json) {
    storeAvailability = StoreAvailability.fromJson(json['storeAvailability']);
    deliveryAvailability =
        DeliveryAvailability.fromJson(json['deliveryAvailability']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['storeAvailability'] = storeAvailability.toJson();
    _data['deliveryAvailability'] = deliveryAvailability.toJson();
    return _data;
  }
}

class StoreAvailability {
  StoreAvailability({
    required this.available,
    required this.mainText,
    required this.stockLink,
  });
  late final bool available;
  late final String mainText;
  late final StockLink stockLink;

  StoreAvailability.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    mainText = json['mainText'];
    stockLink = StockLink.fromJson(json['stockLink']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['available'] = available;
    _data['mainText'] = mainText;
    _data['stockLink'] = stockLink.toJson();
    return _data;
  }
}

class StockLink {
  StockLink({
    required this.link,
    required this.text,
  });
  late final bool link;
  late final String text;

  StockLink.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['link'] = link;
    _data['text'] = text;
    return _data;
  }
}

class DeliveryAvailability {
  DeliveryAvailability({
    required this.available,
    required this.mainText,
    required this.orderableText,
  });
  late final bool available;
  late final String mainText;
  late final String orderableText;

  DeliveryAvailability.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    mainText = json['mainText'];
    orderableText = json['orderableText'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['available'] = available;
    _data['mainText'] = mainText;
    _data['orderableText'] = orderableText;
    return _data;
  }
}
