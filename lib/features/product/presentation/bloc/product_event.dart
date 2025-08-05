import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductsEvent extends ProductEvent {
  const LoadAllProductsEvent();
}

class UpdateProductEvent extends ProductEvent {
  final int productId;
  final Map<String, dynamic> updatedData;
  
  const UpdateProductEvent({
    required this.productId,
    required this.updatedData,
  });
  
  @override
  List<Object> get props => [productId, updatedData];
}

class DeleteProductEvent extends ProductEvent {
  final int productId;
  
  const DeleteProductEvent({required this.productId});
  
  @override
  List<Object> get props => [productId];
}

class CreateProductEvent extends ProductEvent {
  final Map<String, dynamic> productData;
  
  const CreateProductEvent({required this.productData});
  
  @override
  List<Object> get props => [productData];
}
