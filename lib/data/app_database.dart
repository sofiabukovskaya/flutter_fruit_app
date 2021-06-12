class AppDatabase {
  final AppDatabase _singleton = AppDatabase._();
   AppDatabase get instance => _singleton;
  AppDatabase._();
}
