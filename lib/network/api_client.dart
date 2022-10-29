import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:quotez/data/model/quote.dart';

/// [ApiClient] handles all API requests.
class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://quotes.stormconsultancy.co.uk',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  Future<Quote> getRandomQuote() async {
    final String response =
        await rootBundle.loadString('assets/all-quotes.json');

     List myModels = (json.decode(response) as List)
        .map((i) => Quote.fromJson(i))
        .toList();

    var intValue = Random().nextInt(myModels.length); // Value is >= 0 and < 10.

    return myModels[intValue];
  }
}
