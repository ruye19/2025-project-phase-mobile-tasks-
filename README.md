## ✅ Task 11: Contracts & Repository
- Implemented repository contract in `domain/repositories/product_repository.dart`.
- Created interfaces for:
  - Remote Data Source (`data/datasources/remote_data_source.dart`)
  - Local Data Source (`data/datasources/local_data_source.dart`)
- Implemented `ProductRepositoryImpl` in `data/repositories/`.

### Data Flow
UI → Bloc → UseCase → **ProductRepository** → Remote/Local Data Sources → API/Cache
