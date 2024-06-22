// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// NectarOrmGenerator
// **************************************************************************

class UserEntity extends _UserEntity implements Model {
  UserEntity();

  Map<String, dynamic> toJson() => customToJson();

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity()
    ..id = json["id"]
    ..projectId = json["projectId"]
    ..phone = json["phone"]
    ..email = json["email"]
    ..password = json["password"]
    ..name = json["name"]
    ..lastName = json["lastName"]
    ..isArchived = json["isArchived"]
    ..isBlocked = json["isBlocked"]
    ..role = RoleEntity.fromJson(json["role"])
    ..createdAt = DateTime.tryParse(json["createdAt"]) ??
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: false);

  _valueForList(e) {
    if (e is String ||
        e is num ||
        e is bool ||
        e is int ||
        e is double ||
        e is Enum ||
        e is Map) {
      return e;
    }
    if (e is List || e is Set) {
      return _valueForList(e);
    }
    return e.toJson();
  }

  @override
  List<String> get columns => [
        "id",
        "project_id",
        "phone",
        "email",
        "password",
        "name",
        "last_name",
        "is_archived",
        "is_blocked",
        "role_id",
        "created_at"
      ];

  @override
  String get tableName => "users";

  @override
  void fromRow(Map result) {
    if (result.containsKey('users')) {
      id = result['users']['id'];
    } else {
      id = result['id'];
    }

    if (result.containsKey('users')) {
      projectId = result['users']['project_id'];
    } else {
      projectId = result['project_id'];
    }

    if (result.containsKey('users')) {
      phone = result['users']['phone'];
    } else {
      phone = result['phone'];
    }

    if (result.containsKey('users')) {
      email = result['users']['email'];
    } else {
      email = result['email'];
    }

    if (result.containsKey('users')) {
      password = result['users']['password'];
    } else {
      password = result['password'];
    }

    if (result.containsKey('users')) {
      name = result['users']['name'];
    } else {
      name = result['name'];
    }

    if (result.containsKey('users')) {
      lastName = result['users']['last_name'];
    } else {
      lastName = result['last_name'];
    }

    if (result.containsKey('users')) {
      final wisArchived = result['users']['is_archived'];
      isArchived = (wisArchived == 1) ? true : false;
    } else {
      final wisArchived = result['is_archived'];
      isArchived = (wisArchived == 1) ? true : false;
    }

    if (result.containsKey('users')) {
      final wisBlocked = result['users']['is_blocked'];
      isBlocked = (wisBlocked == 1) ? true : false;
    } else {
      final wisBlocked = result['is_blocked'];
      isBlocked = (wisBlocked == 1) ? true : false;
    }

    final l_role = (result["roles"] as Map<dynamic, dynamic>?);
    role = (l_role == null || l_role.isNotEmpty != true)
        ? RoleEntity()
        : (RoleEntity()..fromRow(l_role.values.first));

    if (result.containsKey('users')) {
      final wcreatedAt = result['users']['created_at'];
      createdAt = DateTime.parse(wcreatedAt);
    } else {
      final wcreatedAt = result['created_at'];
      createdAt = DateTime.parse(wcreatedAt);
    }
  }

  @override
  String get primaryKeyName => "id";

  static Future<ResultFormat> rawQuery(
    String sql, {
    Map<String, dynamic> values = const {},
    List<JoinModel> joins = const [],
    required String tableName,
  }) =>
      getIt.get<Db>().query(
            sql,
            values: values,
            joins: joins,
            forTable: tableName,
          );

  Future<int> delete() =>
      getIt.get<Db>().delete(table: tableName, where: {primaryKeyName: id});

  static UserEntityMigration migration() => UserEntityMigration("users");

  static UserEntityQuery query() => UserEntityQuery();

  Future<UserEntity?> save() async =>
      await UserEntityInsertClause(this, () => UserEntity()).insert();
}

class UserEntityQuery extends Query<UserEntity> {
  UserEntityQuery() : super("users", "id");

  @override
  UserEntity instanceOfT() => UserEntity();

  List<String> get _defaultTableFields => [
        "users.id as users\$id",
        "users.project_id as users\$project_id",
        "users.phone as users\$phone",
        "users.email as users\$email",
        "users.password as users\$password",
        "users.name as users\$name",
        "users.last_name as users\$last_name",
        "users.is_archived as users\$is_archived",
        "users.is_blocked as users\$is_blocked",
        "users.created_at as users\$created_at"
      ];

  @override
  UserEntitySelectClause select({
    List<String> fields = const [],
  }) {
    model.fields = (fields.isEmpty) ? _defaultTableFields : fields;
    model.joins = [
      JoinModel(
        tableName: 'users',
        mappedBy: 'role_id',
        foreignTableName: 'roles',
        foreignKey: 'key',
        fields: [
          JoinField(name: 'key', mappedAs: 'roles\$key'),
          JoinField(name: 'name', mappedAs: 'roles\$name')
        ],
      )
    ];
    return UserEntitySelectClause(model, instanceOfT);
  }
}

class UserEntitySelectClause extends SelectClause<UserEntity> {
  UserEntitySelectClause(super.model, super.instanceOfT);

  @override
  UserEntityWhereClause where() => UserEntityWhereClause(model, instanceOfT);

  @override
  UserEntitySelectClause join(JoinModel join) {
    model.joins.add(join);
    return this;
  }
}

class UserEntityWhereClause extends WhereClause<UserEntity> {
  UserEntityWhereClause(super.model, super.instanceOfT);

  UserEntityWhereClause id(int? value, {operator = "=", condition = "AND"}) {
    model.where["users.id"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause projectId(String? value,
      {operator = "=", condition = "AND"}) {
    model.where["users.project_id"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause phone(String value,
      {operator = "=", condition = "AND"}) {
    model.where["users.phone"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause email(String? value,
      {operator = "=", condition = "AND"}) {
    model.where["users.email"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause password(String value,
      {operator = "=", condition = "AND"}) {
    model.where["users.password"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause name(String value,
      {operator = "=", condition = "AND"}) {
    model.where["users.name"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause lastName(String value,
      {operator = "=", condition = "AND"}) {
    model.where["users.last_name"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause isArchived(bool value,
      {operator = "=", condition = "AND"}) {
    model.where["users.is_archived"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause isBlocked(bool value,
      {operator = "=", condition = "AND"}) {
    model.where["users.is_blocked"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause roleentityKey(String value,
      {operator = "=", condition = "AND"}) {
    model.where["users.role_id"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause createdAt(DateTime value,
      {operator = "=", condition = "AND"}) {
    model.where["users.created_at"] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause customField(String key, value,
      {operator = "=", condition = "AND"}) {
    model.where[key] = [operator, value, condition];
    return this;
  }

  UserEntityWhereClause customWhere(String where) {
    model.where["_SQL"] = where;
    return this;
  }
}

class UserEntityInsertClause extends InsertClause<UserEntity> {
  UserEntityInsertClause(super.model, super.instanceOfT);

  @override
  Future<UserEntity?> selectOne(String primaryKeyName, dynamic value) async =>
      (await UserEntityQuery()
              .select()
              .where()
              .addCustom('users.$primaryKeyName', value)
              .list())
          .firstOrNull;

  @override
  Map<String, dynamic> toInsert() => {
        "id": model.id,
        "project_id": model.projectId,
        "phone": model.phone,
        "email": model.email,
        "password": model.password,
        "name": model.name,
        "last_name": model.lastName,
        "is_archived": model.isArchived,
        "is_blocked": model.isBlocked,
        "role_id": model.role.key,
        "created_at": model.createdAt,
      };
}

class UserEntityMigration extends Migration {
  UserEntityMigration(super.tableName);

  @override
  List<ColumnInfo> get columns => [
        ColumnInfo(
          name: 'id',
          columnType: ColumnType.integer,
          defaultValue: null,
          isKey: true,
          isAutoIncrement: true,
          unique: false,
          nullable: false,
          length: 0,
        ),
        ColumnInfo(
          name: 'project_id',
          columnType: ColumnType.text,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: true,
          length: 0,
        ),
        ColumnInfo(
          name: 'phone',
          columnType: ColumnType.varchar,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 32,
        ),
        ColumnInfo(
          name: 'email',
          columnType: ColumnType.varchar,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: true,
          nullable: true,
          length: 128,
        ),
        ColumnInfo(
          name: 'password',
          columnType: ColumnType.varchar,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 128,
        ),
        ColumnInfo(
          name: 'name',
          columnType: ColumnType.text,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 0,
        ),
        ColumnInfo(
          name: 'last_name',
          columnType: ColumnType.text,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 0,
        ),
        ColumnInfo(
          name: 'is_archived',
          columnType: ColumnType.bool,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 0,
        ),
        ColumnInfo(
          name: 'is_blocked',
          columnType: ColumnType.bool,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 0,
        ),
        ColumnInfo(
          name: 'role_id',
          columnType: ColumnType.varchar,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 0,
        ),
        ColumnInfo(
          name: 'created_at',
          columnType: ColumnType.timestamp,
          defaultValue: null,
          isKey: false,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 0,
        )
      ];
}
