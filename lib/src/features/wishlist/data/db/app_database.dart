import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'wishlist_dao.dart';

part 'app_database.g.dart';

class WishlistTable extends Table {
  TextColumn get countryCode => text()();

  TextColumn get commonName => text()();

  TextColumn get officialName => text()();

  TextColumn get flagEmoji => text()();

  TextColumn get flagPng => text()();

  TextColumn get capitalsJson => text().nullable()();

  IntColumn get population => integer()();

  TextColumn get region => text()();

  TextColumn get subregion => text()();

  @override
  Set<Column<Object>> get primaryKey => {countryCode};
}

@DriftDatabase(
  tables: [WishlistTable],
  daos: [WishlistDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'wishlist.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
