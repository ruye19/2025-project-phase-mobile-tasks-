# ecommerce

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Remote Data Source Implementation

### Overview
The remote data source implementation provides a clean architecture approach to handling product data from a REST API. It implements the `ProductRemoteDataSource` interface and handles all CRUD operations for products.

### Key Features
- REST API integration using Dio package
- Comprehensive error handling with custom exceptions
- Type-safe JSON serialization/deserialization
- Unit tested implementation
- Clean architecture principles

### Implementation Details

#### Dependencies
- `dio`: ^5.4.0 - For making HTTP requests
- `mockito`: ^5.4.4 - For testing

#### API Endpoints
- `GET /products` - Fetch all products
- `GET /products/{id}` - Fetch product by ID
- `POST /products` - Create new product
- `PUT /products/{id}` - Update product
- `DELETE /products/{id}` - Delete product

#### Error Handling
The implementation handles two types of exceptions:
- `NetworkException`: When there's a network connectivity issue
- `ServerException`: When the server returns an error response

### Usage
To use the remote data source:
1. Initialize Dio instance with appropriate configuration
2. Create an instance of `ProductRemoteDataSourceImpl`
3. Use the methods to perform CRUD operations

Example:
```dart
final dio = Dio();
final remoteDataSource = ProductRemoteDataSourceImpl(dio: dio);

// Fetch all products
final products = await remoteDataSource.fetchProducts();

// Create a new product
await remoteDataSource.createProduct(product);

// Update a product
await remoteDataSource.updateProduct(product);

// Delete a product
await remoteDataSource.deleteProduct(productId);
```

### Testing
The implementation is fully unit tested using Mockito. Test coverage includes:
- Success cases for all CRUD operations
- Error handling for network issues
- Error handling for server responses
- Proper API endpoint verification

### API Base URL
The current base URL is set to: `https://g5-flutter-learning-path-be.onrender.com/`
This can be changed in the `ProductRemoteDataSourceImpl` class if needed.

### Error Handling Strategy
The implementation follows a robust error handling strategy:
1. Network errors are caught and converted to `NetworkException`
2. Server errors are caught and converted to `ServerException`
3. All errors are properly propagated to the upper layers

### Best Practices Used
- Dependency injection for Dio client
- Clean separation of concerns
- Comprehensive error handling
- Type safety with generics
- Proper null safety implementation
- Clean code architecture
