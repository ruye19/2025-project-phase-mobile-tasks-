import 'dart:io';

String fixture(String name) =>
    File('test/features/product/utils/fixtures/$name').readAsStringSync();
