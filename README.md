# 🛍️ Task 20: Consume Bloc for eCommerce

This task focuses on integrating and consuming the BLoC pattern within a Flutter eCommerce app using Clean Architecture principles. The goal is to demonstrate UI interaction with Bloc for managing product-related functionalities: **Create**, **Retrieve**, **View Details**, **Edit**, and **Delete**.

---

## 🎯 Product Objectives

- ✅ Connect UI components with Bloc for state management.
- ✅ Apply **Clean Architecture** principles (Presentation, Domain, Data layers).
- ✅ Build modular, testable, and maintainable code.
- ✅ Implement product-related UI screens with Bloc logic.

---

## 📦 Features to Implement

### 1. 📝 Create Product Page
- UI form for entering product details.
- Consume Bloc to create a new product.
- Show success or error messages.

### 2. 📋 Retrieve All Products Page
- UI to display a list of products.
- Consume Bloc to fetch all products.
- List view with dynamic product data.

### 3. 🔍 Product Detail Page
- UI to show:
  - Product title
  - Description
  - Due date
  - Status
- Consume Bloc to fetch product details.

### 4. ✏️ Edit Product Page
- UI for editing an existing product.
- Consume Bloc to update product data.
- Display success/failure messages.

### 5. 🗑️ Delete Product
- Consume Bloc to delete a product.
- Show confirmation and status messages.

---

## 🔀 Navigation and Routing

- Navigate between:
  - Create Product
  - All Products
  - Product Detail
  - Edit Product
- Handle back navigation properly.
- Use clean and intuitive routing setup.

---

## 🧪 Testing

- Unit test each UI component’s interaction with Bloc.
- Test UI response to Bloc states:
  - Loading
  - Success
  - Failure
- Verify correct state management and UI updates.

---

## 🧹 Code Cleanup and Structure

- Follow Clean Architecture principles:
  - `presentation/` → UI & Bloc
  - `domain/` → Use cases & entities
  - `data/` → Repositories & data sources
- Ensure clean folder structure and best practices.

---

## ✅ Deliverables

- A Flutter app that:
  - Creates, retrieves, updates, and deletes products via Bloc.
  - Navigates between product pages.
  - Uses Clean Architecture and TDD practices.
- Well-documented and maintainable code.
- Short write-up of challenges and solutions.

---

## 🧠 Key Learning Objectives

- Master state management using Bloc in UI.
- Deepen your understanding of Clean Architecture.
- Improve test-driven UI development.



## 💡 Notes

- Make sure to separate logic from UI.
- Prefer `flutter_bloc` package.
- Use `BlocBuilder`, `BlocListener`, `BlocConsumer` wisely.
- Keep your code DRY and modular.



This task will strengthen your ability to build scalable Flutter apps using the Bloc pattern and Clean Architecture. Enjoy building and keep learning!
