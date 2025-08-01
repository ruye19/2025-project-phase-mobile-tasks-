#  E-Commerce App (Clean Architecture)

This project implements an **E-commerce feature** using **Flutter** and follows **Clean Architecture** principles for better separation of concerns, testability, and maintainability.

---

## 📂 Project Structure
The app uses **Clean Architecture** and is organized into three main layers:


---

## 🧠 **Clean Architecture Overview**
- **Domain Layer**  
  - Contains **Entities** and **Use Cases** (pure Dart code, no Flutter dependency).
  - Example: `Product` entity.

- **Data Layer**  
  - Implements repositories, models, and data sources.
  - Example: `ProductModel` with `fromJson` and `toJson` methods.

- **Presentation Layer**  
  - Handles UI and state management (Bloc/Cubit).

---

## 🔄 **Data Flow**
UI → Bloc → UseCase → Repository → DataSource → API/Local DB → Back to UI


---

## ✅ Task 10 Summary
- **Step 1:** Organized project using **Clean Architecture folder structure**.
- **Step 2:** Implemented `ProductModel` with JSON conversion.
- **Step 3:** Created **unit tests** using **fixture-based approach**.
- **Step 4:** Documented architecture and data flow in this README.

---

## 🧪 Testing Strategy
We use **fixtures** for test data to keep tests clean and consistent.

### **Test Folder Structure**
test/
└── features/
└── product/
├── data/
│ └── models/
│ └── product_model_test.dart
└── utils/
├── fixture_reader.dart
└── fixtures/
└── product.json


---

### **Fixture Example**
`test/features/product/utils/fixtures/product.json`:
```json
{
  "id": "1",
  "name": "Test Product",
  "description": "A sample product for testing",
  "imageUrl": "http://example.com/image.png",
  "price": 29.99
}
Fixture Reader Utility
test/features/product/utils/fixture_reader.dart:

import 'dart:io';

String fixture(String name) =>
    File('test/features/product/utils/fixtures/$name').readAsStringSync();
Sample Test
product_model_test.dart:


import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import '../../utils/fixture_reader.dart';

void main() {
  const testProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'A sample product for testing',
    imageUrl: 'http://example.com/image.png',
    price: 29.99,
  );

  test('should be a subclass of Product entity', () {
    expect(testProductModel, isA<Product>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      final jsonMap = json.decode(fixture('product.json')) as Map<String, dynamic>;
      final result = ProductModel.fromJson(jsonMap);
      expect(result, equals(testProductModel));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      final result = testProductModel.toJson();
      expect(result, equals(json.decode(fixture('product.json'))));
    });
  });
}
✅ How to Run Tests
Run all tests with:


flutter test
✅ How to Run the App
flutter pub get
flutter run
✅ Next Steps
Add repository and datasource layers for fetching products from an API or local DB.

Implement Bloc for state management in presentation/.


---
