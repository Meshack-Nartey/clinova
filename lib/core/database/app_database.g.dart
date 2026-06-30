// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleValueMeta = const VerificationMeta(
    'roleValue',
  );
  @override
  late final GeneratedColumn<String> roleValue = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    roleValue,
    pinHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleValueMeta,
        roleValue.isAcceptableOrUnknown(data['role']!, _roleValueMeta),
      );
    } else if (isInserting) {
      context.missing(_roleValueMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      roleValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String name;
  final String roleValue;
  final String pinHash;
  final int createdAt;
  const User({
    required this.id,
    required this.name,
    required this.roleValue,
    required this.pinHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(roleValue);
    map['pin_hash'] = Variable<String>(pinHash);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      roleValue: Value(roleValue),
      pinHash: Value(pinHash),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      roleValue: serializer.fromJson<String>(json['roleValue']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'roleValue': serializer.toJson<String>(roleValue),
      'pinHash': serializer.toJson<String>(pinHash),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? roleValue,
    String? pinHash,
    int? createdAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    roleValue: roleValue ?? this.roleValue,
    pinHash: pinHash ?? this.pinHash,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      roleValue: data.roleValue.present ? data.roleValue.value : this.roleValue,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('roleValue: $roleValue, ')
          ..write('pinHash: $pinHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, roleValue, pinHash, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.roleValue == this.roleValue &&
          other.pinHash == this.pinHash &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> roleValue;
  final Value<String> pinHash;
  final Value<int> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.roleValue = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    required String roleValue,
    required String pinHash,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       roleValue = Value(roleValue),
       pinHash = Value(pinHash),
       createdAt = Value(createdAt);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? roleValue,
    Expression<String>? pinHash,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (roleValue != null) 'role': roleValue,
      if (pinHash != null) 'pin_hash': pinHash,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? roleValue,
    Value<String>? pinHash,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      roleValue: roleValue ?? this.roleValue,
      pinHash: pinHash ?? this.pinHash,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (roleValue.present) {
      map['role'] = Variable<String>(roleValue.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('roleValue: $roleValue, ')
          ..write('pinHash: $pinHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _friendlyNameMeta = const VerificationMeta(
    'friendlyName',
  );
  @override
  late final GeneratedColumn<String> friendlyName = GeneratedColumn<String>(
    'friendly_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHubMeta = const VerificationMeta('isHub');
  @override
  late final GeneratedColumn<bool> isHub = GeneratedColumn<bool>(
    'is_hub',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hub" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<int> lastSeenAt = GeneratedColumn<int>(
    'last_seen_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, friendlyName, isHub, lastSeenAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Device> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('friendly_name')) {
      context.handle(
        _friendlyNameMeta,
        friendlyName.isAcceptableOrUnknown(
          data['friendly_name']!,
          _friendlyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_friendlyNameMeta);
    }
    if (data.containsKey('is_hub')) {
      context.handle(
        _isHubMeta,
        isHub.isAcceptableOrUnknown(data['is_hub']!, _isHubMeta),
      );
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      friendlyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}friendly_name'],
      )!,
      isHub: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hub'],
      )!,
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_seen_at'],
      ),
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final String id;
  final String friendlyName;
  final bool isHub;
  final int? lastSeenAt;
  const Device({
    required this.id,
    required this.friendlyName,
    required this.isHub,
    this.lastSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['friendly_name'] = Variable<String>(friendlyName);
    map['is_hub'] = Variable<bool>(isHub);
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<int>(lastSeenAt);
    }
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      friendlyName: Value(friendlyName),
      isHub: Value(isHub),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
    );
  }

  factory Device.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<String>(json['id']),
      friendlyName: serializer.fromJson<String>(json['friendlyName']),
      isHub: serializer.fromJson<bool>(json['isHub']),
      lastSeenAt: serializer.fromJson<int?>(json['lastSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'friendlyName': serializer.toJson<String>(friendlyName),
      'isHub': serializer.toJson<bool>(isHub),
      'lastSeenAt': serializer.toJson<int?>(lastSeenAt),
    };
  }

  Device copyWith({
    String? id,
    String? friendlyName,
    bool? isHub,
    Value<int?> lastSeenAt = const Value.absent(),
  }) => Device(
    id: id ?? this.id,
    friendlyName: friendlyName ?? this.friendlyName,
    isHub: isHub ?? this.isHub,
    lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
  );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      id: data.id.present ? data.id.value : this.id,
      friendlyName: data.friendlyName.present
          ? data.friendlyName.value
          : this.friendlyName,
      isHub: data.isHub.present ? data.isHub.value : this.isHub,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('friendlyName: $friendlyName, ')
          ..write('isHub: $isHub, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, friendlyName, isHub, lastSeenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.friendlyName == this.friendlyName &&
          other.isHub == this.isHub &&
          other.lastSeenAt == this.lastSeenAt);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<String> id;
  final Value<String> friendlyName;
  final Value<bool> isHub;
  final Value<int?> lastSeenAt;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.friendlyName = const Value.absent(),
    this.isHub = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    required String friendlyName,
    this.isHub = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       friendlyName = Value(friendlyName);
  static Insertable<Device> custom({
    Expression<String>? id,
    Expression<String>? friendlyName,
    Expression<bool>? isHub,
    Expression<int>? lastSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (friendlyName != null) 'friendly_name': friendlyName,
      if (isHub != null) 'is_hub': isHub,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith({
    Value<String>? id,
    Value<String>? friendlyName,
    Value<bool>? isHub,
    Value<int?>? lastSeenAt,
    Value<int>? rowid,
  }) {
    return DevicesCompanion(
      id: id ?? this.id,
      friendlyName: friendlyName ?? this.friendlyName,
      isHub: isHub ?? this.isHub,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (friendlyName.present) {
      map['friendly_name'] = Variable<String>(friendlyName.value);
    }
    if (isHub.present) {
      map['is_hub'] = Variable<bool>(isHub.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<int>(lastSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('friendlyName: $friendlyName, ')
          ..write('isHub: $isHub, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<int> expiresAt = GeneratedColumn<int>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    deviceId,
    token,
    createdAt,
    expiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      token: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expires_at'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final String userId;
  final String deviceId;
  final String token;
  final int createdAt;
  final int expiresAt;
  const Session({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.token,
    required this.createdAt,
    required this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['device_id'] = Variable<String>(deviceId);
    map['token'] = Variable<String>(token);
    map['created_at'] = Variable<int>(createdAt);
    map['expires_at'] = Variable<int>(expiresAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      deviceId: Value(deviceId),
      token: Value(token),
      createdAt: Value(createdAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      token: serializer.fromJson<String>(json['token']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      expiresAt: serializer.fromJson<int>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'deviceId': serializer.toJson<String>(deviceId),
      'token': serializer.toJson<String>(token),
      'createdAt': serializer.toJson<int>(createdAt),
      'expiresAt': serializer.toJson<int>(expiresAt),
    };
  }

  Session copyWith({
    String? id,
    String? userId,
    String? deviceId,
    String? token,
    int? createdAt,
    int? expiresAt,
  }) => Session(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    deviceId: deviceId ?? this.deviceId,
    token: token ?? this.token,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt ?? this.expiresAt,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      token: data.token.present ? data.token.value : this.token,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('deviceId: $deviceId, ')
          ..write('token: $token, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, deviceId, token, createdAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.deviceId == this.deviceId &&
          other.token == this.token &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> deviceId;
  final Value<String> token;
  final Value<int> createdAt;
  final Value<int> expiresAt;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.token = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required String userId,
    required String deviceId,
    required String token,
    required int createdAt,
    required int expiresAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       deviceId = Value(deviceId),
       token = Value(token),
       createdAt = Value(createdAt),
       expiresAt = Value(expiresAt);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? deviceId,
    Expression<String>? token,
    Expression<int>? createdAt,
    Expression<int>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (deviceId != null) 'device_id': deviceId,
      if (token != null) 'token': token,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? deviceId,
    Value<String>? token,
    Value<int>? createdAt,
    Value<int>? expiresAt,
    Value<int>? rowid,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('deviceId: $deviceId, ')
          ..write('token: $token, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionDateMeta = const VerificationMeta(
    'sessionDate',
  );
  @override
  late final GeneratedColumn<String> sessionDate = GeneratedColumn<String>(
    'session_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _communityMeta = const VerificationMeta(
    'community',
  );
  @override
  late final GeneratedColumn<String> community = GeneratedColumn<String>(
    'community',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chiefComplaintMeta = const VerificationMeta(
    'chiefComplaint',
  );
  @override
  late final GeneratedColumn<String> chiefComplaint = GeneratedColumn<String>(
    'chief_complaint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bloodPressureMeta = const VerificationMeta(
    'bloodPressure',
  );
  @override
  late final GeneratedColumn<String> bloodPressure = GeneratedColumn<String>(
    'blood_pressure',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureCelsiusMeta =
      const VerificationMeta('temperatureCelsius');
  @override
  late final GeneratedColumn<double> temperatureCelsius =
      GeneratedColumn<double>(
        'temperature_celsius',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pulsePerMinMeta = const VerificationMeta(
    'pulsePerMin',
  );
  @override
  late final GeneratedColumn<int> pulsePerMin = GeneratedColumn<int>(
    'pulse_per_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spo2PercentMeta = const VerificationMeta(
    'spo2Percent',
  );
  @override
  late final GeneratedColumn<double> spo2Percent = GeneratedColumn<double>(
    'spo2_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intakeByMeta = const VerificationMeta(
    'intakeBy',
  );
  @override
  late final GeneratedColumn<String> intakeBy = GeneratedColumn<String>(
    'intake_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intakeAtMeta = const VerificationMeta(
    'intakeAt',
  );
  @override
  late final GeneratedColumn<int> intakeAt = GeneratedColumn<int>(
    'intake_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionDate,
    fullName,
    dateOfBirth,
    sex,
    phone,
    community,
    chiefComplaint,
    bloodPressure,
    temperatureCelsius,
    weightKg,
    heightCm,
    pulsePerMin,
    spo2Percent,
    intakeBy,
    intakeAt,
    updatedBy,
    updatedAt,
    isDeleted,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Patient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_date')) {
      context.handle(
        _sessionDateMeta,
        sessionDate.isAcceptableOrUnknown(
          data['session_date']!,
          _sessionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('community')) {
      context.handle(
        _communityMeta,
        community.isAcceptableOrUnknown(data['community']!, _communityMeta),
      );
    }
    if (data.containsKey('chief_complaint')) {
      context.handle(
        _chiefComplaintMeta,
        chiefComplaint.isAcceptableOrUnknown(
          data['chief_complaint']!,
          _chiefComplaintMeta,
        ),
      );
    }
    if (data.containsKey('blood_pressure')) {
      context.handle(
        _bloodPressureMeta,
        bloodPressure.isAcceptableOrUnknown(
          data['blood_pressure']!,
          _bloodPressureMeta,
        ),
      );
    }
    if (data.containsKey('temperature_celsius')) {
      context.handle(
        _temperatureCelsiusMeta,
        temperatureCelsius.isAcceptableOrUnknown(
          data['temperature_celsius']!,
          _temperatureCelsiusMeta,
        ),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('pulse_per_min')) {
      context.handle(
        _pulsePerMinMeta,
        pulsePerMin.isAcceptableOrUnknown(
          data['pulse_per_min']!,
          _pulsePerMinMeta,
        ),
      );
    }
    if (data.containsKey('spo2_percent')) {
      context.handle(
        _spo2PercentMeta,
        spo2Percent.isAcceptableOrUnknown(
          data['spo2_percent']!,
          _spo2PercentMeta,
        ),
      );
    }
    if (data.containsKey('intake_by')) {
      context.handle(
        _intakeByMeta,
        intakeBy.isAcceptableOrUnknown(data['intake_by']!, _intakeByMeta),
      );
    }
    if (data.containsKey('intake_at')) {
      context.handle(
        _intakeAtMeta,
        intakeAt.isAcceptableOrUnknown(data['intake_at']!, _intakeAtMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_date'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_of_birth'],
      ),
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      community: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community'],
      ),
      chiefComplaint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chief_complaint'],
      ),
      bloodPressure: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_pressure'],
      ),
      temperatureCelsius: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature_celsius'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      pulsePerMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pulse_per_min'],
      ),
      spo2Percent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}spo2_percent'],
      ),
      intakeBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intake_by'],
      ),
      intakeAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intake_at'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
  final String id;
  final String sessionDate;
  final String fullName;
  final String? dateOfBirth;
  final String? sex;
  final String? phone;
  final String? community;
  final String? chiefComplaint;
  final String? bloodPressure;
  final double? temperatureCelsius;
  final double? weightKg;
  final double? heightCm;
  final int? pulsePerMin;
  final double? spo2Percent;
  final String? intakeBy;
  final int? intakeAt;
  final String? updatedBy;
  final int updatedAt;
  final bool isDeleted;
  final int version;
  const Patient({
    required this.id,
    required this.sessionDate,
    required this.fullName,
    this.dateOfBirth,
    this.sex,
    this.phone,
    this.community,
    this.chiefComplaint,
    this.bloodPressure,
    this.temperatureCelsius,
    this.weightKg,
    this.heightCm,
    this.pulsePerMin,
    this.spo2Percent,
    this.intakeBy,
    this.intakeAt,
    this.updatedBy,
    required this.updatedAt,
    required this.isDeleted,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_date'] = Variable<String>(sessionDate);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || community != null) {
      map['community'] = Variable<String>(community);
    }
    if (!nullToAbsent || chiefComplaint != null) {
      map['chief_complaint'] = Variable<String>(chiefComplaint);
    }
    if (!nullToAbsent || bloodPressure != null) {
      map['blood_pressure'] = Variable<String>(bloodPressure);
    }
    if (!nullToAbsent || temperatureCelsius != null) {
      map['temperature_celsius'] = Variable<double>(temperatureCelsius);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || pulsePerMin != null) {
      map['pulse_per_min'] = Variable<int>(pulsePerMin);
    }
    if (!nullToAbsent || spo2Percent != null) {
      map['spo2_percent'] = Variable<double>(spo2Percent);
    }
    if (!nullToAbsent || intakeBy != null) {
      map['intake_by'] = Variable<String>(intakeBy);
    }
    if (!nullToAbsent || intakeAt != null) {
      map['intake_at'] = Variable<int>(intakeAt);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['updated_at'] = Variable<int>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['version'] = Variable<int>(version);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      sessionDate: Value(sessionDate),
      fullName: Value(fullName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      community: community == null && nullToAbsent
          ? const Value.absent()
          : Value(community),
      chiefComplaint: chiefComplaint == null && nullToAbsent
          ? const Value.absent()
          : Value(chiefComplaint),
      bloodPressure: bloodPressure == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodPressure),
      temperatureCelsius: temperatureCelsius == null && nullToAbsent
          ? const Value.absent()
          : Value(temperatureCelsius),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      pulsePerMin: pulsePerMin == null && nullToAbsent
          ? const Value.absent()
          : Value(pulsePerMin),
      spo2Percent: spo2Percent == null && nullToAbsent
          ? const Value.absent()
          : Value(spo2Percent),
      intakeBy: intakeBy == null && nullToAbsent
          ? const Value.absent()
          : Value(intakeBy),
      intakeAt: intakeAt == null && nullToAbsent
          ? const Value.absent()
          : Value(intakeAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      version: Value(version),
    );
  }

  factory Patient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<String>(json['id']),
      sessionDate: serializer.fromJson<String>(json['sessionDate']),
      fullName: serializer.fromJson<String>(json['fullName']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      sex: serializer.fromJson<String?>(json['sex']),
      phone: serializer.fromJson<String?>(json['phone']),
      community: serializer.fromJson<String?>(json['community']),
      chiefComplaint: serializer.fromJson<String?>(json['chiefComplaint']),
      bloodPressure: serializer.fromJson<String?>(json['bloodPressure']),
      temperatureCelsius: serializer.fromJson<double?>(
        json['temperatureCelsius'],
      ),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      pulsePerMin: serializer.fromJson<int?>(json['pulsePerMin']),
      spo2Percent: serializer.fromJson<double?>(json['spo2Percent']),
      intakeBy: serializer.fromJson<String?>(json['intakeBy']),
      intakeAt: serializer.fromJson<int?>(json['intakeAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionDate': serializer.toJson<String>(sessionDate),
      'fullName': serializer.toJson<String>(fullName),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'sex': serializer.toJson<String?>(sex),
      'phone': serializer.toJson<String?>(phone),
      'community': serializer.toJson<String?>(community),
      'chiefComplaint': serializer.toJson<String?>(chiefComplaint),
      'bloodPressure': serializer.toJson<String?>(bloodPressure),
      'temperatureCelsius': serializer.toJson<double?>(temperatureCelsius),
      'weightKg': serializer.toJson<double?>(weightKg),
      'heightCm': serializer.toJson<double?>(heightCm),
      'pulsePerMin': serializer.toJson<int?>(pulsePerMin),
      'spo2Percent': serializer.toJson<double?>(spo2Percent),
      'intakeBy': serializer.toJson<String?>(intakeBy),
      'intakeAt': serializer.toJson<int?>(intakeAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'version': serializer.toJson<int>(version),
    };
  }

  Patient copyWith({
    String? id,
    String? sessionDate,
    String? fullName,
    Value<String?> dateOfBirth = const Value.absent(),
    Value<String?> sex = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> community = const Value.absent(),
    Value<String?> chiefComplaint = const Value.absent(),
    Value<String?> bloodPressure = const Value.absent(),
    Value<double?> temperatureCelsius = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<int?> pulsePerMin = const Value.absent(),
    Value<double?> spo2Percent = const Value.absent(),
    Value<String?> intakeBy = const Value.absent(),
    Value<int?> intakeAt = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    int? updatedAt,
    bool? isDeleted,
    int? version,
  }) => Patient(
    id: id ?? this.id,
    sessionDate: sessionDate ?? this.sessionDate,
    fullName: fullName ?? this.fullName,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    sex: sex.present ? sex.value : this.sex,
    phone: phone.present ? phone.value : this.phone,
    community: community.present ? community.value : this.community,
    chiefComplaint: chiefComplaint.present
        ? chiefComplaint.value
        : this.chiefComplaint,
    bloodPressure: bloodPressure.present
        ? bloodPressure.value
        : this.bloodPressure,
    temperatureCelsius: temperatureCelsius.present
        ? temperatureCelsius.value
        : this.temperatureCelsius,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    pulsePerMin: pulsePerMin.present ? pulsePerMin.value : this.pulsePerMin,
    spo2Percent: spo2Percent.present ? spo2Percent.value : this.spo2Percent,
    intakeBy: intakeBy.present ? intakeBy.value : this.intakeBy,
    intakeAt: intakeAt.present ? intakeAt.value : this.intakeAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    version: version ?? this.version,
  );
  Patient copyWithCompanion(PatientsCompanion data) {
    return Patient(
      id: data.id.present ? data.id.value : this.id,
      sessionDate: data.sessionDate.present
          ? data.sessionDate.value
          : this.sessionDate,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      sex: data.sex.present ? data.sex.value : this.sex,
      phone: data.phone.present ? data.phone.value : this.phone,
      community: data.community.present ? data.community.value : this.community,
      chiefComplaint: data.chiefComplaint.present
          ? data.chiefComplaint.value
          : this.chiefComplaint,
      bloodPressure: data.bloodPressure.present
          ? data.bloodPressure.value
          : this.bloodPressure,
      temperatureCelsius: data.temperatureCelsius.present
          ? data.temperatureCelsius.value
          : this.temperatureCelsius,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      pulsePerMin: data.pulsePerMin.present
          ? data.pulsePerMin.value
          : this.pulsePerMin,
      spo2Percent: data.spo2Percent.present
          ? data.spo2Percent.value
          : this.spo2Percent,
      intakeBy: data.intakeBy.present ? data.intakeBy.value : this.intakeBy,
      intakeAt: data.intakeAt.present ? data.intakeAt.value : this.intakeAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('fullName: $fullName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('sex: $sex, ')
          ..write('phone: $phone, ')
          ..write('community: $community, ')
          ..write('chiefComplaint: $chiefComplaint, ')
          ..write('bloodPressure: $bloodPressure, ')
          ..write('temperatureCelsius: $temperatureCelsius, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('pulsePerMin: $pulsePerMin, ')
          ..write('spo2Percent: $spo2Percent, ')
          ..write('intakeBy: $intakeBy, ')
          ..write('intakeAt: $intakeAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionDate,
    fullName,
    dateOfBirth,
    sex,
    phone,
    community,
    chiefComplaint,
    bloodPressure,
    temperatureCelsius,
    weightKg,
    heightCm,
    pulsePerMin,
    spo2Percent,
    intakeBy,
    intakeAt,
    updatedBy,
    updatedAt,
    isDeleted,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.sessionDate == this.sessionDate &&
          other.fullName == this.fullName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.sex == this.sex &&
          other.phone == this.phone &&
          other.community == this.community &&
          other.chiefComplaint == this.chiefComplaint &&
          other.bloodPressure == this.bloodPressure &&
          other.temperatureCelsius == this.temperatureCelsius &&
          other.weightKg == this.weightKg &&
          other.heightCm == this.heightCm &&
          other.pulsePerMin == this.pulsePerMin &&
          other.spo2Percent == this.spo2Percent &&
          other.intakeBy == this.intakeBy &&
          other.intakeAt == this.intakeAt &&
          other.updatedBy == this.updatedBy &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.version == this.version);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<String> id;
  final Value<String> sessionDate;
  final Value<String> fullName;
  final Value<String?> dateOfBirth;
  final Value<String?> sex;
  final Value<String?> phone;
  final Value<String?> community;
  final Value<String?> chiefComplaint;
  final Value<String?> bloodPressure;
  final Value<double?> temperatureCelsius;
  final Value<double?> weightKg;
  final Value<double?> heightCm;
  final Value<int?> pulsePerMin;
  final Value<double?> spo2Percent;
  final Value<String?> intakeBy;
  final Value<int?> intakeAt;
  final Value<String?> updatedBy;
  final Value<int> updatedAt;
  final Value<bool> isDeleted;
  final Value<int> version;
  final Value<int> rowid;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.fullName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.sex = const Value.absent(),
    this.phone = const Value.absent(),
    this.community = const Value.absent(),
    this.chiefComplaint = const Value.absent(),
    this.bloodPressure = const Value.absent(),
    this.temperatureCelsius = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.pulsePerMin = const Value.absent(),
    this.spo2Percent = const Value.absent(),
    this.intakeBy = const Value.absent(),
    this.intakeAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatientsCompanion.insert({
    required String id,
    required String sessionDate,
    required String fullName,
    this.dateOfBirth = const Value.absent(),
    this.sex = const Value.absent(),
    this.phone = const Value.absent(),
    this.community = const Value.absent(),
    this.chiefComplaint = const Value.absent(),
    this.bloodPressure = const Value.absent(),
    this.temperatureCelsius = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.pulsePerMin = const Value.absent(),
    this.spo2Percent = const Value.absent(),
    this.intakeBy = const Value.absent(),
    this.intakeAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
    required int updatedAt,
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionDate = Value(sessionDate),
       fullName = Value(fullName),
       updatedAt = Value(updatedAt);
  static Insertable<Patient> custom({
    Expression<String>? id,
    Expression<String>? sessionDate,
    Expression<String>? fullName,
    Expression<String>? dateOfBirth,
    Expression<String>? sex,
    Expression<String>? phone,
    Expression<String>? community,
    Expression<String>? chiefComplaint,
    Expression<String>? bloodPressure,
    Expression<double>? temperatureCelsius,
    Expression<double>? weightKg,
    Expression<double>? heightCm,
    Expression<int>? pulsePerMin,
    Expression<double>? spo2Percent,
    Expression<String>? intakeBy,
    Expression<int>? intakeAt,
    Expression<String>? updatedBy,
    Expression<int>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionDate != null) 'session_date': sessionDate,
      if (fullName != null) 'full_name': fullName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (sex != null) 'sex': sex,
      if (phone != null) 'phone': phone,
      if (community != null) 'community': community,
      if (chiefComplaint != null) 'chief_complaint': chiefComplaint,
      if (bloodPressure != null) 'blood_pressure': bloodPressure,
      if (temperatureCelsius != null) 'temperature_celsius': temperatureCelsius,
      if (weightKg != null) 'weight_kg': weightKg,
      if (heightCm != null) 'height_cm': heightCm,
      if (pulsePerMin != null) 'pulse_per_min': pulsePerMin,
      if (spo2Percent != null) 'spo2_percent': spo2Percent,
      if (intakeBy != null) 'intake_by': intakeBy,
      if (intakeAt != null) 'intake_at': intakeAt,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatientsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionDate,
    Value<String>? fullName,
    Value<String?>? dateOfBirth,
    Value<String?>? sex,
    Value<String?>? phone,
    Value<String?>? community,
    Value<String?>? chiefComplaint,
    Value<String?>? bloodPressure,
    Value<double?>? temperatureCelsius,
    Value<double?>? weightKg,
    Value<double?>? heightCm,
    Value<int?>? pulsePerMin,
    Value<double?>? spo2Percent,
    Value<String?>? intakeBy,
    Value<int?>? intakeAt,
    Value<String?>? updatedBy,
    Value<int>? updatedAt,
    Value<bool>? isDeleted,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return PatientsCompanion(
      id: id ?? this.id,
      sessionDate: sessionDate ?? this.sessionDate,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      community: community ?? this.community,
      chiefComplaint: chiefComplaint ?? this.chiefComplaint,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      pulsePerMin: pulsePerMin ?? this.pulsePerMin,
      spo2Percent: spo2Percent ?? this.spo2Percent,
      intakeBy: intakeBy ?? this.intakeBy,
      intakeAt: intakeAt ?? this.intakeAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<String>(sessionDate.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (community.present) {
      map['community'] = Variable<String>(community.value);
    }
    if (chiefComplaint.present) {
      map['chief_complaint'] = Variable<String>(chiefComplaint.value);
    }
    if (bloodPressure.present) {
      map['blood_pressure'] = Variable<String>(bloodPressure.value);
    }
    if (temperatureCelsius.present) {
      map['temperature_celsius'] = Variable<double>(temperatureCelsius.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (pulsePerMin.present) {
      map['pulse_per_min'] = Variable<int>(pulsePerMin.value);
    }
    if (spo2Percent.present) {
      map['spo2_percent'] = Variable<double>(spo2Percent.value);
    }
    if (intakeBy.present) {
      map['intake_by'] = Variable<String>(intakeBy.value);
    }
    if (intakeAt.present) {
      map['intake_at'] = Variable<int>(intakeAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('fullName: $fullName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('sex: $sex, ')
          ..write('phone: $phone, ')
          ..write('community: $community, ')
          ..write('chiefComplaint: $chiefComplaint, ')
          ..write('bloodPressure: $bloodPressure, ')
          ..write('temperatureCelsius: $temperatureCelsius, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('pulsePerMin: $pulsePerMin, ')
          ..write('spo2Percent: $spo2Percent, ')
          ..write('intakeBy: $intakeBy, ')
          ..write('intakeAt: $intakeAt, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConsultationsTable extends Consultations
    with TableInfo<$ConsultationsTable, Consultation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsultationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patients (id)',
    ),
  );
  static const VerificationMeta _diagnosisMeta = const VerificationMeta(
    'diagnosis',
  );
  @override
  late final GeneratedColumn<String> diagnosis = GeneratedColumn<String>(
    'diagnosis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clinicalNotesMeta = const VerificationMeta(
    'clinicalNotes',
  );
  @override
  late final GeneratedColumn<String> clinicalNotes = GeneratedColumn<String>(
    'clinical_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prescriptionMeta = const VerificationMeta(
    'prescription',
  );
  @override
  late final GeneratedColumn<String> prescription = GeneratedColumn<String>(
    'prescription',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _followUpDateMeta = const VerificationMeta(
    'followUpDate',
  );
  @override
  late final GeneratedColumn<String> followUpDate = GeneratedColumn<String>(
    'follow_up_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
    'doctor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    diagnosis,
    clinicalNotes,
    prescription,
    followUpDate,
    doctorId,
    createdAt,
    updatedAt,
    isDeleted,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consultations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Consultation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('diagnosis')) {
      context.handle(
        _diagnosisMeta,
        diagnosis.isAcceptableOrUnknown(data['diagnosis']!, _diagnosisMeta),
      );
    }
    if (data.containsKey('clinical_notes')) {
      context.handle(
        _clinicalNotesMeta,
        clinicalNotes.isAcceptableOrUnknown(
          data['clinical_notes']!,
          _clinicalNotesMeta,
        ),
      );
    }
    if (data.containsKey('prescription')) {
      context.handle(
        _prescriptionMeta,
        prescription.isAcceptableOrUnknown(
          data['prescription']!,
          _prescriptionMeta,
        ),
      );
    }
    if (data.containsKey('follow_up_date')) {
      context.handle(
        _followUpDateMeta,
        followUpDate.isAcceptableOrUnknown(
          data['follow_up_date']!,
          _followUpDateMeta,
        ),
      );
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
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
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Consultation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Consultation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      diagnosis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diagnosis'],
      ),
      clinicalNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinical_notes'],
      ),
      prescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prescription'],
      ),
      followUpDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}follow_up_date'],
      ),
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $ConsultationsTable createAlias(String alias) {
    return $ConsultationsTable(attachedDatabase, alias);
  }
}

class Consultation extends DataClass implements Insertable<Consultation> {
  final String id;
  final String patientId;
  final String? diagnosis;
  final String? clinicalNotes;
  final String? prescription;
  final String? followUpDate;
  final String? doctorId;
  final int createdAt;
  final int updatedAt;
  final bool isDeleted;
  final int version;
  const Consultation({
    required this.id,
    required this.patientId,
    this.diagnosis,
    this.clinicalNotes,
    this.prescription,
    this.followUpDate,
    this.doctorId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || diagnosis != null) {
      map['diagnosis'] = Variable<String>(diagnosis);
    }
    if (!nullToAbsent || clinicalNotes != null) {
      map['clinical_notes'] = Variable<String>(clinicalNotes);
    }
    if (!nullToAbsent || prescription != null) {
      map['prescription'] = Variable<String>(prescription);
    }
    if (!nullToAbsent || followUpDate != null) {
      map['follow_up_date'] = Variable<String>(followUpDate);
    }
    if (!nullToAbsent || doctorId != null) {
      map['doctor_id'] = Variable<String>(doctorId);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['version'] = Variable<int>(version);
    return map;
  }

  ConsultationsCompanion toCompanion(bool nullToAbsent) {
    return ConsultationsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      diagnosis: diagnosis == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnosis),
      clinicalNotes: clinicalNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicalNotes),
      prescription: prescription == null && nullToAbsent
          ? const Value.absent()
          : Value(prescription),
      followUpDate: followUpDate == null && nullToAbsent
          ? const Value.absent()
          : Value(followUpDate),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      version: Value(version),
    );
  }

  factory Consultation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Consultation(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      diagnosis: serializer.fromJson<String?>(json['diagnosis']),
      clinicalNotes: serializer.fromJson<String?>(json['clinicalNotes']),
      prescription: serializer.fromJson<String?>(json['prescription']),
      followUpDate: serializer.fromJson<String?>(json['followUpDate']),
      doctorId: serializer.fromJson<String?>(json['doctorId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'diagnosis': serializer.toJson<String?>(diagnosis),
      'clinicalNotes': serializer.toJson<String?>(clinicalNotes),
      'prescription': serializer.toJson<String?>(prescription),
      'followUpDate': serializer.toJson<String?>(followUpDate),
      'doctorId': serializer.toJson<String?>(doctorId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'version': serializer.toJson<int>(version),
    };
  }

  Consultation copyWith({
    String? id,
    String? patientId,
    Value<String?> diagnosis = const Value.absent(),
    Value<String?> clinicalNotes = const Value.absent(),
    Value<String?> prescription = const Value.absent(),
    Value<String?> followUpDate = const Value.absent(),
    Value<String?> doctorId = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    bool? isDeleted,
    int? version,
  }) => Consultation(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    diagnosis: diagnosis.present ? diagnosis.value : this.diagnosis,
    clinicalNotes: clinicalNotes.present
        ? clinicalNotes.value
        : this.clinicalNotes,
    prescription: prescription.present ? prescription.value : this.prescription,
    followUpDate: followUpDate.present ? followUpDate.value : this.followUpDate,
    doctorId: doctorId.present ? doctorId.value : this.doctorId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    version: version ?? this.version,
  );
  Consultation copyWithCompanion(ConsultationsCompanion data) {
    return Consultation(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      diagnosis: data.diagnosis.present ? data.diagnosis.value : this.diagnosis,
      clinicalNotes: data.clinicalNotes.present
          ? data.clinicalNotes.value
          : this.clinicalNotes,
      prescription: data.prescription.present
          ? data.prescription.value
          : this.prescription,
      followUpDate: data.followUpDate.present
          ? data.followUpDate.value
          : this.followUpDate,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Consultation(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('clinicalNotes: $clinicalNotes, ')
          ..write('prescription: $prescription, ')
          ..write('followUpDate: $followUpDate, ')
          ..write('doctorId: $doctorId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    diagnosis,
    clinicalNotes,
    prescription,
    followUpDate,
    doctorId,
    createdAt,
    updatedAt,
    isDeleted,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Consultation &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.diagnosis == this.diagnosis &&
          other.clinicalNotes == this.clinicalNotes &&
          other.prescription == this.prescription &&
          other.followUpDate == this.followUpDate &&
          other.doctorId == this.doctorId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.version == this.version);
}

class ConsultationsCompanion extends UpdateCompanion<Consultation> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String?> diagnosis;
  final Value<String?> clinicalNotes;
  final Value<String?> prescription;
  final Value<String?> followUpDate;
  final Value<String?> doctorId;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<bool> isDeleted;
  final Value<int> version;
  final Value<int> rowid;
  const ConsultationsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.clinicalNotes = const Value.absent(),
    this.prescription = const Value.absent(),
    this.followUpDate = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConsultationsCompanion.insert({
    required String id,
    required String patientId,
    this.diagnosis = const Value.absent(),
    this.clinicalNotes = const Value.absent(),
    this.prescription = const Value.absent(),
    this.followUpDate = const Value.absent(),
    this.doctorId = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Consultation> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? diagnosis,
    Expression<String>? clinicalNotes,
    Expression<String>? prescription,
    Expression<String>? followUpDate,
    Expression<String>? doctorId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (diagnosis != null) 'diagnosis': diagnosis,
      if (clinicalNotes != null) 'clinical_notes': clinicalNotes,
      if (prescription != null) 'prescription': prescription,
      if (followUpDate != null) 'follow_up_date': followUpDate,
      if (doctorId != null) 'doctor_id': doctorId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConsultationsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String?>? diagnosis,
    Value<String?>? clinicalNotes,
    Value<String?>? prescription,
    Value<String?>? followUpDate,
    Value<String?>? doctorId,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<bool>? isDeleted,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return ConsultationsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      diagnosis: diagnosis ?? this.diagnosis,
      clinicalNotes: clinicalNotes ?? this.clinicalNotes,
      prescription: prescription ?? this.prescription,
      followUpDate: followUpDate ?? this.followUpDate,
      doctorId: doctorId ?? this.doctorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (diagnosis.present) {
      map['diagnosis'] = Variable<String>(diagnosis.value);
    }
    if (clinicalNotes.present) {
      map['clinical_notes'] = Variable<String>(clinicalNotes.value);
    }
    if (prescription.present) {
      map['prescription'] = Variable<String>(prescription.value);
    }
    if (followUpDate.present) {
      map['follow_up_date'] = Variable<String>(followUpDate.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsultationsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('clinicalNotes: $clinicalNotes, ')
          ..write('prescription: $prescription, ')
          ..write('followUpDate: $followUpDate, ')
          ..write('doctorId: $doctorId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DispensingRecordsTable extends DispensingRecords
    with TableInfo<$DispensingRecordsTable, DispensingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DispensingRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patients (id)',
    ),
  );
  static const VerificationMeta _itemsDispensedMeta = const VerificationMeta(
    'itemsDispensed',
  );
  @override
  late final GeneratedColumn<String> itemsDispensed = GeneratedColumn<String>(
    'items_dispensed',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _counsellingNotesMeta = const VerificationMeta(
    'counsellingNotes',
  );
  @override
  late final GeneratedColumn<String> counsellingNotes = GeneratedColumn<String>(
    'counselling_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pharmacistIdMeta = const VerificationMeta(
    'pharmacistId',
  );
  @override
  late final GeneratedColumn<String> pharmacistId = GeneratedColumn<String>(
    'pharmacist_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    itemsDispensed,
    counsellingNotes,
    pharmacistId,
    createdAt,
    updatedAt,
    isDeleted,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dispensing_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DispensingRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('items_dispensed')) {
      context.handle(
        _itemsDispensedMeta,
        itemsDispensed.isAcceptableOrUnknown(
          data['items_dispensed']!,
          _itemsDispensedMeta,
        ),
      );
    }
    if (data.containsKey('counselling_notes')) {
      context.handle(
        _counsellingNotesMeta,
        counsellingNotes.isAcceptableOrUnknown(
          data['counselling_notes']!,
          _counsellingNotesMeta,
        ),
      );
    }
    if (data.containsKey('pharmacist_id')) {
      context.handle(
        _pharmacistIdMeta,
        pharmacistId.isAcceptableOrUnknown(
          data['pharmacist_id']!,
          _pharmacistIdMeta,
        ),
      );
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
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DispensingRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DispensingRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      itemsDispensed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_dispensed'],
      ),
      counsellingNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counselling_notes'],
      ),
      pharmacistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pharmacist_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $DispensingRecordsTable createAlias(String alias) {
    return $DispensingRecordsTable(attachedDatabase, alias);
  }
}

class DispensingRecord extends DataClass
    implements Insertable<DispensingRecord> {
  final String id;
  final String patientId;
  final String? itemsDispensed;
  final String? counsellingNotes;
  final String? pharmacistId;
  final int createdAt;
  final int updatedAt;
  final bool isDeleted;
  final int version;
  const DispensingRecord({
    required this.id,
    required this.patientId,
    this.itemsDispensed,
    this.counsellingNotes,
    this.pharmacistId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || itemsDispensed != null) {
      map['items_dispensed'] = Variable<String>(itemsDispensed);
    }
    if (!nullToAbsent || counsellingNotes != null) {
      map['counselling_notes'] = Variable<String>(counsellingNotes);
    }
    if (!nullToAbsent || pharmacistId != null) {
      map['pharmacist_id'] = Variable<String>(pharmacistId);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['version'] = Variable<int>(version);
    return map;
  }

  DispensingRecordsCompanion toCompanion(bool nullToAbsent) {
    return DispensingRecordsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      itemsDispensed: itemsDispensed == null && nullToAbsent
          ? const Value.absent()
          : Value(itemsDispensed),
      counsellingNotes: counsellingNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(counsellingNotes),
      pharmacistId: pharmacistId == null && nullToAbsent
          ? const Value.absent()
          : Value(pharmacistId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      version: Value(version),
    );
  }

  factory DispensingRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DispensingRecord(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      itemsDispensed: serializer.fromJson<String?>(json['itemsDispensed']),
      counsellingNotes: serializer.fromJson<String?>(json['counsellingNotes']),
      pharmacistId: serializer.fromJson<String?>(json['pharmacistId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'itemsDispensed': serializer.toJson<String?>(itemsDispensed),
      'counsellingNotes': serializer.toJson<String?>(counsellingNotes),
      'pharmacistId': serializer.toJson<String?>(pharmacistId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'version': serializer.toJson<int>(version),
    };
  }

  DispensingRecord copyWith({
    String? id,
    String? patientId,
    Value<String?> itemsDispensed = const Value.absent(),
    Value<String?> counsellingNotes = const Value.absent(),
    Value<String?> pharmacistId = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    bool? isDeleted,
    int? version,
  }) => DispensingRecord(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    itemsDispensed: itemsDispensed.present
        ? itemsDispensed.value
        : this.itemsDispensed,
    counsellingNotes: counsellingNotes.present
        ? counsellingNotes.value
        : this.counsellingNotes,
    pharmacistId: pharmacistId.present ? pharmacistId.value : this.pharmacistId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    version: version ?? this.version,
  );
  DispensingRecord copyWithCompanion(DispensingRecordsCompanion data) {
    return DispensingRecord(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      itemsDispensed: data.itemsDispensed.present
          ? data.itemsDispensed.value
          : this.itemsDispensed,
      counsellingNotes: data.counsellingNotes.present
          ? data.counsellingNotes.value
          : this.counsellingNotes,
      pharmacistId: data.pharmacistId.present
          ? data.pharmacistId.value
          : this.pharmacistId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DispensingRecord(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('itemsDispensed: $itemsDispensed, ')
          ..write('counsellingNotes: $counsellingNotes, ')
          ..write('pharmacistId: $pharmacistId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    itemsDispensed,
    counsellingNotes,
    pharmacistId,
    createdAt,
    updatedAt,
    isDeleted,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DispensingRecord &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.itemsDispensed == this.itemsDispensed &&
          other.counsellingNotes == this.counsellingNotes &&
          other.pharmacistId == this.pharmacistId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.version == this.version);
}

class DispensingRecordsCompanion extends UpdateCompanion<DispensingRecord> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String?> itemsDispensed;
  final Value<String?> counsellingNotes;
  final Value<String?> pharmacistId;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<bool> isDeleted;
  final Value<int> version;
  final Value<int> rowid;
  const DispensingRecordsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.itemsDispensed = const Value.absent(),
    this.counsellingNotes = const Value.absent(),
    this.pharmacistId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DispensingRecordsCompanion.insert({
    required String id,
    required String patientId,
    this.itemsDispensed = const Value.absent(),
    this.counsellingNotes = const Value.absent(),
    this.pharmacistId = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DispensingRecord> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? itemsDispensed,
    Expression<String>? counsellingNotes,
    Expression<String>? pharmacistId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (itemsDispensed != null) 'items_dispensed': itemsDispensed,
      if (counsellingNotes != null) 'counselling_notes': counsellingNotes,
      if (pharmacistId != null) 'pharmacist_id': pharmacistId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DispensingRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String?>? itemsDispensed,
    Value<String?>? counsellingNotes,
    Value<String?>? pharmacistId,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<bool>? isDeleted,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return DispensingRecordsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      itemsDispensed: itemsDispensed ?? this.itemsDispensed,
      counsellingNotes: counsellingNotes ?? this.counsellingNotes,
      pharmacistId: pharmacistId ?? this.pharmacistId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (itemsDispensed.present) {
      map['items_dispensed'] = Variable<String>(itemsDispensed.value);
    }
    if (counsellingNotes.present) {
      map['counselling_notes'] = Variable<String>(counsellingNotes.value);
    }
    if (pharmacistId.present) {
      map['pharmacist_id'] = Variable<String>(pharmacistId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DispensingRecordsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('itemsDispensed: $itemsDispensed, ')
          ..write('counsellingNotes: $counsellingNotes, ')
          ..write('pharmacistId: $pharmacistId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LabResultsTable extends LabResults
    with TableInfo<$LabResultsTable, LabResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patients (id)',
    ),
  );
  static const VerificationMeta _testNameMeta = const VerificationMeta(
    'testName',
  );
  @override
  late final GeneratedColumn<String> testName = GeneratedColumn<String>(
    'test_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceRangeMeta = const VerificationMeta(
    'referenceRange',
  );
  @override
  late final GeneratedColumn<String> referenceRange = GeneratedColumn<String>(
    'reference_range',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labTechIdMeta = const VerificationMeta(
    'labTechId',
  );
  @override
  late final GeneratedColumn<String> labTechId = GeneratedColumn<String>(
    'lab_tech_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    testName,
    result,
    referenceRange,
    labTechId,
    createdAt,
    updatedAt,
    isDeleted,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lab_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('test_name')) {
      context.handle(
        _testNameMeta,
        testName.isAcceptableOrUnknown(data['test_name']!, _testNameMeta),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    }
    if (data.containsKey('reference_range')) {
      context.handle(
        _referenceRangeMeta,
        referenceRange.isAcceptableOrUnknown(
          data['reference_range']!,
          _referenceRangeMeta,
        ),
      );
    }
    if (data.containsKey('lab_tech_id')) {
      context.handle(
        _labTechIdMeta,
        labTechId.isAcceptableOrUnknown(data['lab_tech_id']!, _labTechIdMeta),
      );
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
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      testName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_name'],
      ),
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      ),
      referenceRange: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_range'],
      ),
      labTechId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab_tech_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $LabResultsTable createAlias(String alias) {
    return $LabResultsTable(attachedDatabase, alias);
  }
}

class LabResult extends DataClass implements Insertable<LabResult> {
  final String id;
  final String patientId;
  final String? testName;
  final String? result;
  final String? referenceRange;
  final String? labTechId;
  final int createdAt;
  final int updatedAt;
  final bool isDeleted;
  final int version;
  const LabResult({
    required this.id,
    required this.patientId,
    this.testName,
    this.result,
    this.referenceRange,
    this.labTechId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || testName != null) {
      map['test_name'] = Variable<String>(testName);
    }
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    if (!nullToAbsent || referenceRange != null) {
      map['reference_range'] = Variable<String>(referenceRange);
    }
    if (!nullToAbsent || labTechId != null) {
      map['lab_tech_id'] = Variable<String>(labTechId);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['version'] = Variable<int>(version);
    return map;
  }

  LabResultsCompanion toCompanion(bool nullToAbsent) {
    return LabResultsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      testName: testName == null && nullToAbsent
          ? const Value.absent()
          : Value(testName),
      result: result == null && nullToAbsent
          ? const Value.absent()
          : Value(result),
      referenceRange: referenceRange == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceRange),
      labTechId: labTechId == null && nullToAbsent
          ? const Value.absent()
          : Value(labTechId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      version: Value(version),
    );
  }

  factory LabResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabResult(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      testName: serializer.fromJson<String?>(json['testName']),
      result: serializer.fromJson<String?>(json['result']),
      referenceRange: serializer.fromJson<String?>(json['referenceRange']),
      labTechId: serializer.fromJson<String?>(json['labTechId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'testName': serializer.toJson<String?>(testName),
      'result': serializer.toJson<String?>(result),
      'referenceRange': serializer.toJson<String?>(referenceRange),
      'labTechId': serializer.toJson<String?>(labTechId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'version': serializer.toJson<int>(version),
    };
  }

  LabResult copyWith({
    String? id,
    String? patientId,
    Value<String?> testName = const Value.absent(),
    Value<String?> result = const Value.absent(),
    Value<String?> referenceRange = const Value.absent(),
    Value<String?> labTechId = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    bool? isDeleted,
    int? version,
  }) => LabResult(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    testName: testName.present ? testName.value : this.testName,
    result: result.present ? result.value : this.result,
    referenceRange: referenceRange.present
        ? referenceRange.value
        : this.referenceRange,
    labTechId: labTechId.present ? labTechId.value : this.labTechId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    version: version ?? this.version,
  );
  LabResult copyWithCompanion(LabResultsCompanion data) {
    return LabResult(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      testName: data.testName.present ? data.testName.value : this.testName,
      result: data.result.present ? data.result.value : this.result,
      referenceRange: data.referenceRange.present
          ? data.referenceRange.value
          : this.referenceRange,
      labTechId: data.labTechId.present ? data.labTechId.value : this.labTechId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabResult(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('testName: $testName, ')
          ..write('result: $result, ')
          ..write('referenceRange: $referenceRange, ')
          ..write('labTechId: $labTechId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    testName,
    result,
    referenceRange,
    labTechId,
    createdAt,
    updatedAt,
    isDeleted,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabResult &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.testName == this.testName &&
          other.result == this.result &&
          other.referenceRange == this.referenceRange &&
          other.labTechId == this.labTechId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.version == this.version);
}

class LabResultsCompanion extends UpdateCompanion<LabResult> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String?> testName;
  final Value<String?> result;
  final Value<String?> referenceRange;
  final Value<String?> labTechId;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<bool> isDeleted;
  final Value<int> version;
  final Value<int> rowid;
  const LabResultsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.testName = const Value.absent(),
    this.result = const Value.absent(),
    this.referenceRange = const Value.absent(),
    this.labTechId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LabResultsCompanion.insert({
    required String id,
    required String patientId,
    this.testName = const Value.absent(),
    this.result = const Value.absent(),
    this.referenceRange = const Value.absent(),
    this.labTechId = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.isDeleted = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LabResult> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? testName,
    Expression<String>? result,
    Expression<String>? referenceRange,
    Expression<String>? labTechId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (testName != null) 'test_name': testName,
      if (result != null) 'result': result,
      if (referenceRange != null) 'reference_range': referenceRange,
      if (labTechId != null) 'lab_tech_id': labTechId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LabResultsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String?>? testName,
    Value<String?>? result,
    Value<String?>? referenceRange,
    Value<String?>? labTechId,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<bool>? isDeleted,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return LabResultsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      testName: testName ?? this.testName,
      result: result ?? this.result,
      referenceRange: referenceRange ?? this.referenceRange,
      labTechId: labTechId ?? this.labTechId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (testName.present) {
      map['test_name'] = Variable<String>(testName.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (referenceRange.present) {
      map['reference_range'] = Variable<String>(referenceRange.value);
    }
    if (labTechId.present) {
      map['lab_tech_id'] = Variable<String>(labTechId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabResultsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('testName: $testName, ')
          ..write('result: $result, ')
          ..write('referenceRange: $referenceRange, ')
          ..write('labTechId: $labTechId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogTable extends AuditLog
    with TableInfo<$AuditLogTable, AuditLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oldValueMeta = const VerificationMeta(
    'oldValue',
  );
  @override
  late final GeneratedColumn<String> oldValue = GeneratedColumn<String>(
    'old_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newValueMeta = const VerificationMeta(
    'newValue',
  );
  @override
  late final GeneratedColumn<String> newValue = GeneratedColumn<String>(
    'new_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changedByMeta = const VerificationMeta(
    'changedBy',
  );
  @override
  late final GeneratedColumn<String> changedBy = GeneratedColumn<String>(
    'changed_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<int> changedAt = GeneratedColumn<int>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetTable,
    recordId,
    fieldName,
    oldValue,
    newValue,
    changedBy,
    changedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('old_value')) {
      context.handle(
        _oldValueMeta,
        oldValue.isAcceptableOrUnknown(data['old_value']!, _oldValueMeta),
      );
    }
    if (data.containsKey('new_value')) {
      context.handle(
        _newValueMeta,
        newValue.isAcceptableOrUnknown(data['new_value']!, _newValueMeta),
      );
    }
    if (data.containsKey('changed_by')) {
      context.handle(
        _changedByMeta,
        changedBy.isAcceptableOrUnknown(data['changed_by']!, _changedByMeta),
      );
    } else if (isInserting) {
      context.missing(_changedByMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      fieldName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_name'],
      )!,
      oldValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}old_value'],
      ),
      newValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_value'],
      ),
      changedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}changed_by'],
      )!,
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}changed_at'],
      )!,
    );
  }

  @override
  $AuditLogTable createAlias(String alias) {
    return $AuditLogTable(attachedDatabase, alias);
  }
}

class AuditLogData extends DataClass implements Insertable<AuditLogData> {
  final String id;
  final String targetTable;
  final String recordId;
  final String fieldName;
  final String? oldValue;
  final String? newValue;
  final String changedBy;
  final int changedAt;
  const AuditLogData({
    required this.id,
    required this.targetTable,
    required this.recordId,
    required this.fieldName,
    this.oldValue,
    this.newValue,
    required this.changedBy,
    required this.changedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['target_table'] = Variable<String>(targetTable);
    map['record_id'] = Variable<String>(recordId);
    map['field_name'] = Variable<String>(fieldName);
    if (!nullToAbsent || oldValue != null) {
      map['old_value'] = Variable<String>(oldValue);
    }
    if (!nullToAbsent || newValue != null) {
      map['new_value'] = Variable<String>(newValue);
    }
    map['changed_by'] = Variable<String>(changedBy);
    map['changed_at'] = Variable<int>(changedAt);
    return map;
  }

  AuditLogCompanion toCompanion(bool nullToAbsent) {
    return AuditLogCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      recordId: Value(recordId),
      fieldName: Value(fieldName),
      oldValue: oldValue == null && nullToAbsent
          ? const Value.absent()
          : Value(oldValue),
      newValue: newValue == null && nullToAbsent
          ? const Value.absent()
          : Value(newValue),
      changedBy: Value(changedBy),
      changedAt: Value(changedAt),
    );
  }

  factory AuditLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogData(
      id: serializer.fromJson<String>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      recordId: serializer.fromJson<String>(json['recordId']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      oldValue: serializer.fromJson<String?>(json['oldValue']),
      newValue: serializer.fromJson<String?>(json['newValue']),
      changedBy: serializer.fromJson<String>(json['changedBy']),
      changedAt: serializer.fromJson<int>(json['changedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'recordId': serializer.toJson<String>(recordId),
      'fieldName': serializer.toJson<String>(fieldName),
      'oldValue': serializer.toJson<String?>(oldValue),
      'newValue': serializer.toJson<String?>(newValue),
      'changedBy': serializer.toJson<String>(changedBy),
      'changedAt': serializer.toJson<int>(changedAt),
    };
  }

  AuditLogData copyWith({
    String? id,
    String? targetTable,
    String? recordId,
    String? fieldName,
    Value<String?> oldValue = const Value.absent(),
    Value<String?> newValue = const Value.absent(),
    String? changedBy,
    int? changedAt,
  }) => AuditLogData(
    id: id ?? this.id,
    targetTable: targetTable ?? this.targetTable,
    recordId: recordId ?? this.recordId,
    fieldName: fieldName ?? this.fieldName,
    oldValue: oldValue.present ? oldValue.value : this.oldValue,
    newValue: newValue.present ? newValue.value : this.newValue,
    changedBy: changedBy ?? this.changedBy,
    changedAt: changedAt ?? this.changedAt,
  );
  AuditLogData copyWithCompanion(AuditLogCompanion data) {
    return AuditLogData(
      id: data.id.present ? data.id.value : this.id,
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      oldValue: data.oldValue.present ? data.oldValue.value : this.oldValue,
      newValue: data.newValue.present ? data.newValue.value : this.newValue,
      changedBy: data.changedBy.present ? data.changedBy.value : this.changedBy,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogData(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('fieldName: $fieldName, ')
          ..write('oldValue: $oldValue, ')
          ..write('newValue: $newValue, ')
          ..write('changedBy: $changedBy, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetTable,
    recordId,
    fieldName,
    oldValue,
    newValue,
    changedBy,
    changedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogData &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.recordId == this.recordId &&
          other.fieldName == this.fieldName &&
          other.oldValue == this.oldValue &&
          other.newValue == this.newValue &&
          other.changedBy == this.changedBy &&
          other.changedAt == this.changedAt);
}

class AuditLogCompanion extends UpdateCompanion<AuditLogData> {
  final Value<String> id;
  final Value<String> targetTable;
  final Value<String> recordId;
  final Value<String> fieldName;
  final Value<String?> oldValue;
  final Value<String?> newValue;
  final Value<String> changedBy;
  final Value<int> changedAt;
  final Value<int> rowid;
  const AuditLogCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.oldValue = const Value.absent(),
    this.newValue = const Value.absent(),
    this.changedBy = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogCompanion.insert({
    required String id,
    required String targetTable,
    required String recordId,
    required String fieldName,
    this.oldValue = const Value.absent(),
    this.newValue = const Value.absent(),
    required String changedBy,
    required int changedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       targetTable = Value(targetTable),
       recordId = Value(recordId),
       fieldName = Value(fieldName),
       changedBy = Value(changedBy),
       changedAt = Value(changedAt);
  static Insertable<AuditLogData> custom({
    Expression<String>? id,
    Expression<String>? targetTable,
    Expression<String>? recordId,
    Expression<String>? fieldName,
    Expression<String>? oldValue,
    Expression<String>? newValue,
    Expression<String>? changedBy,
    Expression<int>? changedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'target_table': targetTable,
      if (recordId != null) 'record_id': recordId,
      if (fieldName != null) 'field_name': fieldName,
      if (oldValue != null) 'old_value': oldValue,
      if (newValue != null) 'new_value': newValue,
      if (changedBy != null) 'changed_by': changedBy,
      if (changedAt != null) 'changed_at': changedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogCompanion copyWith({
    Value<String>? id,
    Value<String>? targetTable,
    Value<String>? recordId,
    Value<String>? fieldName,
    Value<String?>? oldValue,
    Value<String?>? newValue,
    Value<String>? changedBy,
    Value<int>? changedAt,
    Value<int>? rowid,
  }) {
    return AuditLogCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      recordId: recordId ?? this.recordId,
      fieldName: fieldName ?? this.fieldName,
      oldValue: oldValue ?? this.oldValue,
      newValue: newValue ?? this.newValue,
      changedBy: changedBy ?? this.changedBy,
      changedAt: changedAt ?? this.changedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (oldValue.present) {
      map['old_value'] = Variable<String>(oldValue.value);
    }
    if (newValue.present) {
      map['new_value'] = Variable<String>(newValue.value);
    }
    if (changedBy.present) {
      map['changed_by'] = Variable<String>(changedBy.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<int>(changedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('fieldName: $fieldName, ')
          ..write('oldValue: $oldValue, ')
          ..write('newValue: $newValue, ')
          ..write('changedBy: $changedBy, ')
          ..write('changedAt: $changedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTable extends SyncState
    with TableInfo<$SyncStateTable, SyncStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncAtMeta = const VerificationMeta(
    'lastSyncAt',
  );
  @override
  late final GeneratedColumn<int> lastSyncAt = GeneratedColumn<int>(
    'last_sync_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [deviceId, lastSyncAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
        _lastSyncAtMeta,
        lastSyncAt.isAcceptableOrUnknown(
          data['last_sync_at']!,
          _lastSyncAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSyncAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceId};
  @override
  SyncStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateData(
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      lastSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_sync_at'],
      )!,
    );
  }

  @override
  $SyncStateTable createAlias(String alias) {
    return $SyncStateTable(attachedDatabase, alias);
  }
}

class SyncStateData extends DataClass implements Insertable<SyncStateData> {
  final String deviceId;
  final int lastSyncAt;
  const SyncStateData({required this.deviceId, required this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['device_id'] = Variable<String>(deviceId);
    map['last_sync_at'] = Variable<int>(lastSyncAt);
    return map;
  }

  SyncStateCompanion toCompanion(bool nullToAbsent) {
    return SyncStateCompanion(
      deviceId: Value(deviceId),
      lastSyncAt: Value(lastSyncAt),
    );
  }

  factory SyncStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateData(
      deviceId: serializer.fromJson<String>(json['deviceId']),
      lastSyncAt: serializer.fromJson<int>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deviceId': serializer.toJson<String>(deviceId),
      'lastSyncAt': serializer.toJson<int>(lastSyncAt),
    };
  }

  SyncStateData copyWith({String? deviceId, int? lastSyncAt}) => SyncStateData(
    deviceId: deviceId ?? this.deviceId,
    lastSyncAt: lastSyncAt ?? this.lastSyncAt,
  );
  SyncStateData copyWithCompanion(SyncStateCompanion data) {
    return SyncStateData(
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      lastSyncAt: data.lastSyncAt.present
          ? data.lastSyncAt.value
          : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateData(')
          ..write('deviceId: $deviceId, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(deviceId, lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateData &&
          other.deviceId == this.deviceId &&
          other.lastSyncAt == this.lastSyncAt);
}

class SyncStateCompanion extends UpdateCompanion<SyncStateData> {
  final Value<String> deviceId;
  final Value<int> lastSyncAt;
  final Value<int> rowid;
  const SyncStateCompanion({
    this.deviceId = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateCompanion.insert({
    required String deviceId,
    required int lastSyncAt,
    this.rowid = const Value.absent(),
  }) : deviceId = Value(deviceId),
       lastSyncAt = Value(lastSyncAt);
  static Insertable<SyncStateData> custom({
    Expression<String>? deviceId,
    Expression<int>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deviceId != null) 'device_id': deviceId,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateCompanion copyWith({
    Value<String>? deviceId,
    Value<int>? lastSyncAt,
    Value<int>? rowid,
  }) {
    return SyncStateCompanion(
      deviceId: deviceId ?? this.deviceId,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<int>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateCompanion(')
          ..write('deviceId: $deviceId, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $PatientsTable patients = $PatientsTable(this);
  late final $ConsultationsTable consultations = $ConsultationsTable(this);
  late final $DispensingRecordsTable dispensingRecords =
      $DispensingRecordsTable(this);
  late final $LabResultsTable labResults = $LabResultsTable(this);
  late final $AuditLogTable auditLog = $AuditLogTable(this);
  late final $SyncStateTable syncState = $SyncStateTable(this);
  late final PatientDao patientDao = PatientDao(this as AppDatabase);
  late final UserDao userDao = UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    devices,
    sessions,
    patients,
    consultations,
    dispensingRecords,
    labResults,
    auditLog,
    syncState,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String name,
      required String roleValue,
      required String pinHash,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> roleValue,
      Value<String> pinHash,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: $_aliasNameGenerator(db.users.id, db.sessions.userId),
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roleValue => $composableBuilder(
    column: $table.roleValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roleValue => $composableBuilder(
    column: $table.roleValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get roleValue =>
      $composableBuilder(column: $table.roleValue, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool sessionsRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> roleValue = const Value.absent(),
                Value<String> pinHash = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                roleValue: roleValue,
                pinHash: pinHash,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String roleValue,
                required String pinHash,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                roleValue: roleValue,
                pinHash: pinHash,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({sessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sessionsRefs) db.sessions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Session>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._sessionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).sessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool sessionsRefs})
    >;
typedef $$DevicesTableCreateCompanionBuilder =
    DevicesCompanion Function({
      required String id,
      required String friendlyName,
      Value<bool> isHub,
      Value<int?> lastSeenAt,
      Value<int> rowid,
    });
typedef $$DevicesTableUpdateCompanionBuilder =
    DevicesCompanion Function({
      Value<String> id,
      Value<String> friendlyName,
      Value<bool> isHub,
      Value<int?> lastSeenAt,
      Value<int> rowid,
    });

class $$DevicesTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
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

  ColumnFilters<String> get friendlyName => $composableBuilder(
    column: $table.friendlyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHub => $composableBuilder(
    column: $table.isHub,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
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

  ColumnOrderings<String> get friendlyName => $composableBuilder(
    column: $table.friendlyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHub => $composableBuilder(
    column: $table.isHub,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get friendlyName => $composableBuilder(
    column: $table.friendlyName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isHub =>
      $composableBuilder(column: $table.isHub, builder: (column) => column);

  GeneratedColumn<int> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );
}

class $$DevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DevicesTable,
          Device,
          $$DevicesTableFilterComposer,
          $$DevicesTableOrderingComposer,
          $$DevicesTableAnnotationComposer,
          $$DevicesTableCreateCompanionBuilder,
          $$DevicesTableUpdateCompanionBuilder,
          (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
          Device,
          PrefetchHooks Function()
        > {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> friendlyName = const Value.absent(),
                Value<bool> isHub = const Value.absent(),
                Value<int?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion(
                id: id,
                friendlyName: friendlyName,
                isHub: isHub,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String friendlyName,
                Value<bool> isHub = const Value.absent(),
                Value<int?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion.insert(
                id: id,
                friendlyName: friendlyName,
                isHub: isHub,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DevicesTable,
      Device,
      $$DevicesTableFilterComposer,
      $$DevicesTableOrderingComposer,
      $$DevicesTableAnnotationComposer,
      $$DevicesTableCreateCompanionBuilder,
      $$DevicesTableUpdateCompanionBuilder,
      (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
      Device,
      PrefetchHooks Function()
    >;
typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      required String id,
      required String userId,
      required String deviceId,
      required String token,
      required int createdAt,
      required int expiresAt,
      Value<int> rowid,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> deviceId,
      Value<String> token,
      Value<int> createdAt,
      Value<int> expiresAt,
      Value<int> rowid,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.sessions.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
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

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
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

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({bool userId})
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> token = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                userId: userId,
                deviceId: deviceId,
                token: token,
                createdAt: createdAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String deviceId,
                required String token,
                required int createdAt,
                required int expiresAt,
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                userId: userId,
                deviceId: deviceId,
                token: token,
                createdAt: createdAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$SessionsTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$SessionsTableReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({bool userId})
    >;
typedef $$PatientsTableCreateCompanionBuilder =
    PatientsCompanion Function({
      required String id,
      required String sessionDate,
      required String fullName,
      Value<String?> dateOfBirth,
      Value<String?> sex,
      Value<String?> phone,
      Value<String?> community,
      Value<String?> chiefComplaint,
      Value<String?> bloodPressure,
      Value<double?> temperatureCelsius,
      Value<double?> weightKg,
      Value<double?> heightCm,
      Value<int?> pulsePerMin,
      Value<double?> spo2Percent,
      Value<String?> intakeBy,
      Value<int?> intakeAt,
      Value<String?> updatedBy,
      required int updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });
typedef $$PatientsTableUpdateCompanionBuilder =
    PatientsCompanion Function({
      Value<String> id,
      Value<String> sessionDate,
      Value<String> fullName,
      Value<String?> dateOfBirth,
      Value<String?> sex,
      Value<String?> phone,
      Value<String?> community,
      Value<String?> chiefComplaint,
      Value<String?> bloodPressure,
      Value<double?> temperatureCelsius,
      Value<double?> weightKg,
      Value<double?> heightCm,
      Value<int?> pulsePerMin,
      Value<double?> spo2Percent,
      Value<String?> intakeBy,
      Value<int?> intakeAt,
      Value<String?> updatedBy,
      Value<int> updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });

final class $$PatientsTableReferences
    extends BaseReferences<_$AppDatabase, $PatientsTable, Patient> {
  $$PatientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ConsultationsTable, List<Consultation>>
  _consultationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.consultations,
    aliasName: $_aliasNameGenerator(db.patients.id, db.consultations.patientId),
  );

  $$ConsultationsTableProcessedTableManager get consultationsRefs {
    final manager = $$ConsultationsTableTableManager(
      $_db,
      $_db.consultations,
    ).filter((f) => f.patientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_consultationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DispensingRecordsTable, List<DispensingRecord>>
  _dispensingRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.dispensingRecords,
        aliasName: $_aliasNameGenerator(
          db.patients.id,
          db.dispensingRecords.patientId,
        ),
      );

  $$DispensingRecordsTableProcessedTableManager get dispensingRecordsRefs {
    final manager = $$DispensingRecordsTableTableManager(
      $_db,
      $_db.dispensingRecords,
    ).filter((f) => f.patientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _dispensingRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LabResultsTable, List<LabResult>>
  _labResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.labResults,
    aliasName: $_aliasNameGenerator(db.patients.id, db.labResults.patientId),
  );

  $$LabResultsTableProcessedTableManager get labResultsRefs {
    final manager = $$LabResultsTableTableManager(
      $_db,
      $_db.labResults,
    ).filter((f) => f.patientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_labResultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PatientsTableFilterComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableFilterComposer({
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

  ColumnFilters<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chiefComplaint => $composableBuilder(
    column: $table.chiefComplaint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodPressure => $composableBuilder(
    column: $table.bloodPressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperatureCelsius => $composableBuilder(
    column: $table.temperatureCelsius,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pulsePerMin => $composableBuilder(
    column: $table.pulsePerMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get spo2Percent => $composableBuilder(
    column: $table.spo2Percent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intakeBy => $composableBuilder(
    column: $table.intakeBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intakeAt => $composableBuilder(
    column: $table.intakeAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> consultationsRefs(
    Expression<bool> Function($$ConsultationsTableFilterComposer f) f,
  ) {
    final $$ConsultationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consultations,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsultationsTableFilterComposer(
            $db: $db,
            $table: $db.consultations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dispensingRecordsRefs(
    Expression<bool> Function($$DispensingRecordsTableFilterComposer f) f,
  ) {
    final $$DispensingRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dispensingRecords,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DispensingRecordsTableFilterComposer(
            $db: $db,
            $table: $db.dispensingRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> labResultsRefs(
    Expression<bool> Function($$LabResultsTableFilterComposer f) f,
  ) {
    final $$LabResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.labResults,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabResultsTableFilterComposer(
            $db: $db,
            $table: $db.labResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PatientsTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableOrderingComposer({
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

  ColumnOrderings<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chiefComplaint => $composableBuilder(
    column: $table.chiefComplaint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodPressure => $composableBuilder(
    column: $table.bloodPressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperatureCelsius => $composableBuilder(
    column: $table.temperatureCelsius,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pulsePerMin => $composableBuilder(
    column: $table.pulsePerMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get spo2Percent => $composableBuilder(
    column: $table.spo2Percent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intakeBy => $composableBuilder(
    column: $table.intakeBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intakeAt => $composableBuilder(
    column: $table.intakeAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PatientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get community =>
      $composableBuilder(column: $table.community, builder: (column) => column);

  GeneratedColumn<String> get chiefComplaint => $composableBuilder(
    column: $table.chiefComplaint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bloodPressure => $composableBuilder(
    column: $table.bloodPressure,
    builder: (column) => column,
  );

  GeneratedColumn<double> get temperatureCelsius => $composableBuilder(
    column: $table.temperatureCelsius,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<int> get pulsePerMin => $composableBuilder(
    column: $table.pulsePerMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get spo2Percent => $composableBuilder(
    column: $table.spo2Percent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get intakeBy =>
      $composableBuilder(column: $table.intakeBy, builder: (column) => column);

  GeneratedColumn<int> get intakeAt =>
      $composableBuilder(column: $table.intakeAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  Expression<T> consultationsRefs<T extends Object>(
    Expression<T> Function($$ConsultationsTableAnnotationComposer a) f,
  ) {
    final $$ConsultationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consultations,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsultationsTableAnnotationComposer(
            $db: $db,
            $table: $db.consultations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dispensingRecordsRefs<T extends Object>(
    Expression<T> Function($$DispensingRecordsTableAnnotationComposer a) f,
  ) {
    final $$DispensingRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.dispensingRecords,
          getReferencedColumn: (t) => t.patientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DispensingRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.dispensingRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> labResultsRefs<T extends Object>(
    Expression<T> Function($$LabResultsTableAnnotationComposer a) f,
  ) {
    final $$LabResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.labResults,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.labResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PatientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatientsTable,
          Patient,
          $$PatientsTableFilterComposer,
          $$PatientsTableOrderingComposer,
          $$PatientsTableAnnotationComposer,
          $$PatientsTableCreateCompanionBuilder,
          $$PatientsTableUpdateCompanionBuilder,
          (Patient, $$PatientsTableReferences),
          Patient,
          PrefetchHooks Function({
            bool consultationsRefs,
            bool dispensingRecordsRefs,
            bool labResultsRefs,
          })
        > {
  $$PatientsTableTableManager(_$AppDatabase db, $PatientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionDate = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> sex = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> community = const Value.absent(),
                Value<String?> chiefComplaint = const Value.absent(),
                Value<String?> bloodPressure = const Value.absent(),
                Value<double?> temperatureCelsius = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<int?> pulsePerMin = const Value.absent(),
                Value<double?> spo2Percent = const Value.absent(),
                Value<String?> intakeBy = const Value.absent(),
                Value<int?> intakeAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PatientsCompanion(
                id: id,
                sessionDate: sessionDate,
                fullName: fullName,
                dateOfBirth: dateOfBirth,
                sex: sex,
                phone: phone,
                community: community,
                chiefComplaint: chiefComplaint,
                bloodPressure: bloodPressure,
                temperatureCelsius: temperatureCelsius,
                weightKg: weightKg,
                heightCm: heightCm,
                pulsePerMin: pulsePerMin,
                spo2Percent: spo2Percent,
                intakeBy: intakeBy,
                intakeAt: intakeAt,
                updatedBy: updatedBy,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionDate,
                required String fullName,
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> sex = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> community = const Value.absent(),
                Value<String?> chiefComplaint = const Value.absent(),
                Value<String?> bloodPressure = const Value.absent(),
                Value<double?> temperatureCelsius = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<int?> pulsePerMin = const Value.absent(),
                Value<double?> spo2Percent = const Value.absent(),
                Value<String?> intakeBy = const Value.absent(),
                Value<int?> intakeAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                required int updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PatientsCompanion.insert(
                id: id,
                sessionDate: sessionDate,
                fullName: fullName,
                dateOfBirth: dateOfBirth,
                sex: sex,
                phone: phone,
                community: community,
                chiefComplaint: chiefComplaint,
                bloodPressure: bloodPressure,
                temperatureCelsius: temperatureCelsius,
                weightKg: weightKg,
                heightCm: heightCm,
                pulsePerMin: pulsePerMin,
                spo2Percent: spo2Percent,
                intakeBy: intakeBy,
                intakeAt: intakeAt,
                updatedBy: updatedBy,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PatientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                consultationsRefs = false,
                dispensingRecordsRefs = false,
                labResultsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (consultationsRefs) db.consultations,
                    if (dispensingRecordsRefs) db.dispensingRecords,
                    if (labResultsRefs) db.labResults,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (consultationsRefs)
                        await $_getPrefetchedData<
                          Patient,
                          $PatientsTable,
                          Consultation
                        >(
                          currentTable: table,
                          referencedTable: $$PatientsTableReferences
                              ._consultationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientsTableReferences(
                                db,
                                table,
                                p0,
                              ).consultationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dispensingRecordsRefs)
                        await $_getPrefetchedData<
                          Patient,
                          $PatientsTable,
                          DispensingRecord
                        >(
                          currentTable: table,
                          referencedTable: $$PatientsTableReferences
                              ._dispensingRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientsTableReferences(
                                db,
                                table,
                                p0,
                              ).dispensingRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (labResultsRefs)
                        await $_getPrefetchedData<
                          Patient,
                          $PatientsTable,
                          LabResult
                        >(
                          currentTable: table,
                          referencedTable: $$PatientsTableReferences
                              ._labResultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientsTableReferences(
                                db,
                                table,
                                p0,
                              ).labResultsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PatientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatientsTable,
      Patient,
      $$PatientsTableFilterComposer,
      $$PatientsTableOrderingComposer,
      $$PatientsTableAnnotationComposer,
      $$PatientsTableCreateCompanionBuilder,
      $$PatientsTableUpdateCompanionBuilder,
      (Patient, $$PatientsTableReferences),
      Patient,
      PrefetchHooks Function({
        bool consultationsRefs,
        bool dispensingRecordsRefs,
        bool labResultsRefs,
      })
    >;
typedef $$ConsultationsTableCreateCompanionBuilder =
    ConsultationsCompanion Function({
      required String id,
      required String patientId,
      Value<String?> diagnosis,
      Value<String?> clinicalNotes,
      Value<String?> prescription,
      Value<String?> followUpDate,
      Value<String?> doctorId,
      required int createdAt,
      required int updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });
typedef $$ConsultationsTableUpdateCompanionBuilder =
    ConsultationsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String?> diagnosis,
      Value<String?> clinicalNotes,
      Value<String?> prescription,
      Value<String?> followUpDate,
      Value<String?> doctorId,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });

final class $$ConsultationsTableReferences
    extends BaseReferences<_$AppDatabase, $ConsultationsTable, Consultation> {
  $$ConsultationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
        $_aliasNameGenerator(db.consultations.patientId, db.patients.id),
      );

  $$PatientsTableProcessedTableManager get patientId {
    final $_column = $_itemColumn<String>('patient_id')!;

    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConsultationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConsultationsTable> {
  $$ConsultationsTableFilterComposer({
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

  ColumnFilters<String> get diagnosis => $composableBuilder(
    column: $table.diagnosis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicalNotes => $composableBuilder(
    column: $table.clinicalNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prescription => $composableBuilder(
    column: $table.prescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsultationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsultationsTable> {
  $$ConsultationsTableOrderingComposer({
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

  ColumnOrderings<String> get diagnosis => $composableBuilder(
    column: $table.diagnosis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicalNotes => $composableBuilder(
    column: $table.clinicalNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prescription => $composableBuilder(
    column: $table.prescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableOrderingComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsultationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsultationsTable> {
  $$ConsultationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get diagnosis =>
      $composableBuilder(column: $table.diagnosis, builder: (column) => column);

  GeneratedColumn<String> get clinicalNotes => $composableBuilder(
    column: $table.clinicalNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prescription => $composableBuilder(
    column: $table.prescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsultationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsultationsTable,
          Consultation,
          $$ConsultationsTableFilterComposer,
          $$ConsultationsTableOrderingComposer,
          $$ConsultationsTableAnnotationComposer,
          $$ConsultationsTableCreateCompanionBuilder,
          $$ConsultationsTableUpdateCompanionBuilder,
          (Consultation, $$ConsultationsTableReferences),
          Consultation,
          PrefetchHooks Function({bool patientId})
        > {
  $$ConsultationsTableTableManager(_$AppDatabase db, $ConsultationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsultationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsultationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsultationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String?> diagnosis = const Value.absent(),
                Value<String?> clinicalNotes = const Value.absent(),
                Value<String?> prescription = const Value.absent(),
                Value<String?> followUpDate = const Value.absent(),
                Value<String?> doctorId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConsultationsCompanion(
                id: id,
                patientId: patientId,
                diagnosis: diagnosis,
                clinicalNotes: clinicalNotes,
                prescription: prescription,
                followUpDate: followUpDate,
                doctorId: doctorId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<String?> diagnosis = const Value.absent(),
                Value<String?> clinicalNotes = const Value.absent(),
                Value<String?> prescription = const Value.absent(),
                Value<String?> followUpDate = const Value.absent(),
                Value<String?> doctorId = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConsultationsCompanion.insert(
                id: id,
                patientId: patientId,
                diagnosis: diagnosis,
                clinicalNotes: clinicalNotes,
                prescription: prescription,
                followUpDate: followUpDate,
                doctorId: doctorId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConsultationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (patientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.patientId,
                                referencedTable: $$ConsultationsTableReferences
                                    ._patientIdTable(db),
                                referencedColumn: $$ConsultationsTableReferences
                                    ._patientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConsultationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsultationsTable,
      Consultation,
      $$ConsultationsTableFilterComposer,
      $$ConsultationsTableOrderingComposer,
      $$ConsultationsTableAnnotationComposer,
      $$ConsultationsTableCreateCompanionBuilder,
      $$ConsultationsTableUpdateCompanionBuilder,
      (Consultation, $$ConsultationsTableReferences),
      Consultation,
      PrefetchHooks Function({bool patientId})
    >;
typedef $$DispensingRecordsTableCreateCompanionBuilder =
    DispensingRecordsCompanion Function({
      required String id,
      required String patientId,
      Value<String?> itemsDispensed,
      Value<String?> counsellingNotes,
      Value<String?> pharmacistId,
      required int createdAt,
      required int updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });
typedef $$DispensingRecordsTableUpdateCompanionBuilder =
    DispensingRecordsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String?> itemsDispensed,
      Value<String?> counsellingNotes,
      Value<String?> pharmacistId,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });

final class $$DispensingRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DispensingRecordsTable,
          DispensingRecord
        > {
  $$DispensingRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
        $_aliasNameGenerator(db.dispensingRecords.patientId, db.patients.id),
      );

  $$PatientsTableProcessedTableManager get patientId {
    final $_column = $_itemColumn<String>('patient_id')!;

    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DispensingRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DispensingRecordsTable> {
  $$DispensingRecordsTableFilterComposer({
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

  ColumnFilters<String> get itemsDispensed => $composableBuilder(
    column: $table.itemsDispensed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get counsellingNotes => $composableBuilder(
    column: $table.counsellingNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pharmacistId => $composableBuilder(
    column: $table.pharmacistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DispensingRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DispensingRecordsTable> {
  $$DispensingRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get itemsDispensed => $composableBuilder(
    column: $table.itemsDispensed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get counsellingNotes => $composableBuilder(
    column: $table.counsellingNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pharmacistId => $composableBuilder(
    column: $table.pharmacistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableOrderingComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DispensingRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DispensingRecordsTable> {
  $$DispensingRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemsDispensed => $composableBuilder(
    column: $table.itemsDispensed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get counsellingNotes => $composableBuilder(
    column: $table.counsellingNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pharmacistId => $composableBuilder(
    column: $table.pharmacistId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DispensingRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DispensingRecordsTable,
          DispensingRecord,
          $$DispensingRecordsTableFilterComposer,
          $$DispensingRecordsTableOrderingComposer,
          $$DispensingRecordsTableAnnotationComposer,
          $$DispensingRecordsTableCreateCompanionBuilder,
          $$DispensingRecordsTableUpdateCompanionBuilder,
          (DispensingRecord, $$DispensingRecordsTableReferences),
          DispensingRecord,
          PrefetchHooks Function({bool patientId})
        > {
  $$DispensingRecordsTableTableManager(
    _$AppDatabase db,
    $DispensingRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DispensingRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DispensingRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DispensingRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String?> itemsDispensed = const Value.absent(),
                Value<String?> counsellingNotes = const Value.absent(),
                Value<String?> pharmacistId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DispensingRecordsCompanion(
                id: id,
                patientId: patientId,
                itemsDispensed: itemsDispensed,
                counsellingNotes: counsellingNotes,
                pharmacistId: pharmacistId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<String?> itemsDispensed = const Value.absent(),
                Value<String?> counsellingNotes = const Value.absent(),
                Value<String?> pharmacistId = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DispensingRecordsCompanion.insert(
                id: id,
                patientId: patientId,
                itemsDispensed: itemsDispensed,
                counsellingNotes: counsellingNotes,
                pharmacistId: pharmacistId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DispensingRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (patientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.patientId,
                                referencedTable:
                                    $$DispensingRecordsTableReferences
                                        ._patientIdTable(db),
                                referencedColumn:
                                    $$DispensingRecordsTableReferences
                                        ._patientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DispensingRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DispensingRecordsTable,
      DispensingRecord,
      $$DispensingRecordsTableFilterComposer,
      $$DispensingRecordsTableOrderingComposer,
      $$DispensingRecordsTableAnnotationComposer,
      $$DispensingRecordsTableCreateCompanionBuilder,
      $$DispensingRecordsTableUpdateCompanionBuilder,
      (DispensingRecord, $$DispensingRecordsTableReferences),
      DispensingRecord,
      PrefetchHooks Function({bool patientId})
    >;
typedef $$LabResultsTableCreateCompanionBuilder =
    LabResultsCompanion Function({
      required String id,
      required String patientId,
      Value<String?> testName,
      Value<String?> result,
      Value<String?> referenceRange,
      Value<String?> labTechId,
      required int createdAt,
      required int updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });
typedef $$LabResultsTableUpdateCompanionBuilder =
    LabResultsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String?> testName,
      Value<String?> result,
      Value<String?> referenceRange,
      Value<String?> labTechId,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<bool> isDeleted,
      Value<int> version,
      Value<int> rowid,
    });

final class $$LabResultsTableReferences
    extends BaseReferences<_$AppDatabase, $LabResultsTable, LabResult> {
  $$LabResultsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
        $_aliasNameGenerator(db.labResults.patientId, db.patients.id),
      );

  $$PatientsTableProcessedTableManager get patientId {
    final $_column = $_itemColumn<String>('patient_id')!;

    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LabResultsTableFilterComposer
    extends Composer<_$AppDatabase, $LabResultsTable> {
  $$LabResultsTableFilterComposer({
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

  ColumnFilters<String> get testName => $composableBuilder(
    column: $table.testName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceRange => $composableBuilder(
    column: $table.referenceRange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labTechId => $composableBuilder(
    column: $table.labTechId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LabResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $LabResultsTable> {
  $$LabResultsTableOrderingComposer({
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

  ColumnOrderings<String> get testName => $composableBuilder(
    column: $table.testName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceRange => $composableBuilder(
    column: $table.referenceRange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labTechId => $composableBuilder(
    column: $table.labTechId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableOrderingComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LabResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LabResultsTable> {
  $$LabResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get testName =>
      $composableBuilder(column: $table.testName, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get referenceRange => $composableBuilder(
    column: $table.referenceRange,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labTechId =>
      $composableBuilder(column: $table.labTechId, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LabResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LabResultsTable,
          LabResult,
          $$LabResultsTableFilterComposer,
          $$LabResultsTableOrderingComposer,
          $$LabResultsTableAnnotationComposer,
          $$LabResultsTableCreateCompanionBuilder,
          $$LabResultsTableUpdateCompanionBuilder,
          (LabResult, $$LabResultsTableReferences),
          LabResult,
          PrefetchHooks Function({bool patientId})
        > {
  $$LabResultsTableTableManager(_$AppDatabase db, $LabResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String?> testName = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<String?> referenceRange = const Value.absent(),
                Value<String?> labTechId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabResultsCompanion(
                id: id,
                patientId: patientId,
                testName: testName,
                result: result,
                referenceRange: referenceRange,
                labTechId: labTechId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<String?> testName = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<String?> referenceRange = const Value.absent(),
                Value<String?> labTechId = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabResultsCompanion.insert(
                id: id,
                patientId: patientId,
                testName: testName,
                result: result,
                referenceRange: referenceRange,
                labTechId: labTechId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LabResultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (patientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.patientId,
                                referencedTable: $$LabResultsTableReferences
                                    ._patientIdTable(db),
                                referencedColumn: $$LabResultsTableReferences
                                    ._patientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LabResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LabResultsTable,
      LabResult,
      $$LabResultsTableFilterComposer,
      $$LabResultsTableOrderingComposer,
      $$LabResultsTableAnnotationComposer,
      $$LabResultsTableCreateCompanionBuilder,
      $$LabResultsTableUpdateCompanionBuilder,
      (LabResult, $$LabResultsTableReferences),
      LabResult,
      PrefetchHooks Function({bool patientId})
    >;
typedef $$AuditLogTableCreateCompanionBuilder =
    AuditLogCompanion Function({
      required String id,
      required String targetTable,
      required String recordId,
      required String fieldName,
      Value<String?> oldValue,
      Value<String?> newValue,
      required String changedBy,
      required int changedAt,
      Value<int> rowid,
    });
typedef $$AuditLogTableUpdateCompanionBuilder =
    AuditLogCompanion Function({
      Value<String> id,
      Value<String> targetTable,
      Value<String> recordId,
      Value<String> fieldName,
      Value<String?> oldValue,
      Value<String?> newValue,
      Value<String> changedBy,
      Value<int> changedAt,
      Value<int> rowid,
    });

class $$AuditLogTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableFilterComposer({
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

  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oldValue => $composableBuilder(
    column: $table.oldValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newValue => $composableBuilder(
    column: $table.newValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changedBy => $composableBuilder(
    column: $table.changedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableOrderingComposer({
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

  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldValue => $composableBuilder(
    column: $table.oldValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newValue => $composableBuilder(
    column: $table.newValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changedBy => $composableBuilder(
    column: $table.changedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get oldValue =>
      $composableBuilder(column: $table.oldValue, builder: (column) => column);

  GeneratedColumn<String> get newValue =>
      $composableBuilder(column: $table.newValue, builder: (column) => column);

  GeneratedColumn<String> get changedBy =>
      $composableBuilder(column: $table.changedBy, builder: (column) => column);

  GeneratedColumn<int> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);
}

class $$AuditLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogTable,
          AuditLogData,
          $$AuditLogTableFilterComposer,
          $$AuditLogTableOrderingComposer,
          $$AuditLogTableAnnotationComposer,
          $$AuditLogTableCreateCompanionBuilder,
          $$AuditLogTableUpdateCompanionBuilder,
          (
            AuditLogData,
            BaseReferences<_$AppDatabase, $AuditLogTable, AuditLogData>,
          ),
          AuditLogData,
          PrefetchHooks Function()
        > {
  $$AuditLogTableTableManager(_$AppDatabase db, $AuditLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> targetTable = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<String?> oldValue = const Value.absent(),
                Value<String?> newValue = const Value.absent(),
                Value<String> changedBy = const Value.absent(),
                Value<int> changedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogCompanion(
                id: id,
                targetTable: targetTable,
                recordId: recordId,
                fieldName: fieldName,
                oldValue: oldValue,
                newValue: newValue,
                changedBy: changedBy,
                changedAt: changedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String targetTable,
                required String recordId,
                required String fieldName,
                Value<String?> oldValue = const Value.absent(),
                Value<String?> newValue = const Value.absent(),
                required String changedBy,
                required int changedAt,
                Value<int> rowid = const Value.absent(),
              }) => AuditLogCompanion.insert(
                id: id,
                targetTable: targetTable,
                recordId: recordId,
                fieldName: fieldName,
                oldValue: oldValue,
                newValue: newValue,
                changedBy: changedBy,
                changedAt: changedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogTable,
      AuditLogData,
      $$AuditLogTableFilterComposer,
      $$AuditLogTableOrderingComposer,
      $$AuditLogTableAnnotationComposer,
      $$AuditLogTableCreateCompanionBuilder,
      $$AuditLogTableUpdateCompanionBuilder,
      (
        AuditLogData,
        BaseReferences<_$AppDatabase, $AuditLogTable, AuditLogData>,
      ),
      AuditLogData,
      PrefetchHooks Function()
    >;
typedef $$SyncStateTableCreateCompanionBuilder =
    SyncStateCompanion Function({
      required String deviceId,
      required int lastSyncAt,
      Value<int> rowid,
    });
typedef $$SyncStateTableUpdateCompanionBuilder =
    SyncStateCompanion Function({
      Value<String> deviceId,
      Value<int> lastSyncAt,
      Value<int> rowid,
    });

class $$SyncStateTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStateTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => column,
  );
}

class $$SyncStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStateTable,
          SyncStateData,
          $$SyncStateTableFilterComposer,
          $$SyncStateTableOrderingComposer,
          $$SyncStateTableAnnotationComposer,
          $$SyncStateTableCreateCompanionBuilder,
          $$SyncStateTableUpdateCompanionBuilder,
          (
            SyncStateData,
            BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateData>,
          ),
          SyncStateData,
          PrefetchHooks Function()
        > {
  $$SyncStateTableTableManager(_$AppDatabase db, $SyncStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> deviceId = const Value.absent(),
                Value<int> lastSyncAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion(
                deviceId: deviceId,
                lastSyncAt: lastSyncAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String deviceId,
                required int lastSyncAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion.insert(
                deviceId: deviceId,
                lastSyncAt: lastSyncAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStateTable,
      SyncStateData,
      $$SyncStateTableFilterComposer,
      $$SyncStateTableOrderingComposer,
      $$SyncStateTableAnnotationComposer,
      $$SyncStateTableCreateCompanionBuilder,
      $$SyncStateTableUpdateCompanionBuilder,
      (
        SyncStateData,
        BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateData>,
      ),
      SyncStateData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
  $$ConsultationsTableTableManager get consultations =>
      $$ConsultationsTableTableManager(_db, _db.consultations);
  $$DispensingRecordsTableTableManager get dispensingRecords =>
      $$DispensingRecordsTableTableManager(_db, _db.dispensingRecords);
  $$LabResultsTableTableManager get labResults =>
      $$LabResultsTableTableManager(_db, _db.labResults);
  $$AuditLogTableTableManager get auditLog =>
      $$AuditLogTableTableManager(_db, _db.auditLog);
  $$SyncStateTableTableManager get syncState =>
      $$SyncStateTableTableManager(_db, _db.syncState);
}
