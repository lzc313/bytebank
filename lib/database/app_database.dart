import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase(String _tableSql) async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(_tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );

  // return getDatabasesPath().then((dbPath) {
  //   final String path = join(dbPath, 'bytebank.db');
  //   return openDatabase(path, onCreate: (db, version) {
  //     db.execute('CREATE TABLE contacts('
  //         'id INTEGER PRIMARY KEY, '
  //         'name TEXT, '
  //         'account_number INTEGER)');
  //   }, version: 1,
  //   // onDowngrade: onDatabaseDowngradeDelete,
  //   );
  // });
}