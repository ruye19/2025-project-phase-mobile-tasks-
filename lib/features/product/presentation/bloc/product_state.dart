import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class InitialState extends ProductState {}

class LoadingState extends ProductState {}

class LoadedAllProductsState extends ProductState {
  final List<Product> products;
  
  const LoadedAllProductsState({required this.products});
  
  @override
  List<Object> get props => [products];
}

class ErrorState extends ProductState {
  final String message;
  
  const ErrorState({required this.message});
  
  @override
  List<Object> get props => [message];
}

class ProductOperationSuccess extends ProductState {
  final String message;
  
  const ProductOperationSuccess({required this.message});
  
  @override
  List<Object> get props => [message];
}
