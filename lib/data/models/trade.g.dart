// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTradeCollection on Isar {
  IsarCollection<Trade> get trades => this.collection();
}

const TradeSchema = CollectionSchema(
  name: r'Trade',
  id: 4394246318675225554,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'direction': PropertySchema(
      id: 2,
      name: r'direction',
      type: IsarType.string,
    ),
    r'emotion': PropertySchema(
      id: 3,
      name: r'emotion',
      type: IsarType.string,
    ),
    r'entryPrice': PropertySchema(
      id: 4,
      name: r'entryPrice',
      type: IsarType.double,
    ),
    r'exitPrice': PropertySchema(
      id: 5,
      name: r'exitPrice',
      type: IsarType.double,
    ),
    r'leverage': PropertySchema(
      id: 6,
      name: r'leverage',
      type: IsarType.long,
    ),
    r'marketType': PropertySchema(
      id: 7,
      name: r'marketType',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 8,
      name: r'notes',
      type: IsarType.string,
    ),
    r'pair': PropertySchema(
      id: 9,
      name: r'pair',
      type: IsarType.string,
    ),
    r'pnl': PropertySchema(
      id: 10,
      name: r'pnl',
      type: IsarType.double,
    ),
    r'positionSize': PropertySchema(
      id: 11,
      name: r'positionSize',
      type: IsarType.double,
    ),
    r'reason': PropertySchema(
      id: 12,
      name: r'reason',
      type: IsarType.string,
    ),
    r'riskRewardRatio': PropertySchema(
      id: 13,
      name: r'riskRewardRatio',
      type: IsarType.string,
    ),
    r'screenshotPath': PropertySchema(
      id: 14,
      name: r'screenshotPath',
      type: IsarType.string,
    ),
    r'stopLoss': PropertySchema(
      id: 15,
      name: r'stopLoss',
      type: IsarType.double,
    ),
    r'strategyId': PropertySchema(
      id: 16,
      name: r'strategyId',
      type: IsarType.long,
    ),
    r'takeProfit': PropertySchema(
      id: 17,
      name: r'takeProfit',
      type: IsarType.double,
    ),
    r'userId': PropertySchema(
      id: 18,
      name: r'userId',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 19,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _tradeEstimateSize,
  serialize: _tradeSerialize,
  deserialize: _tradeDeserialize,
  deserializeProp: _tradeDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _tradeGetId,
  getLinks: _tradeGetLinks,
  attach: _tradeAttach,
  version: '3.1.0+1',
);

int _tradeEstimateSize(
  Trade object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.direction.length * 3;
  {
    final value = object.emotion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.marketType.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.pair.length * 3;
  {
    final value = object.reason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.riskRewardRatio;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.screenshotPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _tradeSerialize(
  Trade object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.direction);
  writer.writeString(offsets[3], object.emotion);
  writer.writeDouble(offsets[4], object.entryPrice);
  writer.writeDouble(offsets[5], object.exitPrice);
  writer.writeLong(offsets[6], object.leverage);
  writer.writeString(offsets[7], object.marketType);
  writer.writeString(offsets[8], object.notes);
  writer.writeString(offsets[9], object.pair);
  writer.writeDouble(offsets[10], object.pnl);
  writer.writeDouble(offsets[11], object.positionSize);
  writer.writeString(offsets[12], object.reason);
  writer.writeString(offsets[13], object.riskRewardRatio);
  writer.writeString(offsets[14], object.screenshotPath);
  writer.writeDouble(offsets[15], object.stopLoss);
  writer.writeLong(offsets[16], object.strategyId);
  writer.writeDouble(offsets[17], object.takeProfit);
  writer.writeLong(offsets[18], object.userId);
  writer.writeString(offsets[19], object.uuid);
}

Trade _tradeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Trade();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.direction = reader.readString(offsets[2]);
  object.emotion = reader.readStringOrNull(offsets[3]);
  object.entryPrice = reader.readDouble(offsets[4]);
  object.exitPrice = reader.readDoubleOrNull(offsets[5]);
  object.id = id;
  object.leverage = reader.readLongOrNull(offsets[6]);
  object.marketType = reader.readString(offsets[7]);
  object.notes = reader.readStringOrNull(offsets[8]);
  object.pair = reader.readString(offsets[9]);
  object.pnl = reader.readDoubleOrNull(offsets[10]);
  object.positionSize = reader.readDouble(offsets[11]);
  object.reason = reader.readStringOrNull(offsets[12]);
  object.riskRewardRatio = reader.readStringOrNull(offsets[13]);
  object.screenshotPath = reader.readStringOrNull(offsets[14]);
  object.stopLoss = reader.readDoubleOrNull(offsets[15]);
  object.strategyId = reader.readLongOrNull(offsets[16]);
  object.takeProfit = reader.readDoubleOrNull(offsets[17]);
  object.userId = reader.readLong(offsets[18]);
  object.uuid = reader.readString(offsets[19]);
  return object;
}

P _tradeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tradeGetId(Trade object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tradeGetLinks(Trade object) {
  return [];
}

void _tradeAttach(IsarCollection<dynamic> col, Id id, Trade object) {
  object.id = id;
}

extension TradeByIndex on IsarCollection<Trade> {
  Future<Trade?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Trade? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Trade?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Trade?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(Trade object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Trade object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Trade> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Trade> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension TradeQueryWhereSort on QueryBuilder<Trade, Trade, QWhere> {
  QueryBuilder<Trade, Trade, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhere> anyUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'userId'),
      );
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension TradeQueryWhere on QueryBuilder<Trade, Trade, QWhereClause> {
  QueryBuilder<Trade, Trade, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> userIdEqualTo(int userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> userIdNotEqualTo(int userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> userIdGreaterThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [userId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> userIdLessThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [],
        upper: [userId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> userIdBetween(
    int lowerUserId,
    int upperUserId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [lowerUserId],
        includeLower: includeLower,
        upper: [upperUserId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> dateNotEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterWhereClause> uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TradeQueryFilter on QueryBuilder<Trade, Trade, QFilterCondition> {
  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'direction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'direction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> directionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emotion',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emotion',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emotion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emotion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotion',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> emotionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emotion',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> entryPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> entryPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> entryPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> entryPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exitPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exitPrice',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exitPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exitPrice',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exitPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exitPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exitPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> exitPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exitPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> leverageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leverage',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> leverageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leverage',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> leverageEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leverage',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> leverageGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leverage',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> leverageLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leverage',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> leverageBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leverage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marketType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'marketType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'marketType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'marketType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'marketType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'marketType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'marketType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'marketType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marketType',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> marketTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'marketType',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pair',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pair',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pair',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pair',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pair',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pair',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pair',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pair',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pair',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pairIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pair',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pnlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pnl',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pnlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pnl',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pnlEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pnl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pnlGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pnl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pnlLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pnl',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> pnlBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pnl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> positionSizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'positionSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> positionSizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'positionSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> positionSizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'positionSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> positionSizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'positionSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reason',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reason',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> reasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'riskRewardRatio',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'riskRewardRatio',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskRewardRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'riskRewardRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'riskRewardRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'riskRewardRatio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'riskRewardRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'riskRewardRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'riskRewardRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'riskRewardRatio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> riskRewardRatioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskRewardRatio',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition>
      riskRewardRatioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'riskRewardRatio',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'screenshotPath',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'screenshotPath',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenshotPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'screenshotPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'screenshotPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'screenshotPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'screenshotPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'screenshotPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'screenshotPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'screenshotPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenshotPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> screenshotPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'screenshotPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> stopLossIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stopLoss',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> stopLossIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stopLoss',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> stopLossEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stopLoss',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> stopLossGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stopLoss',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> stopLossLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stopLoss',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> stopLossBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stopLoss',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> strategyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'strategyId',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> strategyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'strategyId',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> strategyIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strategyId',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> strategyIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'strategyId',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> strategyIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'strategyId',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> strategyIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'strategyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> takeProfitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'takeProfit',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> takeProfitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'takeProfit',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> takeProfitEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'takeProfit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> takeProfitGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'takeProfit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> takeProfitLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'takeProfit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> takeProfitBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'takeProfit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> userIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Trade, Trade, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension TradeQueryObject on QueryBuilder<Trade, Trade, QFilterCondition> {}

extension TradeQueryLinks on QueryBuilder<Trade, Trade, QFilterCondition> {}

extension TradeQuerySortBy on QueryBuilder<Trade, Trade, QSortBy> {
  QueryBuilder<Trade, Trade, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByEmotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotion', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByEmotionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotion', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByEntryPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryPrice', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByEntryPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryPrice', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByExitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitPrice', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByExitPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitPrice', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByLeverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leverage', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByLeverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leverage', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByMarketType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketType', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByMarketTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketType', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPair() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pair', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPairDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pair', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPnl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pnl', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPnlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pnl', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPositionSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionSize', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByPositionSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionSize', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByRiskRewardRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskRewardRatio', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByRiskRewardRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskRewardRatio', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByScreenshotPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenshotPath', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByScreenshotPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenshotPath', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByStopLoss() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stopLoss', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByStopLossDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stopLoss', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByStrategyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByStrategyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByTakeProfit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takeProfit', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByTakeProfitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takeProfit', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TradeQuerySortThenBy on QueryBuilder<Trade, Trade, QSortThenBy> {
  QueryBuilder<Trade, Trade, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByEmotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotion', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByEmotionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotion', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByEntryPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryPrice', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByEntryPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryPrice', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByExitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitPrice', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByExitPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitPrice', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByLeverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leverage', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByLeverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leverage', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByMarketType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketType', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByMarketTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketType', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPair() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pair', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPairDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pair', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPnl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pnl', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPnlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pnl', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPositionSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionSize', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByPositionSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionSize', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByRiskRewardRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskRewardRatio', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByRiskRewardRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskRewardRatio', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByScreenshotPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenshotPath', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByScreenshotPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenshotPath', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByStopLoss() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stopLoss', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByStopLossDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stopLoss', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByStrategyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByStrategyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strategyId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByTakeProfit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takeProfit', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByTakeProfitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takeProfit', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Trade, Trade, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TradeQueryWhereDistinct on QueryBuilder<Trade, Trade, QDistinct> {
  QueryBuilder<Trade, Trade, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByDirection(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'direction', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByEmotion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emotion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByEntryPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryPrice');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByExitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exitPrice');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByLeverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leverage');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByMarketType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marketType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPair(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pair', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPnl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pnl');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByPositionSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'positionSize');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByReason(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reason', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByRiskRewardRatio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'riskRewardRatio',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByScreenshotPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'screenshotPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByStopLoss() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stopLoss');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByStrategyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strategyId');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByTakeProfit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'takeProfit');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }

  QueryBuilder<Trade, Trade, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension TradeQueryProperty on QueryBuilder<Trade, Trade, QQueryProperty> {
  QueryBuilder<Trade, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Trade, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Trade, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> directionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'direction');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> emotionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emotion');
    });
  }

  QueryBuilder<Trade, double, QQueryOperations> entryPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryPrice');
    });
  }

  QueryBuilder<Trade, double?, QQueryOperations> exitPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exitPrice');
    });
  }

  QueryBuilder<Trade, int?, QQueryOperations> leverageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leverage');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> marketTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marketType');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> pairProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pair');
    });
  }

  QueryBuilder<Trade, double?, QQueryOperations> pnlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pnl');
    });
  }

  QueryBuilder<Trade, double, QQueryOperations> positionSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'positionSize');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> reasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reason');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> riskRewardRatioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'riskRewardRatio');
    });
  }

  QueryBuilder<Trade, String?, QQueryOperations> screenshotPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'screenshotPath');
    });
  }

  QueryBuilder<Trade, double?, QQueryOperations> stopLossProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stopLoss');
    });
  }

  QueryBuilder<Trade, int?, QQueryOperations> strategyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strategyId');
    });
  }

  QueryBuilder<Trade, double?, QQueryOperations> takeProfitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'takeProfit');
    });
  }

  QueryBuilder<Trade, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<Trade, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
