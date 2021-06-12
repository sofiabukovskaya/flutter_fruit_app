import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  final AppDatabase _singleton = AppDatabase._();
   AppDatabase get instance => _singleton;
   Completer<Database>? _dbOpenCompleter;
  AppDatabase._();

  Future<Database> get database async{
    if(_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
     await  _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = 'demo.db';
    final database = await databaseFactoryIo.openDatabase(appDocumentDir);
    _dbOpenCompleter!.complete(database);
  }
}
