// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_entity.dart';

// **************************************************************************
// NectarOrmGenerator
// **************************************************************************

class RoleEntity extends _RoleEntity implements Model {
  RoleEntity();

  Map<String, dynamic> toJson() => {"key": key, "name": name};

  factory RoleEntity.fromJson(Map<String, dynamic> json) => RoleEntity()
    ..key = json["key"]
    ..name = json["name"];

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
  List<String> get columns => ["key", "name"];

  @override
  String get tableName => "roles";

  @override
  void fromRow(Map result) {
    if (result.containsKey('roles')) {
      key = result['roles']['key'];
    } else {
      key = result['key'];
    }

    if (result.containsKey('roles')) {
      name = result['roles']['name'];
    } else {
      name = result['name'];
    }
  }

  @override
  String get primaryKeyName => "key";

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
      getIt.get<Db>().delete(table: tableName, where: {primaryKeyName: key});

  static RoleEntityMigration migration() => RoleEntityMigration("roles");

  static RoleEntityQuery query() => RoleEntityQuery();

  Future<RoleEntity?> save() async =>
      await RoleEntityInsertClause(this, () => RoleEntity()).insert();
}

class RoleEntityQuery extends Query<RoleEntity> {
  RoleEntityQuery() : super("roles", "key");

  @override
  RoleEntity instanceOfT() => RoleEntity();

  List<String> get _defaultTableFields =>
      ["roles.key as roles\$key", "roles.name as roles\$name"];

  @override
  RoleEntitySelectClause select({
    List<String> fields = const [],
  }) {
    model.fields = (fields.isEmpty) ? _defaultTableFields : fields;
    model.joins = [];
    return RoleEntitySelectClause(model, instanceOfT);
  }
}

class RoleEntitySelectClause extends SelectClause<RoleEntity> {
  RoleEntitySelectClause(super.model, super.instanceOfT);

  @override
  RoleEntityWhereClause where() => RoleEntityWhereClause(model, instanceOfT);

  @override
  RoleEntitySelectClause join(JoinModel join) {
    model.joins.add(join);
    return this;
  }
}

class RoleEntityWhereClause extends WhereClause<RoleEntity> {
  RoleEntityWhereClause(super.model, super.instanceOfT);

  RoleEntityWhereClause key(String value, {operator = "=", condition = "AND"}) {
    model.where["roles.key"] = [operator, value, condition];
    return this;
  }

  RoleEntityWhereClause name(String value,
      {operator = "=", condition = "AND"}) {
    model.where["roles.name"] = [operator, value, condition];
    return this;
  }

  RoleEntityWhereClause customField(String key, value,
      {operator = "=", condition = "AND"}) {
    model.where[key] = [operator, value, condition];
    return this;
  }

  RoleEntityWhereClause customWhere(String where) {
    model.where["_SQL"] = where;
    return this;
  }
}

class RoleEntityInsertClause extends InsertClause<RoleEntity> {
  RoleEntityInsertClause(super.model, super.instanceOfT);

  @override
  Future<RoleEntity?> selectOne(String primaryKeyName, dynamic value) async =>
      (await RoleEntityQuery()
              .select()
              .where()
              .addCustom('roles.$primaryKeyName', value)
              .list())
          .firstOrNull;

  @override
  Map<String, dynamic> toInsert() => {
        "key": model.key,
        "name": model.name,
      };
}

class RoleEntityMigration extends Migration {
  RoleEntityMigration(super.tableName);

  @override
  List<ColumnInfo> get columns => [
        ColumnInfo(
          name: 'key',
          columnType: ColumnType.varchar,
          defaultValue: null,
          isKey: true,
          isAutoIncrement: false,
          unique: false,
          nullable: false,
          length: 0,
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
        )
      ];
}
