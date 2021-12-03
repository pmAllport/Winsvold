import 'dart:async';
import 'package:http/http.dart';

class ProductRepository {
  ProductRepository();

  Future<StreamedResponse?> fetchProduct(
      {required int productId, required Client client}) async {
    String url =
        'https://www.vinmonopolet.no/api/products/$productId?fields=FULL';
    Request request = Request('GET', Uri.parse(url))..followRedirects = false;

    StreamedResponse response = await client.send(request);

    StreamedResponse? res = await redirectHandler(response, client);

    if (res == null) {
      return null;
    } else {
      return res;
    }
  }
}

Future<StreamedResponse?> redirectHandler(
    StreamedResponse res, Client client) async {
  if (res.statusCode == 302) {
    if (res.headers['location'] != null) {
      Request req = Request('GET', Uri.parse(res.headers['location']!))
        ..followRedirects = false;

      if (res.headers['set-cookie'] != null) {
        req.headers['cookie'] = res.headers['set-cookie']!;
      }

      StreamedResponse recursiveResponse = await client.send(req);
      return redirectHandler(recursiveResponse, client);
    } else {
      return null;
    }
  } else {
    return res;
  }
}
