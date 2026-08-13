// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TreesTableTable extends TreesTable
    with TableInfo<$TreesTableTable, TreesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mainPhotoUrlMeta = const VerificationMeta(
    'mainPhotoUrl',
  );
  @override
  late final GeneratedColumn<String> mainPhotoUrl = GeneratedColumn<String>(
    'main_photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastInspectionDateMeta =
      const VerificationMeta('lastInspectionDate');
  @override
  late final GeneratedColumn<DateTime> lastInspectionDate =
      GeneratedColumn<DateTime>(
        'last_inspection_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _recommendationMeta = const VerificationMeta(
    'recommendation',
  );
  @override
  late final GeneratedColumn<String> recommendation = GeneratedColumn<String>(
    'recommendation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteId,
    latitude,
    longitude,
    category,
    condition,
    status,
    mainPhotoUrl,
    lastInspectionDate,
    recommendation,
    priority,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trees_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TreesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    } else if (isInserting) {
      context.missing(_conditionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('main_photo_url')) {
      context.handle(
        _mainPhotoUrlMeta,
        mainPhotoUrl.isAcceptableOrUnknown(
          data['main_photo_url']!,
          _mainPhotoUrlMeta,
        ),
      );
    }
    if (data.containsKey('last_inspection_date')) {
      context.handle(
        _lastInspectionDateMeta,
        lastInspectionDate.isAcceptableOrUnknown(
          data['last_inspection_date']!,
          _lastInspectionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastInspectionDateMeta);
    }
    if (data.containsKey('recommendation')) {
      context.handle(
        _recommendationMeta,
        recommendation.isAcceptableOrUnknown(
          data['recommendation']!,
          _recommendationMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  TreesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreesTableData(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      mainPhotoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_photo_url'],
      ),
      lastInspectionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_inspection_date'],
      )!,
      recommendation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TreesTableTable createAlias(String alias) {
    return $TreesTableTable(attachedDatabase, alias);
  }
}

class TreesTableData extends DataClass implements Insertable<TreesTableData> {
  final String localId;
  final String? remoteId;
  final double latitude;
  final double longitude;
  final String category;
  final String condition;
  final String status;
  final String? mainPhotoUrl;
  final DateTime lastInspectionDate;
  final String? recommendation;
  final String priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TreesTableData({
    required this.localId,
    this.remoteId,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.condition,
    required this.status,
    this.mainPhotoUrl,
    required this.lastInspectionDate,
    this.recommendation,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<String>(localId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['category'] = Variable<String>(category);
    map['condition'] = Variable<String>(condition);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || mainPhotoUrl != null) {
      map['main_photo_url'] = Variable<String>(mainPhotoUrl);
    }
    map['last_inspection_date'] = Variable<DateTime>(lastInspectionDate);
    if (!nullToAbsent || recommendation != null) {
      map['recommendation'] = Variable<String>(recommendation);
    }
    map['priority'] = Variable<String>(priority);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TreesTableCompanion toCompanion(bool nullToAbsent) {
    return TreesTableCompanion(
      localId: Value(localId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      latitude: Value(latitude),
      longitude: Value(longitude),
      category: Value(category),
      condition: Value(condition),
      status: Value(status),
      mainPhotoUrl: mainPhotoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(mainPhotoUrl),
      lastInspectionDate: Value(lastInspectionDate),
      recommendation: recommendation == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendation),
      priority: Value(priority),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TreesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreesTableData(
      localId: serializer.fromJson<String>(json['localId']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      category: serializer.fromJson<String>(json['category']),
      condition: serializer.fromJson<String>(json['condition']),
      status: serializer.fromJson<String>(json['status']),
      mainPhotoUrl: serializer.fromJson<String?>(json['mainPhotoUrl']),
      lastInspectionDate: serializer.fromJson<DateTime>(
        json['lastInspectionDate'],
      ),
      recommendation: serializer.fromJson<String?>(json['recommendation']),
      priority: serializer.fromJson<String>(json['priority']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<String>(localId),
      'remoteId': serializer.toJson<String?>(remoteId),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'category': serializer.toJson<String>(category),
      'condition': serializer.toJson<String>(condition),
      'status': serializer.toJson<String>(status),
      'mainPhotoUrl': serializer.toJson<String?>(mainPhotoUrl),
      'lastInspectionDate': serializer.toJson<DateTime>(lastInspectionDate),
      'recommendation': serializer.toJson<String?>(recommendation),
      'priority': serializer.toJson<String>(priority),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TreesTableData copyWith({
    String? localId,
    Value<String?> remoteId = const Value.absent(),
    double? latitude,
    double? longitude,
    String? category,
    String? condition,
    String? status,
    Value<String?> mainPhotoUrl = const Value.absent(),
    DateTime? lastInspectionDate,
    Value<String?> recommendation = const Value.absent(),
    String? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TreesTableData(
    localId: localId ?? this.localId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    category: category ?? this.category,
    condition: condition ?? this.condition,
    status: status ?? this.status,
    mainPhotoUrl: mainPhotoUrl.present ? mainPhotoUrl.value : this.mainPhotoUrl,
    lastInspectionDate: lastInspectionDate ?? this.lastInspectionDate,
    recommendation: recommendation.present
        ? recommendation.value
        : this.recommendation,
    priority: priority ?? this.priority,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TreesTableData copyWithCompanion(TreesTableCompanion data) {
    return TreesTableData(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      category: data.category.present ? data.category.value : this.category,
      condition: data.condition.present ? data.condition.value : this.condition,
      status: data.status.present ? data.status.value : this.status,
      mainPhotoUrl: data.mainPhotoUrl.present
          ? data.mainPhotoUrl.value
          : this.mainPhotoUrl,
      lastInspectionDate: data.lastInspectionDate.present
          ? data.lastInspectionDate.value
          : this.lastInspectionDate,
      recommendation: data.recommendation.present
          ? data.recommendation.value
          : this.recommendation,
      priority: data.priority.present ? data.priority.value : this.priority,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreesTableData(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('category: $category, ')
          ..write('condition: $condition, ')
          ..write('status: $status, ')
          ..write('mainPhotoUrl: $mainPhotoUrl, ')
          ..write('lastInspectionDate: $lastInspectionDate, ')
          ..write('recommendation: $recommendation, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteId,
    latitude,
    longitude,
    category,
    condition,
    status,
    mainPhotoUrl,
    lastInspectionDate,
    recommendation,
    priority,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreesTableData &&
          other.localId == this.localId &&
          other.remoteId == this.remoteId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.category == this.category &&
          other.condition == this.condition &&
          other.status == this.status &&
          other.mainPhotoUrl == this.mainPhotoUrl &&
          other.lastInspectionDate == this.lastInspectionDate &&
          other.recommendation == this.recommendation &&
          other.priority == this.priority &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TreesTableCompanion extends UpdateCompanion<TreesTableData> {
  final Value<String> localId;
  final Value<String?> remoteId;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> category;
  final Value<String> condition;
  final Value<String> status;
  final Value<String?> mainPhotoUrl;
  final Value<DateTime> lastInspectionDate;
  final Value<String?> recommendation;
  final Value<String> priority;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TreesTableCompanion({
    this.localId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.category = const Value.absent(),
    this.condition = const Value.absent(),
    this.status = const Value.absent(),
    this.mainPhotoUrl = const Value.absent(),
    this.lastInspectionDate = const Value.absent(),
    this.recommendation = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreesTableCompanion.insert({
    required String localId,
    this.remoteId = const Value.absent(),
    required double latitude,
    required double longitude,
    required String category,
    required String condition,
    required String status,
    this.mainPhotoUrl = const Value.absent(),
    required DateTime lastInspectionDate,
    this.recommendation = const Value.absent(),
    required String priority,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : localId = Value(localId),
       latitude = Value(latitude),
       longitude = Value(longitude),
       category = Value(category),
       condition = Value(condition),
       status = Value(status),
       lastInspectionDate = Value(lastInspectionDate),
       priority = Value(priority),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TreesTableData> custom({
    Expression<String>? localId,
    Expression<String>? remoteId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? category,
    Expression<String>? condition,
    Expression<String>? status,
    Expression<String>? mainPhotoUrl,
    Expression<DateTime>? lastInspectionDate,
    Expression<String>? recommendation,
    Expression<String>? priority,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteId != null) 'remote_id': remoteId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (category != null) 'category': category,
      if (condition != null) 'condition': condition,
      if (status != null) 'status': status,
      if (mainPhotoUrl != null) 'main_photo_url': mainPhotoUrl,
      if (lastInspectionDate != null)
        'last_inspection_date': lastInspectionDate,
      if (recommendation != null) 'recommendation': recommendation,
      if (priority != null) 'priority': priority,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreesTableCompanion copyWith({
    Value<String>? localId,
    Value<String?>? remoteId,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? category,
    Value<String>? condition,
    Value<String>? status,
    Value<String?>? mainPhotoUrl,
    Value<DateTime>? lastInspectionDate,
    Value<String?>? recommendation,
    Value<String>? priority,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TreesTableCompanion(
      localId: localId ?? this.localId,
      remoteId: remoteId ?? this.remoteId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      status: status ?? this.status,
      mainPhotoUrl: mainPhotoUrl ?? this.mainPhotoUrl,
      lastInspectionDate: lastInspectionDate ?? this.lastInspectionDate,
      recommendation: recommendation ?? this.recommendation,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (mainPhotoUrl.present) {
      map['main_photo_url'] = Variable<String>(mainPhotoUrl.value);
    }
    if (lastInspectionDate.present) {
      map['last_inspection_date'] = Variable<DateTime>(
        lastInspectionDate.value,
      );
    }
    if (recommendation.present) {
      map['recommendation'] = Variable<String>(recommendation.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreesTableCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteId: $remoteId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('category: $category, ')
          ..write('condition: $condition, ')
          ..write('status: $status, ')
          ..write('mainPhotoUrl: $mainPhotoUrl, ')
          ..write('lastInspectionDate: $lastInspectionDate, ')
          ..write('recommendation: $recommendation, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkRequestsTableTable extends WorkRequestsTable
    with TableInfo<$WorkRequestsTableTable, WorkRequestsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkRequestsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treeLocalIdMeta = const VerificationMeta(
    'treeLocalId',
  );
  @override
  late final GeneratedColumn<String> treeLocalId = GeneratedColumn<String>(
    'tree_local_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localPhotoPathMeta = const VerificationMeta(
    'localPhotoPath',
  );
  @override
  late final GeneratedColumn<String> localPhotoPath = GeneratedColumn<String>(
    'local_photo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remotePhotoUrlMeta = const VerificationMeta(
    'remotePhotoUrl',
  );
  @override
  late final GeneratedColumn<String> remotePhotoUrl = GeneratedColumn<String>(
    'remote_photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userProblemsCsvMeta = const VerificationMeta(
    'userProblemsCsv',
  );
  @override
  late final GeneratedColumn<String> userProblemsCsv = GeneratedColumn<String>(
    'user_problems_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userCommentMeta = const VerificationMeta(
    'userComment',
  );
  @override
  late final GeneratedColumn<String> userComment = GeneratedColumn<String>(
    'user_comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aiConditionMeta = const VerificationMeta(
    'aiCondition',
  );
  @override
  late final GeneratedColumn<String> aiCondition = GeneratedColumn<String>(
    'ai_condition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiConfidenceMeta = const VerificationMeta(
    'aiConfidence',
  );
  @override
  late final GeneratedColumn<double> aiConfidence = GeneratedColumn<double>(
    'ai_confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByUserIdMeta = const VerificationMeta(
    'createdByUserId',
  );
  @override
  late final GeneratedColumn<String> createdByUserId = GeneratedColumn<String>(
    'created_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncAttemptsMeta = const VerificationMeta(
    'syncAttempts',
  );
  @override
  late final GeneratedColumn<int> syncAttempts = GeneratedColumn<int>(
    'sync_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    treeLocalId,
    localPhotoPath,
    remotePhotoUrl,
    latitude,
    longitude,
    userProblemsCsv,
    userComment,
    status,
    aiCondition,
    aiConfidence,
    createdByUserId,
    createdAt,
    updatedAt,
    syncAttempts,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_requests_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkRequestsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tree_local_id')) {
      context.handle(
        _treeLocalIdMeta,
        treeLocalId.isAcceptableOrUnknown(
          data['tree_local_id']!,
          _treeLocalIdMeta,
        ),
      );
    }
    if (data.containsKey('local_photo_path')) {
      context.handle(
        _localPhotoPathMeta,
        localPhotoPath.isAcceptableOrUnknown(
          data['local_photo_path']!,
          _localPhotoPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localPhotoPathMeta);
    }
    if (data.containsKey('remote_photo_url')) {
      context.handle(
        _remotePhotoUrlMeta,
        remotePhotoUrl.isAcceptableOrUnknown(
          data['remote_photo_url']!,
          _remotePhotoUrlMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('user_problems_csv')) {
      context.handle(
        _userProblemsCsvMeta,
        userProblemsCsv.isAcceptableOrUnknown(
          data['user_problems_csv']!,
          _userProblemsCsvMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userProblemsCsvMeta);
    }
    if (data.containsKey('user_comment')) {
      context.handle(
        _userCommentMeta,
        userComment.isAcceptableOrUnknown(
          data['user_comment']!,
          _userCommentMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('ai_condition')) {
      context.handle(
        _aiConditionMeta,
        aiCondition.isAcceptableOrUnknown(
          data['ai_condition']!,
          _aiConditionMeta,
        ),
      );
    }
    if (data.containsKey('ai_confidence')) {
      context.handle(
        _aiConfidenceMeta,
        aiConfidence.isAcceptableOrUnknown(
          data['ai_confidence']!,
          _aiConfidenceMeta,
        ),
      );
    }
    if (data.containsKey('created_by_user_id')) {
      context.handle(
        _createdByUserIdMeta,
        createdByUserId.isAcceptableOrUnknown(
          data['created_by_user_id']!,
          _createdByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdByUserIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_attempts')) {
      context.handle(
        _syncAttemptsMeta,
        syncAttempts.isAcceptableOrUnknown(
          data['sync_attempts']!,
          _syncAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkRequestsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkRequestsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      treeLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tree_local_id'],
      ),
      localPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_photo_path'],
      )!,
      remotePhotoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_photo_url'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      userProblemsCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_problems_csv'],
      )!,
      userComment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_comment'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      aiCondition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_condition'],
      ),
      aiConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ai_confidence'],
      ),
      createdByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by_user_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $WorkRequestsTableTable createAlias(String alias) {
    return $WorkRequestsTableTable(attachedDatabase, alias);
  }
}

class WorkRequestsTableData extends DataClass
    implements Insertable<WorkRequestsTableData> {
  final String id;
  final String? treeLocalId;
  final String localPhotoPath;
  final String? remotePhotoUrl;
  final double latitude;
  final double longitude;
  final String userProblemsCsv;
  final String? userComment;
  final String status;
  final String? aiCondition;
  final double? aiConfidence;
  final String createdByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncAttempts;
  final String? lastError;
  const WorkRequestsTableData({
    required this.id,
    this.treeLocalId,
    required this.localPhotoPath,
    this.remotePhotoUrl,
    required this.latitude,
    required this.longitude,
    required this.userProblemsCsv,
    this.userComment,
    required this.status,
    this.aiCondition,
    this.aiConfidence,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncAttempts,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || treeLocalId != null) {
      map['tree_local_id'] = Variable<String>(treeLocalId);
    }
    map['local_photo_path'] = Variable<String>(localPhotoPath);
    if (!nullToAbsent || remotePhotoUrl != null) {
      map['remote_photo_url'] = Variable<String>(remotePhotoUrl);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['user_problems_csv'] = Variable<String>(userProblemsCsv);
    if (!nullToAbsent || userComment != null) {
      map['user_comment'] = Variable<String>(userComment);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || aiCondition != null) {
      map['ai_condition'] = Variable<String>(aiCondition);
    }
    if (!nullToAbsent || aiConfidence != null) {
      map['ai_confidence'] = Variable<double>(aiConfidence);
    }
    map['created_by_user_id'] = Variable<String>(createdByUserId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_attempts'] = Variable<int>(syncAttempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  WorkRequestsTableCompanion toCompanion(bool nullToAbsent) {
    return WorkRequestsTableCompanion(
      id: Value(id),
      treeLocalId: treeLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(treeLocalId),
      localPhotoPath: Value(localPhotoPath),
      remotePhotoUrl: remotePhotoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remotePhotoUrl),
      latitude: Value(latitude),
      longitude: Value(longitude),
      userProblemsCsv: Value(userProblemsCsv),
      userComment: userComment == null && nullToAbsent
          ? const Value.absent()
          : Value(userComment),
      status: Value(status),
      aiCondition: aiCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(aiCondition),
      aiConfidence: aiConfidence == null && nullToAbsent
          ? const Value.absent()
          : Value(aiConfidence),
      createdByUserId: Value(createdByUserId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncAttempts: Value(syncAttempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory WorkRequestsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkRequestsTableData(
      id: serializer.fromJson<String>(json['id']),
      treeLocalId: serializer.fromJson<String?>(json['treeLocalId']),
      localPhotoPath: serializer.fromJson<String>(json['localPhotoPath']),
      remotePhotoUrl: serializer.fromJson<String?>(json['remotePhotoUrl']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      userProblemsCsv: serializer.fromJson<String>(json['userProblemsCsv']),
      userComment: serializer.fromJson<String?>(json['userComment']),
      status: serializer.fromJson<String>(json['status']),
      aiCondition: serializer.fromJson<String?>(json['aiCondition']),
      aiConfidence: serializer.fromJson<double?>(json['aiConfidence']),
      createdByUserId: serializer.fromJson<String>(json['createdByUserId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncAttempts: serializer.fromJson<int>(json['syncAttempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treeLocalId': serializer.toJson<String?>(treeLocalId),
      'localPhotoPath': serializer.toJson<String>(localPhotoPath),
      'remotePhotoUrl': serializer.toJson<String?>(remotePhotoUrl),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'userProblemsCsv': serializer.toJson<String>(userProblemsCsv),
      'userComment': serializer.toJson<String?>(userComment),
      'status': serializer.toJson<String>(status),
      'aiCondition': serializer.toJson<String?>(aiCondition),
      'aiConfidence': serializer.toJson<double?>(aiConfidence),
      'createdByUserId': serializer.toJson<String>(createdByUserId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncAttempts': serializer.toJson<int>(syncAttempts),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  WorkRequestsTableData copyWith({
    String? id,
    Value<String?> treeLocalId = const Value.absent(),
    String? localPhotoPath,
    Value<String?> remotePhotoUrl = const Value.absent(),
    double? latitude,
    double? longitude,
    String? userProblemsCsv,
    Value<String?> userComment = const Value.absent(),
    String? status,
    Value<String?> aiCondition = const Value.absent(),
    Value<double?> aiConfidence = const Value.absent(),
    String? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncAttempts,
    Value<String?> lastError = const Value.absent(),
  }) => WorkRequestsTableData(
    id: id ?? this.id,
    treeLocalId: treeLocalId.present ? treeLocalId.value : this.treeLocalId,
    localPhotoPath: localPhotoPath ?? this.localPhotoPath,
    remotePhotoUrl: remotePhotoUrl.present
        ? remotePhotoUrl.value
        : this.remotePhotoUrl,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    userProblemsCsv: userProblemsCsv ?? this.userProblemsCsv,
    userComment: userComment.present ? userComment.value : this.userComment,
    status: status ?? this.status,
    aiCondition: aiCondition.present ? aiCondition.value : this.aiCondition,
    aiConfidence: aiConfidence.present ? aiConfidence.value : this.aiConfidence,
    createdByUserId: createdByUserId ?? this.createdByUserId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncAttempts: syncAttempts ?? this.syncAttempts,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  WorkRequestsTableData copyWithCompanion(WorkRequestsTableCompanion data) {
    return WorkRequestsTableData(
      id: data.id.present ? data.id.value : this.id,
      treeLocalId: data.treeLocalId.present
          ? data.treeLocalId.value
          : this.treeLocalId,
      localPhotoPath: data.localPhotoPath.present
          ? data.localPhotoPath.value
          : this.localPhotoPath,
      remotePhotoUrl: data.remotePhotoUrl.present
          ? data.remotePhotoUrl.value
          : this.remotePhotoUrl,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      userProblemsCsv: data.userProblemsCsv.present
          ? data.userProblemsCsv.value
          : this.userProblemsCsv,
      userComment: data.userComment.present
          ? data.userComment.value
          : this.userComment,
      status: data.status.present ? data.status.value : this.status,
      aiCondition: data.aiCondition.present
          ? data.aiCondition.value
          : this.aiCondition,
      aiConfidence: data.aiConfidence.present
          ? data.aiConfidence.value
          : this.aiConfidence,
      createdByUserId: data.createdByUserId.present
          ? data.createdByUserId.value
          : this.createdByUserId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncAttempts: data.syncAttempts.present
          ? data.syncAttempts.value
          : this.syncAttempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkRequestsTableData(')
          ..write('id: $id, ')
          ..write('treeLocalId: $treeLocalId, ')
          ..write('localPhotoPath: $localPhotoPath, ')
          ..write('remotePhotoUrl: $remotePhotoUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('userProblemsCsv: $userProblemsCsv, ')
          ..write('userComment: $userComment, ')
          ..write('status: $status, ')
          ..write('aiCondition: $aiCondition, ')
          ..write('aiConfidence: $aiConfidence, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncAttempts: $syncAttempts, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    treeLocalId,
    localPhotoPath,
    remotePhotoUrl,
    latitude,
    longitude,
    userProblemsCsv,
    userComment,
    status,
    aiCondition,
    aiConfidence,
    createdByUserId,
    createdAt,
    updatedAt,
    syncAttempts,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkRequestsTableData &&
          other.id == this.id &&
          other.treeLocalId == this.treeLocalId &&
          other.localPhotoPath == this.localPhotoPath &&
          other.remotePhotoUrl == this.remotePhotoUrl &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.userProblemsCsv == this.userProblemsCsv &&
          other.userComment == this.userComment &&
          other.status == this.status &&
          other.aiCondition == this.aiCondition &&
          other.aiConfidence == this.aiConfidence &&
          other.createdByUserId == this.createdByUserId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncAttempts == this.syncAttempts &&
          other.lastError == this.lastError);
}

class WorkRequestsTableCompanion
    extends UpdateCompanion<WorkRequestsTableData> {
  final Value<String> id;
  final Value<String?> treeLocalId;
  final Value<String> localPhotoPath;
  final Value<String?> remotePhotoUrl;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> userProblemsCsv;
  final Value<String?> userComment;
  final Value<String> status;
  final Value<String?> aiCondition;
  final Value<double?> aiConfidence;
  final Value<String> createdByUserId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncAttempts;
  final Value<String?> lastError;
  final Value<int> rowid;
  const WorkRequestsTableCompanion({
    this.id = const Value.absent(),
    this.treeLocalId = const Value.absent(),
    this.localPhotoPath = const Value.absent(),
    this.remotePhotoUrl = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.userProblemsCsv = const Value.absent(),
    this.userComment = const Value.absent(),
    this.status = const Value.absent(),
    this.aiCondition = const Value.absent(),
    this.aiConfidence = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncAttempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkRequestsTableCompanion.insert({
    required String id,
    this.treeLocalId = const Value.absent(),
    required String localPhotoPath,
    this.remotePhotoUrl = const Value.absent(),
    required double latitude,
    required double longitude,
    required String userProblemsCsv,
    this.userComment = const Value.absent(),
    required String status,
    this.aiCondition = const Value.absent(),
    this.aiConfidence = const Value.absent(),
    required String createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncAttempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localPhotoPath = Value(localPhotoPath),
       latitude = Value(latitude),
       longitude = Value(longitude),
       userProblemsCsv = Value(userProblemsCsv),
       status = Value(status),
       createdByUserId = Value(createdByUserId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkRequestsTableData> custom({
    Expression<String>? id,
    Expression<String>? treeLocalId,
    Expression<String>? localPhotoPath,
    Expression<String>? remotePhotoUrl,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? userProblemsCsv,
    Expression<String>? userComment,
    Expression<String>? status,
    Expression<String>? aiCondition,
    Expression<double>? aiConfidence,
    Expression<String>? createdByUserId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncAttempts,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeLocalId != null) 'tree_local_id': treeLocalId,
      if (localPhotoPath != null) 'local_photo_path': localPhotoPath,
      if (remotePhotoUrl != null) 'remote_photo_url': remotePhotoUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (userProblemsCsv != null) 'user_problems_csv': userProblemsCsv,
      if (userComment != null) 'user_comment': userComment,
      if (status != null) 'status': status,
      if (aiCondition != null) 'ai_condition': aiCondition,
      if (aiConfidence != null) 'ai_confidence': aiConfidence,
      if (createdByUserId != null) 'created_by_user_id': createdByUserId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncAttempts != null) 'sync_attempts': syncAttempts,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkRequestsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? treeLocalId,
    Value<String>? localPhotoPath,
    Value<String?>? remotePhotoUrl,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? userProblemsCsv,
    Value<String?>? userComment,
    Value<String>? status,
    Value<String?>? aiCondition,
    Value<double?>? aiConfidence,
    Value<String>? createdByUserId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncAttempts,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return WorkRequestsTableCompanion(
      id: id ?? this.id,
      treeLocalId: treeLocalId ?? this.treeLocalId,
      localPhotoPath: localPhotoPath ?? this.localPhotoPath,
      remotePhotoUrl: remotePhotoUrl ?? this.remotePhotoUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userProblemsCsv: userProblemsCsv ?? this.userProblemsCsv,
      userComment: userComment ?? this.userComment,
      status: status ?? this.status,
      aiCondition: aiCondition ?? this.aiCondition,
      aiConfidence: aiConfidence ?? this.aiConfidence,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncAttempts: syncAttempts ?? this.syncAttempts,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treeLocalId.present) {
      map['tree_local_id'] = Variable<String>(treeLocalId.value);
    }
    if (localPhotoPath.present) {
      map['local_photo_path'] = Variable<String>(localPhotoPath.value);
    }
    if (remotePhotoUrl.present) {
      map['remote_photo_url'] = Variable<String>(remotePhotoUrl.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (userProblemsCsv.present) {
      map['user_problems_csv'] = Variable<String>(userProblemsCsv.value);
    }
    if (userComment.present) {
      map['user_comment'] = Variable<String>(userComment.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (aiCondition.present) {
      map['ai_condition'] = Variable<String>(aiCondition.value);
    }
    if (aiConfidence.present) {
      map['ai_confidence'] = Variable<double>(aiConfidence.value);
    }
    if (createdByUserId.present) {
      map['created_by_user_id'] = Variable<String>(createdByUserId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncAttempts.present) {
      map['sync_attempts'] = Variable<int>(syncAttempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkRequestsTableCompanion(')
          ..write('id: $id, ')
          ..write('treeLocalId: $treeLocalId, ')
          ..write('localPhotoPath: $localPhotoPath, ')
          ..write('remotePhotoUrl: $remotePhotoUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('userProblemsCsv: $userProblemsCsv, ')
          ..write('userComment: $userComment, ')
          ..write('status: $status, ')
          ..write('aiCondition: $aiCondition, ')
          ..write('aiConfidence: $aiConfidence, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncAttempts: $syncAttempts, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InspectionsTableTable extends InspectionsTable
    with TableInfo<$InspectionsTableTable, InspectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treeLocalIdMeta = const VerificationMeta(
    'treeLocalId',
  );
  @override
  late final GeneratedColumn<String> treeLocalId = GeneratedColumn<String>(
    'tree_local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aiConditionMeta = const VerificationMeta(
    'aiCondition',
  );
  @override
  late final GeneratedColumn<String> aiCondition = GeneratedColumn<String>(
    'ai_condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aiConfidenceMeta = const VerificationMeta(
    'aiConfidence',
  );
  @override
  late final GeneratedColumn<double> aiConfidence = GeneratedColumn<double>(
    'ai_confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inspectedAtMeta = const VerificationMeta(
    'inspectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> inspectedAt = GeneratedColumn<DateTime>(
    'inspected_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inspectorIdMeta = const VerificationMeta(
    'inspectorId',
  );
  @override
  late final GeneratedColumn<String> inspectorId = GeneratedColumn<String>(
    'inspector_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    treeLocalId,
    photoUrl,
    aiCondition,
    aiConfidence,
    inspectedAt,
    inspectorId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspections_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tree_local_id')) {
      context.handle(
        _treeLocalIdMeta,
        treeLocalId.isAcceptableOrUnknown(
          data['tree_local_id']!,
          _treeLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_treeLocalIdMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_photoUrlMeta);
    }
    if (data.containsKey('ai_condition')) {
      context.handle(
        _aiConditionMeta,
        aiCondition.isAcceptableOrUnknown(
          data['ai_condition']!,
          _aiConditionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aiConditionMeta);
    }
    if (data.containsKey('ai_confidence')) {
      context.handle(
        _aiConfidenceMeta,
        aiConfidence.isAcceptableOrUnknown(
          data['ai_confidence']!,
          _aiConfidenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aiConfidenceMeta);
    }
    if (data.containsKey('inspected_at')) {
      context.handle(
        _inspectedAtMeta,
        inspectedAt.isAcceptableOrUnknown(
          data['inspected_at']!,
          _inspectedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectedAtMeta);
    }
    if (data.containsKey('inspector_id')) {
      context.handle(
        _inspectorIdMeta,
        inspectorId.isAcceptableOrUnknown(
          data['inspector_id']!,
          _inspectorIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspectionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      treeLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tree_local_id'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      )!,
      aiCondition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_condition'],
      )!,
      aiConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ai_confidence'],
      )!,
      inspectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}inspected_at'],
      )!,
      inspectorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inspector_id'],
      ),
    );
  }

  @override
  $InspectionsTableTable createAlias(String alias) {
    return $InspectionsTableTable(attachedDatabase, alias);
  }
}

class InspectionsTableData extends DataClass
    implements Insertable<InspectionsTableData> {
  final String id;
  final String treeLocalId;
  final String photoUrl;
  final String aiCondition;
  final double aiConfidence;
  final DateTime inspectedAt;
  final String? inspectorId;
  const InspectionsTableData({
    required this.id,
    required this.treeLocalId,
    required this.photoUrl,
    required this.aiCondition,
    required this.aiConfidence,
    required this.inspectedAt,
    this.inspectorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tree_local_id'] = Variable<String>(treeLocalId);
    map['photo_url'] = Variable<String>(photoUrl);
    map['ai_condition'] = Variable<String>(aiCondition);
    map['ai_confidence'] = Variable<double>(aiConfidence);
    map['inspected_at'] = Variable<DateTime>(inspectedAt);
    if (!nullToAbsent || inspectorId != null) {
      map['inspector_id'] = Variable<String>(inspectorId);
    }
    return map;
  }

  InspectionsTableCompanion toCompanion(bool nullToAbsent) {
    return InspectionsTableCompanion(
      id: Value(id),
      treeLocalId: Value(treeLocalId),
      photoUrl: Value(photoUrl),
      aiCondition: Value(aiCondition),
      aiConfidence: Value(aiConfidence),
      inspectedAt: Value(inspectedAt),
      inspectorId: inspectorId == null && nullToAbsent
          ? const Value.absent()
          : Value(inspectorId),
    );
  }

  factory InspectionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionsTableData(
      id: serializer.fromJson<String>(json['id']),
      treeLocalId: serializer.fromJson<String>(json['treeLocalId']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
      aiCondition: serializer.fromJson<String>(json['aiCondition']),
      aiConfidence: serializer.fromJson<double>(json['aiConfidence']),
      inspectedAt: serializer.fromJson<DateTime>(json['inspectedAt']),
      inspectorId: serializer.fromJson<String?>(json['inspectorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treeLocalId': serializer.toJson<String>(treeLocalId),
      'photoUrl': serializer.toJson<String>(photoUrl),
      'aiCondition': serializer.toJson<String>(aiCondition),
      'aiConfidence': serializer.toJson<double>(aiConfidence),
      'inspectedAt': serializer.toJson<DateTime>(inspectedAt),
      'inspectorId': serializer.toJson<String?>(inspectorId),
    };
  }

  InspectionsTableData copyWith({
    String? id,
    String? treeLocalId,
    String? photoUrl,
    String? aiCondition,
    double? aiConfidence,
    DateTime? inspectedAt,
    Value<String?> inspectorId = const Value.absent(),
  }) => InspectionsTableData(
    id: id ?? this.id,
    treeLocalId: treeLocalId ?? this.treeLocalId,
    photoUrl: photoUrl ?? this.photoUrl,
    aiCondition: aiCondition ?? this.aiCondition,
    aiConfidence: aiConfidence ?? this.aiConfidence,
    inspectedAt: inspectedAt ?? this.inspectedAt,
    inspectorId: inspectorId.present ? inspectorId.value : this.inspectorId,
  );
  InspectionsTableData copyWithCompanion(InspectionsTableCompanion data) {
    return InspectionsTableData(
      id: data.id.present ? data.id.value : this.id,
      treeLocalId: data.treeLocalId.present
          ? data.treeLocalId.value
          : this.treeLocalId,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      aiCondition: data.aiCondition.present
          ? data.aiCondition.value
          : this.aiCondition,
      aiConfidence: data.aiConfidence.present
          ? data.aiConfidence.value
          : this.aiConfidence,
      inspectedAt: data.inspectedAt.present
          ? data.inspectedAt.value
          : this.inspectedAt,
      inspectorId: data.inspectorId.present
          ? data.inspectorId.value
          : this.inspectorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsTableData(')
          ..write('id: $id, ')
          ..write('treeLocalId: $treeLocalId, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('aiCondition: $aiCondition, ')
          ..write('aiConfidence: $aiConfidence, ')
          ..write('inspectedAt: $inspectedAt, ')
          ..write('inspectorId: $inspectorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    treeLocalId,
    photoUrl,
    aiCondition,
    aiConfidence,
    inspectedAt,
    inspectorId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionsTableData &&
          other.id == this.id &&
          other.treeLocalId == this.treeLocalId &&
          other.photoUrl == this.photoUrl &&
          other.aiCondition == this.aiCondition &&
          other.aiConfidence == this.aiConfidence &&
          other.inspectedAt == this.inspectedAt &&
          other.inspectorId == this.inspectorId);
}

class InspectionsTableCompanion extends UpdateCompanion<InspectionsTableData> {
  final Value<String> id;
  final Value<String> treeLocalId;
  final Value<String> photoUrl;
  final Value<String> aiCondition;
  final Value<double> aiConfidence;
  final Value<DateTime> inspectedAt;
  final Value<String?> inspectorId;
  final Value<int> rowid;
  const InspectionsTableCompanion({
    this.id = const Value.absent(),
    this.treeLocalId = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.aiCondition = const Value.absent(),
    this.aiConfidence = const Value.absent(),
    this.inspectedAt = const Value.absent(),
    this.inspectorId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspectionsTableCompanion.insert({
    required String id,
    required String treeLocalId,
    required String photoUrl,
    required String aiCondition,
    required double aiConfidence,
    required DateTime inspectedAt,
    this.inspectorId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       treeLocalId = Value(treeLocalId),
       photoUrl = Value(photoUrl),
       aiCondition = Value(aiCondition),
       aiConfidence = Value(aiConfidence),
       inspectedAt = Value(inspectedAt);
  static Insertable<InspectionsTableData> custom({
    Expression<String>? id,
    Expression<String>? treeLocalId,
    Expression<String>? photoUrl,
    Expression<String>? aiCondition,
    Expression<double>? aiConfidence,
    Expression<DateTime>? inspectedAt,
    Expression<String>? inspectorId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeLocalId != null) 'tree_local_id': treeLocalId,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (aiCondition != null) 'ai_condition': aiCondition,
      if (aiConfidence != null) 'ai_confidence': aiConfidence,
      if (inspectedAt != null) 'inspected_at': inspectedAt,
      if (inspectorId != null) 'inspector_id': inspectorId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspectionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? treeLocalId,
    Value<String>? photoUrl,
    Value<String>? aiCondition,
    Value<double>? aiConfidence,
    Value<DateTime>? inspectedAt,
    Value<String?>? inspectorId,
    Value<int>? rowid,
  }) {
    return InspectionsTableCompanion(
      id: id ?? this.id,
      treeLocalId: treeLocalId ?? this.treeLocalId,
      photoUrl: photoUrl ?? this.photoUrl,
      aiCondition: aiCondition ?? this.aiCondition,
      aiConfidence: aiConfidence ?? this.aiConfidence,
      inspectedAt: inspectedAt ?? this.inspectedAt,
      inspectorId: inspectorId ?? this.inspectorId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treeLocalId.present) {
      map['tree_local_id'] = Variable<String>(treeLocalId.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (aiCondition.present) {
      map['ai_condition'] = Variable<String>(aiCondition.value);
    }
    if (aiConfidence.present) {
      map['ai_confidence'] = Variable<double>(aiConfidence.value);
    }
    if (inspectedAt.present) {
      map['inspected_at'] = Variable<DateTime>(inspectedAt.value);
    }
    if (inspectorId.present) {
      map['inspector_id'] = Variable<String>(inspectorId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('treeLocalId: $treeLocalId, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('aiCondition: $aiCondition, ')
          ..write('aiConfidence: $aiConfidence, ')
          ..write('inspectedAt: $inspectedAt, ')
          ..write('inspectorId: $inspectorId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TreesTableTable treesTable = $TreesTableTable(this);
  late final $WorkRequestsTableTable workRequestsTable =
      $WorkRequestsTableTable(this);
  late final $InspectionsTableTable inspectionsTable = $InspectionsTableTable(
    this,
  );
  late final TreeDao treeDao = TreeDao(this as AppDatabase);
  late final WorkRequestDao workRequestDao = WorkRequestDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    treesTable,
    workRequestsTable,
    inspectionsTable,
  ];
}

typedef $$TreesTableTableCreateCompanionBuilder =
    TreesTableCompanion Function({
      required String localId,
      Value<String?> remoteId,
      required double latitude,
      required double longitude,
      required String category,
      required String condition,
      required String status,
      Value<String?> mainPhotoUrl,
      required DateTime lastInspectionDate,
      Value<String?> recommendation,
      required String priority,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TreesTableTableUpdateCompanionBuilder =
    TreesTableCompanion Function({
      Value<String> localId,
      Value<String?> remoteId,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> category,
      Value<String> condition,
      Value<String> status,
      Value<String?> mainPhotoUrl,
      Value<DateTime> lastInspectionDate,
      Value<String?> recommendation,
      Value<String> priority,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TreesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TreesTableTable> {
  $$TreesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainPhotoUrl => $composableBuilder(
    column: $table.mainPhotoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastInspectionDate => $composableBuilder(
    column: $table.lastInspectionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TreesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TreesTableTable> {
  $$TreesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainPhotoUrl => $composableBuilder(
    column: $table.mainPhotoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastInspectionDate => $composableBuilder(
    column: $table.lastInspectionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TreesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreesTableTable> {
  $$TreesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get mainPhotoUrl => $composableBuilder(
    column: $table.mainPhotoUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastInspectionDate => $composableBuilder(
    column: $table.lastInspectionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TreesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TreesTableTable,
          TreesTableData,
          $$TreesTableTableFilterComposer,
          $$TreesTableTableOrderingComposer,
          $$TreesTableTableAnnotationComposer,
          $$TreesTableTableCreateCompanionBuilder,
          $$TreesTableTableUpdateCompanionBuilder,
          (
            TreesTableData,
            BaseReferences<_$AppDatabase, $TreesTableTable, TreesTableData>,
          ),
          TreesTableData,
          PrefetchHooks Function()
        > {
  $$TreesTableTableTableManager(_$AppDatabase db, $TreesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> localId = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> mainPhotoUrl = const Value.absent(),
                Value<DateTime> lastInspectionDate = const Value.absent(),
                Value<String?> recommendation = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TreesTableCompanion(
                localId: localId,
                remoteId: remoteId,
                latitude: latitude,
                longitude: longitude,
                category: category,
                condition: condition,
                status: status,
                mainPhotoUrl: mainPhotoUrl,
                lastInspectionDate: lastInspectionDate,
                recommendation: recommendation,
                priority: priority,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String localId,
                Value<String?> remoteId = const Value.absent(),
                required double latitude,
                required double longitude,
                required String category,
                required String condition,
                required String status,
                Value<String?> mainPhotoUrl = const Value.absent(),
                required DateTime lastInspectionDate,
                Value<String?> recommendation = const Value.absent(),
                required String priority,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TreesTableCompanion.insert(
                localId: localId,
                remoteId: remoteId,
                latitude: latitude,
                longitude: longitude,
                category: category,
                condition: condition,
                status: status,
                mainPhotoUrl: mainPhotoUrl,
                lastInspectionDate: lastInspectionDate,
                recommendation: recommendation,
                priority: priority,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TreesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TreesTableTable,
      TreesTableData,
      $$TreesTableTableFilterComposer,
      $$TreesTableTableOrderingComposer,
      $$TreesTableTableAnnotationComposer,
      $$TreesTableTableCreateCompanionBuilder,
      $$TreesTableTableUpdateCompanionBuilder,
      (
        TreesTableData,
        BaseReferences<_$AppDatabase, $TreesTableTable, TreesTableData>,
      ),
      TreesTableData,
      PrefetchHooks Function()
    >;
typedef $$WorkRequestsTableTableCreateCompanionBuilder =
    WorkRequestsTableCompanion Function({
      required String id,
      Value<String?> treeLocalId,
      required String localPhotoPath,
      Value<String?> remotePhotoUrl,
      required double latitude,
      required double longitude,
      required String userProblemsCsv,
      Value<String?> userComment,
      required String status,
      Value<String?> aiCondition,
      Value<double?> aiConfidence,
      required String createdByUserId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> syncAttempts,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$WorkRequestsTableTableUpdateCompanionBuilder =
    WorkRequestsTableCompanion Function({
      Value<String> id,
      Value<String?> treeLocalId,
      Value<String> localPhotoPath,
      Value<String?> remotePhotoUrl,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> userProblemsCsv,
      Value<String?> userComment,
      Value<String> status,
      Value<String?> aiCondition,
      Value<double?> aiConfidence,
      Value<String> createdByUserId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncAttempts,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$WorkRequestsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkRequestsTableTable> {
  $$WorkRequestsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treeLocalId => $composableBuilder(
    column: $table.treeLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPhotoPath => $composableBuilder(
    column: $table.localPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remotePhotoUrl => $composableBuilder(
    column: $table.remotePhotoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userProblemsCsv => $composableBuilder(
    column: $table.userProblemsCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userComment => $composableBuilder(
    column: $table.userComment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiCondition => $composableBuilder(
    column: $table.aiCondition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkRequestsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkRequestsTableTable> {
  $$WorkRequestsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treeLocalId => $composableBuilder(
    column: $table.treeLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPhotoPath => $composableBuilder(
    column: $table.localPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remotePhotoUrl => $composableBuilder(
    column: $table.remotePhotoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userProblemsCsv => $composableBuilder(
    column: $table.userProblemsCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userComment => $composableBuilder(
    column: $table.userComment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiCondition => $composableBuilder(
    column: $table.aiCondition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkRequestsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkRequestsTableTable> {
  $$WorkRequestsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeLocalId => $composableBuilder(
    column: $table.treeLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localPhotoPath => $composableBuilder(
    column: $table.localPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remotePhotoUrl => $composableBuilder(
    column: $table.remotePhotoUrl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get userProblemsCsv => $composableBuilder(
    column: $table.userProblemsCsv,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userComment => $composableBuilder(
    column: $table.userComment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get aiCondition => $composableBuilder(
    column: $table.aiCondition,
    builder: (column) => column,
  );

  GeneratedColumn<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$WorkRequestsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkRequestsTableTable,
          WorkRequestsTableData,
          $$WorkRequestsTableTableFilterComposer,
          $$WorkRequestsTableTableOrderingComposer,
          $$WorkRequestsTableTableAnnotationComposer,
          $$WorkRequestsTableTableCreateCompanionBuilder,
          $$WorkRequestsTableTableUpdateCompanionBuilder,
          (
            WorkRequestsTableData,
            BaseReferences<
              _$AppDatabase,
              $WorkRequestsTableTable,
              WorkRequestsTableData
            >,
          ),
          WorkRequestsTableData,
          PrefetchHooks Function()
        > {
  $$WorkRequestsTableTableTableManager(
    _$AppDatabase db,
    $WorkRequestsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkRequestsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkRequestsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkRequestsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> treeLocalId = const Value.absent(),
                Value<String> localPhotoPath = const Value.absent(),
                Value<String?> remotePhotoUrl = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> userProblemsCsv = const Value.absent(),
                Value<String?> userComment = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> aiCondition = const Value.absent(),
                Value<double?> aiConfidence = const Value.absent(),
                Value<String> createdByUserId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncAttempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkRequestsTableCompanion(
                id: id,
                treeLocalId: treeLocalId,
                localPhotoPath: localPhotoPath,
                remotePhotoUrl: remotePhotoUrl,
                latitude: latitude,
                longitude: longitude,
                userProblemsCsv: userProblemsCsv,
                userComment: userComment,
                status: status,
                aiCondition: aiCondition,
                aiConfidence: aiConfidence,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncAttempts: syncAttempts,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> treeLocalId = const Value.absent(),
                required String localPhotoPath,
                Value<String?> remotePhotoUrl = const Value.absent(),
                required double latitude,
                required double longitude,
                required String userProblemsCsv,
                Value<String?> userComment = const Value.absent(),
                required String status,
                Value<String?> aiCondition = const Value.absent(),
                Value<double?> aiConfidence = const Value.absent(),
                required String createdByUserId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> syncAttempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkRequestsTableCompanion.insert(
                id: id,
                treeLocalId: treeLocalId,
                localPhotoPath: localPhotoPath,
                remotePhotoUrl: remotePhotoUrl,
                latitude: latitude,
                longitude: longitude,
                userProblemsCsv: userProblemsCsv,
                userComment: userComment,
                status: status,
                aiCondition: aiCondition,
                aiConfidence: aiConfidence,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncAttempts: syncAttempts,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkRequestsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkRequestsTableTable,
      WorkRequestsTableData,
      $$WorkRequestsTableTableFilterComposer,
      $$WorkRequestsTableTableOrderingComposer,
      $$WorkRequestsTableTableAnnotationComposer,
      $$WorkRequestsTableTableCreateCompanionBuilder,
      $$WorkRequestsTableTableUpdateCompanionBuilder,
      (
        WorkRequestsTableData,
        BaseReferences<
          _$AppDatabase,
          $WorkRequestsTableTable,
          WorkRequestsTableData
        >,
      ),
      WorkRequestsTableData,
      PrefetchHooks Function()
    >;
typedef $$InspectionsTableTableCreateCompanionBuilder =
    InspectionsTableCompanion Function({
      required String id,
      required String treeLocalId,
      required String photoUrl,
      required String aiCondition,
      required double aiConfidence,
      required DateTime inspectedAt,
      Value<String?> inspectorId,
      Value<int> rowid,
    });
typedef $$InspectionsTableTableUpdateCompanionBuilder =
    InspectionsTableCompanion Function({
      Value<String> id,
      Value<String> treeLocalId,
      Value<String> photoUrl,
      Value<String> aiCondition,
      Value<double> aiConfidence,
      Value<DateTime> inspectedAt,
      Value<String?> inspectorId,
      Value<int> rowid,
    });

class $$InspectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treeLocalId => $composableBuilder(
    column: $table.treeLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiCondition => $composableBuilder(
    column: $table.aiCondition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get inspectedAt => $composableBuilder(
    column: $table.inspectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inspectorId => $composableBuilder(
    column: $table.inspectorId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treeLocalId => $composableBuilder(
    column: $table.treeLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiCondition => $composableBuilder(
    column: $table.aiCondition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get inspectedAt => $composableBuilder(
    column: $table.inspectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inspectorId => $composableBuilder(
    column: $table.inspectorId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeLocalId => $composableBuilder(
    column: $table.treeLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get aiCondition => $composableBuilder(
    column: $table.aiCondition,
    builder: (column) => column,
  );

  GeneratedColumn<double> get aiConfidence => $composableBuilder(
    column: $table.aiConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get inspectedAt => $composableBuilder(
    column: $table.inspectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inspectorId => $composableBuilder(
    column: $table.inspectorId,
    builder: (column) => column,
  );
}

class $$InspectionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionsTableTable,
          InspectionsTableData,
          $$InspectionsTableTableFilterComposer,
          $$InspectionsTableTableOrderingComposer,
          $$InspectionsTableTableAnnotationComposer,
          $$InspectionsTableTableCreateCompanionBuilder,
          $$InspectionsTableTableUpdateCompanionBuilder,
          (
            InspectionsTableData,
            BaseReferences<
              _$AppDatabase,
              $InspectionsTableTable,
              InspectionsTableData
            >,
          ),
          InspectionsTableData,
          PrefetchHooks Function()
        > {
  $$InspectionsTableTableTableManager(
    _$AppDatabase db,
    $InspectionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> treeLocalId = const Value.absent(),
                Value<String> photoUrl = const Value.absent(),
                Value<String> aiCondition = const Value.absent(),
                Value<double> aiConfidence = const Value.absent(),
                Value<DateTime> inspectedAt = const Value.absent(),
                Value<String?> inspectorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionsTableCompanion(
                id: id,
                treeLocalId: treeLocalId,
                photoUrl: photoUrl,
                aiCondition: aiCondition,
                aiConfidence: aiConfidence,
                inspectedAt: inspectedAt,
                inspectorId: inspectorId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String treeLocalId,
                required String photoUrl,
                required String aiCondition,
                required double aiConfidence,
                required DateTime inspectedAt,
                Value<String?> inspectorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionsTableCompanion.insert(
                id: id,
                treeLocalId: treeLocalId,
                photoUrl: photoUrl,
                aiCondition: aiCondition,
                aiConfidence: aiConfidence,
                inspectedAt: inspectedAt,
                inspectorId: inspectorId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionsTableTable,
      InspectionsTableData,
      $$InspectionsTableTableFilterComposer,
      $$InspectionsTableTableOrderingComposer,
      $$InspectionsTableTableAnnotationComposer,
      $$InspectionsTableTableCreateCompanionBuilder,
      $$InspectionsTableTableUpdateCompanionBuilder,
      (
        InspectionsTableData,
        BaseReferences<
          _$AppDatabase,
          $InspectionsTableTable,
          InspectionsTableData
        >,
      ),
      InspectionsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TreesTableTableTableManager get treesTable =>
      $$TreesTableTableTableManager(_db, _db.treesTable);
  $$WorkRequestsTableTableTableManager get workRequestsTable =>
      $$WorkRequestsTableTableTableManager(_db, _db.workRequestsTable);
  $$InspectionsTableTableTableManager get inspectionsTable =>
      $$InspectionsTableTableTableManager(_db, _db.inspectionsTable);
}
