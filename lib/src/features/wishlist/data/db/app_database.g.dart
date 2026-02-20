// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WishlistTableTable extends WishlistTable
    with TableInfo<$WishlistTableTable, WishlistTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _countryCodeMeta =
      const VerificationMeta('countryCode');
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
      'country_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commonNameMeta =
      const VerificationMeta('commonName');
  @override
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
      'common_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _officialNameMeta =
      const VerificationMeta('officialName');
  @override
  late final GeneratedColumn<String> officialName = GeneratedColumn<String>(
      'official_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _flagEmojiMeta =
      const VerificationMeta('flagEmoji');
  @override
  late final GeneratedColumn<String> flagEmoji = GeneratedColumn<String>(
      'flag_emoji', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _flagPngMeta =
      const VerificationMeta('flagPng');
  @override
  late final GeneratedColumn<String> flagPng = GeneratedColumn<String>(
      'flag_png', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _capitalsJsonMeta =
      const VerificationMeta('capitalsJson');
  @override
  late final GeneratedColumn<String> capitalsJson = GeneratedColumn<String>(
      'capitals_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _populationMeta =
      const VerificationMeta('population');
  @override
  late final GeneratedColumn<int> population = GeneratedColumn<int>(
      'population', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subregionMeta =
      const VerificationMeta('subregion');
  @override
  late final GeneratedColumn<String> subregion = GeneratedColumn<String>(
      'subregion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        countryCode,
        commonName,
        officialName,
        flagEmoji,
        flagPng,
        capitalsJson,
        population,
        region,
        subregion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_table';
  @override
  VerificationContext validateIntegrity(Insertable<WishlistTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('country_code')) {
      context.handle(
          _countryCodeMeta,
          countryCode.isAcceptableOrUnknown(
              data['country_code']!, _countryCodeMeta));
    } else if (isInserting) {
      context.missing(_countryCodeMeta);
    }
    if (data.containsKey('common_name')) {
      context.handle(
          _commonNameMeta,
          commonName.isAcceptableOrUnknown(
              data['common_name']!, _commonNameMeta));
    } else if (isInserting) {
      context.missing(_commonNameMeta);
    }
    if (data.containsKey('official_name')) {
      context.handle(
          _officialNameMeta,
          officialName.isAcceptableOrUnknown(
              data['official_name']!, _officialNameMeta));
    } else if (isInserting) {
      context.missing(_officialNameMeta);
    }
    if (data.containsKey('flag_emoji')) {
      context.handle(_flagEmojiMeta,
          flagEmoji.isAcceptableOrUnknown(data['flag_emoji']!, _flagEmojiMeta));
    } else if (isInserting) {
      context.missing(_flagEmojiMeta);
    }
    if (data.containsKey('flag_png')) {
      context.handle(_flagPngMeta,
          flagPng.isAcceptableOrUnknown(data['flag_png']!, _flagPngMeta));
    } else if (isInserting) {
      context.missing(_flagPngMeta);
    }
    if (data.containsKey('capitals_json')) {
      context.handle(
          _capitalsJsonMeta,
          capitalsJson.isAcceptableOrUnknown(
              data['capitals_json']!, _capitalsJsonMeta));
    }
    if (data.containsKey('population')) {
      context.handle(
          _populationMeta,
          population.isAcceptableOrUnknown(
              data['population']!, _populationMeta));
    } else if (isInserting) {
      context.missing(_populationMeta);
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('subregion')) {
      context.handle(_subregionMeta,
          subregion.isAcceptableOrUnknown(data['subregion']!, _subregionMeta));
    } else if (isInserting) {
      context.missing(_subregionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {countryCode};
  @override
  WishlistTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistTableData(
      countryCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_code'])!,
      commonName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}common_name'])!,
      officialName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}official_name'])!,
      flagEmoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flag_emoji'])!,
      flagPng: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flag_png'])!,
      capitalsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}capitals_json']),
      population: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}population'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region'])!,
      subregion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subregion'])!,
    );
  }

  @override
  $WishlistTableTable createAlias(String alias) {
    return $WishlistTableTable(attachedDatabase, alias);
  }
}

class WishlistTableData extends DataClass
    implements Insertable<WishlistTableData> {
  final String countryCode;
  final String commonName;
  final String officialName;
  final String flagEmoji;
  final String flagPng;
  final String? capitalsJson;
  final int population;
  final String region;
  final String subregion;
  const WishlistTableData(
      {required this.countryCode,
      required this.commonName,
      required this.officialName,
      required this.flagEmoji,
      required this.flagPng,
      this.capitalsJson,
      required this.population,
      required this.region,
      required this.subregion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['country_code'] = Variable<String>(countryCode);
    map['common_name'] = Variable<String>(commonName);
    map['official_name'] = Variable<String>(officialName);
    map['flag_emoji'] = Variable<String>(flagEmoji);
    map['flag_png'] = Variable<String>(flagPng);
    if (!nullToAbsent || capitalsJson != null) {
      map['capitals_json'] = Variable<String>(capitalsJson);
    }
    map['population'] = Variable<int>(population);
    map['region'] = Variable<String>(region);
    map['subregion'] = Variable<String>(subregion);
    return map;
  }

  WishlistTableCompanion toCompanion(bool nullToAbsent) {
    return WishlistTableCompanion(
      countryCode: Value(countryCode),
      commonName: Value(commonName),
      officialName: Value(officialName),
      flagEmoji: Value(flagEmoji),
      flagPng: Value(flagPng),
      capitalsJson: capitalsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(capitalsJson),
      population: Value(population),
      region: Value(region),
      subregion: Value(subregion),
    );
  }

  factory WishlistTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistTableData(
      countryCode: serializer.fromJson<String>(json['countryCode']),
      commonName: serializer.fromJson<String>(json['commonName']),
      officialName: serializer.fromJson<String>(json['officialName']),
      flagEmoji: serializer.fromJson<String>(json['flagEmoji']),
      flagPng: serializer.fromJson<String>(json['flagPng']),
      capitalsJson: serializer.fromJson<String?>(json['capitalsJson']),
      population: serializer.fromJson<int>(json['population']),
      region: serializer.fromJson<String>(json['region']),
      subregion: serializer.fromJson<String>(json['subregion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'countryCode': serializer.toJson<String>(countryCode),
      'commonName': serializer.toJson<String>(commonName),
      'officialName': serializer.toJson<String>(officialName),
      'flagEmoji': serializer.toJson<String>(flagEmoji),
      'flagPng': serializer.toJson<String>(flagPng),
      'capitalsJson': serializer.toJson<String?>(capitalsJson),
      'population': serializer.toJson<int>(population),
      'region': serializer.toJson<String>(region),
      'subregion': serializer.toJson<String>(subregion),
    };
  }

  WishlistTableData copyWith(
          {String? countryCode,
          String? commonName,
          String? officialName,
          String? flagEmoji,
          String? flagPng,
          Value<String?> capitalsJson = const Value.absent(),
          int? population,
          String? region,
          String? subregion}) =>
      WishlistTableData(
        countryCode: countryCode ?? this.countryCode,
        commonName: commonName ?? this.commonName,
        officialName: officialName ?? this.officialName,
        flagEmoji: flagEmoji ?? this.flagEmoji,
        flagPng: flagPng ?? this.flagPng,
        capitalsJson:
            capitalsJson.present ? capitalsJson.value : this.capitalsJson,
        population: population ?? this.population,
        region: region ?? this.region,
        subregion: subregion ?? this.subregion,
      );
  WishlistTableData copyWithCompanion(WishlistTableCompanion data) {
    return WishlistTableData(
      countryCode:
          data.countryCode.present ? data.countryCode.value : this.countryCode,
      commonName:
          data.commonName.present ? data.commonName.value : this.commonName,
      officialName: data.officialName.present
          ? data.officialName.value
          : this.officialName,
      flagEmoji: data.flagEmoji.present ? data.flagEmoji.value : this.flagEmoji,
      flagPng: data.flagPng.present ? data.flagPng.value : this.flagPng,
      capitalsJson: data.capitalsJson.present
          ? data.capitalsJson.value
          : this.capitalsJson,
      population:
          data.population.present ? data.population.value : this.population,
      region: data.region.present ? data.region.value : this.region,
      subregion: data.subregion.present ? data.subregion.value : this.subregion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistTableData(')
          ..write('countryCode: $countryCode, ')
          ..write('commonName: $commonName, ')
          ..write('officialName: $officialName, ')
          ..write('flagEmoji: $flagEmoji, ')
          ..write('flagPng: $flagPng, ')
          ..write('capitalsJson: $capitalsJson, ')
          ..write('population: $population, ')
          ..write('region: $region, ')
          ..write('subregion: $subregion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(countryCode, commonName, officialName,
      flagEmoji, flagPng, capitalsJson, population, region, subregion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistTableData &&
          other.countryCode == this.countryCode &&
          other.commonName == this.commonName &&
          other.officialName == this.officialName &&
          other.flagEmoji == this.flagEmoji &&
          other.flagPng == this.flagPng &&
          other.capitalsJson == this.capitalsJson &&
          other.population == this.population &&
          other.region == this.region &&
          other.subregion == this.subregion);
}

class WishlistTableCompanion extends UpdateCompanion<WishlistTableData> {
  final Value<String> countryCode;
  final Value<String> commonName;
  final Value<String> officialName;
  final Value<String> flagEmoji;
  final Value<String> flagPng;
  final Value<String?> capitalsJson;
  final Value<int> population;
  final Value<String> region;
  final Value<String> subregion;
  final Value<int> rowid;
  const WishlistTableCompanion({
    this.countryCode = const Value.absent(),
    this.commonName = const Value.absent(),
    this.officialName = const Value.absent(),
    this.flagEmoji = const Value.absent(),
    this.flagPng = const Value.absent(),
    this.capitalsJson = const Value.absent(),
    this.population = const Value.absent(),
    this.region = const Value.absent(),
    this.subregion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishlistTableCompanion.insert({
    required String countryCode,
    required String commonName,
    required String officialName,
    required String flagEmoji,
    required String flagPng,
    this.capitalsJson = const Value.absent(),
    required int population,
    required String region,
    required String subregion,
    this.rowid = const Value.absent(),
  })  : countryCode = Value(countryCode),
        commonName = Value(commonName),
        officialName = Value(officialName),
        flagEmoji = Value(flagEmoji),
        flagPng = Value(flagPng),
        population = Value(population),
        region = Value(region),
        subregion = Value(subregion);
  static Insertable<WishlistTableData> custom({
    Expression<String>? countryCode,
    Expression<String>? commonName,
    Expression<String>? officialName,
    Expression<String>? flagEmoji,
    Expression<String>? flagPng,
    Expression<String>? capitalsJson,
    Expression<int>? population,
    Expression<String>? region,
    Expression<String>? subregion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (countryCode != null) 'country_code': countryCode,
      if (commonName != null) 'common_name': commonName,
      if (officialName != null) 'official_name': officialName,
      if (flagEmoji != null) 'flag_emoji': flagEmoji,
      if (flagPng != null) 'flag_png': flagPng,
      if (capitalsJson != null) 'capitals_json': capitalsJson,
      if (population != null) 'population': population,
      if (region != null) 'region': region,
      if (subregion != null) 'subregion': subregion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishlistTableCompanion copyWith(
      {Value<String>? countryCode,
      Value<String>? commonName,
      Value<String>? officialName,
      Value<String>? flagEmoji,
      Value<String>? flagPng,
      Value<String?>? capitalsJson,
      Value<int>? population,
      Value<String>? region,
      Value<String>? subregion,
      Value<int>? rowid}) {
    return WishlistTableCompanion(
      countryCode: countryCode ?? this.countryCode,
      commonName: commonName ?? this.commonName,
      officialName: officialName ?? this.officialName,
      flagEmoji: flagEmoji ?? this.flagEmoji,
      flagPng: flagPng ?? this.flagPng,
      capitalsJson: capitalsJson ?? this.capitalsJson,
      population: population ?? this.population,
      region: region ?? this.region,
      subregion: subregion ?? this.subregion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (commonName.present) {
      map['common_name'] = Variable<String>(commonName.value);
    }
    if (officialName.present) {
      map['official_name'] = Variable<String>(officialName.value);
    }
    if (flagEmoji.present) {
      map['flag_emoji'] = Variable<String>(flagEmoji.value);
    }
    if (flagPng.present) {
      map['flag_png'] = Variable<String>(flagPng.value);
    }
    if (capitalsJson.present) {
      map['capitals_json'] = Variable<String>(capitalsJson.value);
    }
    if (population.present) {
      map['population'] = Variable<int>(population.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (subregion.present) {
      map['subregion'] = Variable<String>(subregion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistTableCompanion(')
          ..write('countryCode: $countryCode, ')
          ..write('commonName: $commonName, ')
          ..write('officialName: $officialName, ')
          ..write('flagEmoji: $flagEmoji, ')
          ..write('flagPng: $flagPng, ')
          ..write('capitalsJson: $capitalsJson, ')
          ..write('population: $population, ')
          ..write('region: $region, ')
          ..write('subregion: $subregion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WishlistTableTable wishlistTable = $WishlistTableTable(this);
  late final WishlistDao wishlistDao = WishlistDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [wishlistTable];
}

typedef $$WishlistTableTableCreateCompanionBuilder = WishlistTableCompanion
    Function({
  required String countryCode,
  required String commonName,
  required String officialName,
  required String flagEmoji,
  required String flagPng,
  Value<String?> capitalsJson,
  required int population,
  required String region,
  required String subregion,
  Value<int> rowid,
});
typedef $$WishlistTableTableUpdateCompanionBuilder = WishlistTableCompanion
    Function({
  Value<String> countryCode,
  Value<String> commonName,
  Value<String> officialName,
  Value<String> flagEmoji,
  Value<String> flagPng,
  Value<String?> capitalsJson,
  Value<int> population,
  Value<String> region,
  Value<String> subregion,
  Value<int> rowid,
});

class $$WishlistTableTableFilterComposer
    extends Composer<_$AppDatabase, $WishlistTableTable> {
  $$WishlistTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commonName => $composableBuilder(
      column: $table.commonName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get officialName => $composableBuilder(
      column: $table.officialName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get flagEmoji => $composableBuilder(
      column: $table.flagEmoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get flagPng => $composableBuilder(
      column: $table.flagPng, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get capitalsJson => $composableBuilder(
      column: $table.capitalsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get population => $composableBuilder(
      column: $table.population, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subregion => $composableBuilder(
      column: $table.subregion, builder: (column) => ColumnFilters(column));
}

class $$WishlistTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WishlistTableTable> {
  $$WishlistTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commonName => $composableBuilder(
      column: $table.commonName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get officialName => $composableBuilder(
      column: $table.officialName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get flagEmoji => $composableBuilder(
      column: $table.flagEmoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get flagPng => $composableBuilder(
      column: $table.flagPng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get capitalsJson => $composableBuilder(
      column: $table.capitalsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get population => $composableBuilder(
      column: $table.population, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subregion => $composableBuilder(
      column: $table.subregion, builder: (column) => ColumnOrderings(column));
}

class $$WishlistTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishlistTableTable> {
  $$WishlistTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => column);

  GeneratedColumn<String> get commonName => $composableBuilder(
      column: $table.commonName, builder: (column) => column);

  GeneratedColumn<String> get officialName => $composableBuilder(
      column: $table.officialName, builder: (column) => column);

  GeneratedColumn<String> get flagEmoji =>
      $composableBuilder(column: $table.flagEmoji, builder: (column) => column);

  GeneratedColumn<String> get flagPng =>
      $composableBuilder(column: $table.flagPng, builder: (column) => column);

  GeneratedColumn<String> get capitalsJson => $composableBuilder(
      column: $table.capitalsJson, builder: (column) => column);

  GeneratedColumn<int> get population => $composableBuilder(
      column: $table.population, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get subregion =>
      $composableBuilder(column: $table.subregion, builder: (column) => column);
}

class $$WishlistTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WishlistTableTable,
    WishlistTableData,
    $$WishlistTableTableFilterComposer,
    $$WishlistTableTableOrderingComposer,
    $$WishlistTableTableAnnotationComposer,
    $$WishlistTableTableCreateCompanionBuilder,
    $$WishlistTableTableUpdateCompanionBuilder,
    (
      WishlistTableData,
      BaseReferences<_$AppDatabase, $WishlistTableTable, WishlistTableData>
    ),
    WishlistTableData,
    PrefetchHooks Function()> {
  $$WishlistTableTableTableManager(_$AppDatabase db, $WishlistTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> countryCode = const Value.absent(),
            Value<String> commonName = const Value.absent(),
            Value<String> officialName = const Value.absent(),
            Value<String> flagEmoji = const Value.absent(),
            Value<String> flagPng = const Value.absent(),
            Value<String?> capitalsJson = const Value.absent(),
            Value<int> population = const Value.absent(),
            Value<String> region = const Value.absent(),
            Value<String> subregion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistTableCompanion(
            countryCode: countryCode,
            commonName: commonName,
            officialName: officialName,
            flagEmoji: flagEmoji,
            flagPng: flagPng,
            capitalsJson: capitalsJson,
            population: population,
            region: region,
            subregion: subregion,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String countryCode,
            required String commonName,
            required String officialName,
            required String flagEmoji,
            required String flagPng,
            Value<String?> capitalsJson = const Value.absent(),
            required int population,
            required String region,
            required String subregion,
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistTableCompanion.insert(
            countryCode: countryCode,
            commonName: commonName,
            officialName: officialName,
            flagEmoji: flagEmoji,
            flagPng: flagPng,
            capitalsJson: capitalsJson,
            population: population,
            region: region,
            subregion: subregion,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WishlistTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WishlistTableTable,
    WishlistTableData,
    $$WishlistTableTableFilterComposer,
    $$WishlistTableTableOrderingComposer,
    $$WishlistTableTableAnnotationComposer,
    $$WishlistTableTableCreateCompanionBuilder,
    $$WishlistTableTableUpdateCompanionBuilder,
    (
      WishlistTableData,
      BaseReferences<_$AppDatabase, $WishlistTableTable, WishlistTableData>
    ),
    WishlistTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WishlistTableTableTableManager get wishlistTable =>
      $$WishlistTableTableTableManager(_db, _db.wishlistTable);
}
