# E-commerce Mobile App

A Flutter-based e-commerce application that demonstrates clean architecture and BLoC pattern implementation.

## Project Structure

The project follows a clean architecture pattern with the following directory structure:

```
lib/
├── core/
│   ├── constants/
│   ├── error/
│   └── network/
├── features/
│   └── product/
│       ├── data/
│       │   ├── data_sources/
│       │   │   ├── local/
│       │   │   └── remote/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           └── bloc/
│               ├── product_bloc.dart
│               ├── product_event.dart
│               └── product_state.dart
└── ...
```

## BLoC Implementation

The application uses the BLoC (Business Logic Component) pattern for state management. The BLoC handles the business logic and state management for product-related operations.

### Key Components

1. **Events**
   - `LoadAllProductsEvent`: Fetches all products
   - `GetSingleProductEvent`: Retrieves a single product by ID
   - `UpdateProductEvent`: Updates an existing product
   - `DeleteProductEvent`: Deletes a product
   - `CreateProductEvent`: Creates a new product

2. **States**
   - `InitialState`: Initial state before any data is loaded
   - `LoadingState`: Indicates data is being fetched
   - `LoadedAllProductsState`: Contains the list of all products
   - `LoadedSingleProductState`: Contains a single product
   - `ErrorState`: Contains error message if any operation fails
   - `ProductOperationSuccess`: Indicates successful CRUD operation

### Usage

1. **Initialize the BLoC**

```dart
final productBloc = ProductBloc(
  getAllProducts: getAllProducts,
  getSingleProduct: getSingleProduct,
  updateProduct: updateProduct,
  deleteProduct: deleteProduct,
  createProduct: createProduct,
);
```

2. **Dispatch Events**

```dart
// Load all products
productBloc.add(LoadAllProductsEvent());

// Get single product
productBloc.add(GetSingleProductEvent(productId: 1));

// Create product
productBloc.add(CreateProductEvent(productData: {
  'title': 'New Product',
  'price': 99.99,
  'description': 'Product description',
}));

// Update product
productBloc.add(UpdateProductEvent(
  productId: 1,
  updatedData: {'title': 'Updated Title'},
));

// Delete product
productBloc.add(DeleteProductEvent(productId: 1));
```

3. **Listen to State Changes**

```dart
BlocBuilder<ProductBloc, ProductState>(
  builder: (context, state) {
    if (state is LoadingState) {
      return const CircularProgressIndicator();
    } else if (state is LoadedAllProductsState) {
      return ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text('\$${product.price}'),
          );
        },
      );
    } else if (state is ErrorState) {
      return Text('Error: ${state.message}');
    }
    return const Text('No products found');
  },
)
```

## Dependencies

- `flutter_bloc`: ^8.1.3 - For state management
- `equatable`: ^2.0.5 - For value equality
- `meta`: ^1.8.0 - For annotations
- `http`: ^1.2.1 - For making HTTP requests
- `internet_connection_checker`: ^1.0.0+1 - For checking internet connectivity
- `shared_preferences`: ^2.2.3 - For local storage

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run the app with `flutter run`

## Testing

To run tests:

```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
