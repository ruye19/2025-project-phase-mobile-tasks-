import 'dart:io';

// Product Class
class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  // Getters
  String get name => _name;
  String get description => _description;
  double get price => _price;

  // Setters
  set name(String newName) {
    _name = newName;
  }

  set description(String newDescription) {
    _description = newDescription;
  }

  set price(double newPrice) {
    _price = newPrice;
  }

  @override
  String toString() {
    return 'Name: $_name\nDescription: $_description\nPrice: \$${_price.toStringAsFixed(2)}';
  }
}

// Product Manager Class
class ProductManager {
  final List<Product> _products = [];

  void addProduct(String name, String description, double price) {
    _products.add(Product(name, description, price));
    print('Product added successfully!\n');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print(' No products available.\n');
      return;
    }

    for (int i = 0; i < _products.length; i++) {
      print('--- Product ${i + 1} ---');
      print(_products[i]);
      print('----------------------\n');
    }
  }

  void viewProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print(' Invalid product number.\n');
      return;
    }

    print(_products[index]);
  }

  void editProduct(int index, {String? name, String? description, double? price}) {
    if (index < 0 || index >= _products.length) {
      print('Invalid product number.\n');
      return;
    }

    if (name != null) _products[index].name = name;
    if (description != null) _products[index].description = description;
    if (price != null) _products[index].price = price;

    print('Product updated successfully!\n');
  }

  void deleteProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print(' Invalid product number.\n');
      return;
    }

    _products.removeAt(index);
    print('Product deleted successfully!\n');
  }

  int get productCount => _products.length;
}

// Main Program Loop
void main() {
  final manager = ProductManager();
  while (true) {
    print('==== eCommerce CLI ====');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Single Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    stdout.write('Enter your choice: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter product description: ');
        String description = stdin.readLineSync()!;
        stdout.write('Enter product price: ');
        double price = double.tryParse(stdin.readLineSync()!) ?? 0.0;
        manager.addProduct(name, description, price);
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        stdout.write('Enter product number to view: ');
        int index = int.tryParse(stdin.readLineSync()!) ?? -1;
        manager.viewProduct(index - 1);
        break;

      case '4':
        stdout.write('Enter product number to edit: ');
        int index = int.tryParse(stdin.readLineSync()!) ?? -1;
        stdout.write('Enter new name (leave blank to skip): ');
        String newName = stdin.readLineSync()!;
        stdout.write('Enter new description (leave blank to skip): ');
        String newDesc = stdin.readLineSync()!;
        stdout.write('Enter new price (leave blank to skip): ');
        String priceInput = stdin.readLineSync()!;
        manager.editProduct(
          index - 1,
          name: newName.isNotEmpty ? newName : null,
          description: newDesc.isNotEmpty ? newDesc : null,
          price: priceInput.isNotEmpty ? double.tryParse(priceInput) : null,
        );
        break;

      case '5':
        stdout.write('Enter product number to delete: ');
        int index = int.tryParse(stdin.readLineSync()!) ?? -1;
        manager.deleteProduct(index - 1);
        break;

      case '6':
        print(' Exiting program.');
        return;

      default:
        print(' Invalid choice. Try again.\n');
    }
  }
}
