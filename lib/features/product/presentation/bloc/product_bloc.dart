import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
// import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/update_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final CreateProduct createProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.updateProduct,
    required this.deleteProduct,
    required this.createProduct,
  }) : super(InitialState()) {
    on<LoadAllProductsEvent>(_onLoadAllProducts);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<CreateProductEvent>(_onCreateProduct);
  }

  Future<void> _onLoadAllProducts(
    LoadAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      final result = await getAllProducts(NoParams());
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (products) => emit(LoadedAllProductsState(products: products)),
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      // Create a Product object with the updated data
      final updatedProduct = Product(
        id: event.productId.toString(),
        name: event.updatedData['name'] as String,
        description: event.updatedData['description'] as String,
        price: (event.updatedData['price'] as num).toDouble(),
        imageUrl: event.updatedData['imageUrl'] as String,
      );
      
      final result = await updateProduct(UpdateProductParams(updatedProduct, id: event.productId));
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (_) {
          emit(const ProductOperationSuccess(message: 'Product updated successfully'));
          add(const LoadAllProductsEvent());
        },
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      final result = await deleteProduct(DeleteProductParams(event.productId.toString()));
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (_) {
          emit(const ProductOperationSuccess(message: 'Product deleted successfully'));
          add(LoadAllProductsEvent());
        },
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      final result = await createProduct(CreateProductParams(event.productData as Product));
      result.fold(
        (failure) => emit(ErrorState(message: failure.toString())),
        (_) {
          emit(const ProductOperationSuccess(message: 'Product created successfully'));
          add(const LoadAllProductsEvent());
        },
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
