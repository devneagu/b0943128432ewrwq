import 'dart:convert';
import 'dart:io';

// Fixture idea by [@kranfix](https://github.com/kranfix)
String fixture(String name) => jsonMinifier(rawFixture(name));

String jsonMinifier(String json) => jsonEncode(jsonDecode(json));

String rawFixture(String name) =>
    File('test/fixtures/$name').readAsStringSync();
