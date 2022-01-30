import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:myapp/memes/memes.dart';

Future<Memes> fetchMemes() async {
  final response =
  await http.get(Uri.parse('https://meme-api.herokuapp.com/gimme/50'));

  if (response.statusCode == 200) {
    return compute(parseMemes, response.body);
  } else {
    throw Exception('Failed to load memes');
  }
}

Memes parseMemes(String responseBody) {
  return Memes.fromJson(jsonDecode(responseBody));
}