// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'macro.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMacroCollection on Isar {
  IsarCollection<Macro> get macros => this.collection();
}

const MacroSchema = CollectionSchema(
  name: r'Macro',
  id: -2582945574721736876,
  properties: {
    r'actions': PropertySchema(
      id: 0,
      name: r'actions',
      type: IsarType.objectList,
      target: r'ActionItem',
    ),
    r'isLoopActive': PropertySchema(
      id: 1,
      name: r'isLoopActive',
      type: IsarType.bool,
    ),
    r'isStandalone': PropertySchema(
      id: 2,
      name: r'isStandalone',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'repeatCount': PropertySchema(
      id: 4,
      name: r'repeatCount',
      type: IsarType.long,
    )
  },
  estimateSize: _macroEstimateSize,
  serialize: _macroSerialize,
  deserialize: _macroDeserialize,
  deserializeProp: _macroDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'ActionItem': ActionItemSchema},
  getId: _macroGetId,
  getLinks: _macroGetLinks,
  attach: _macroAttach,
  version: '3.1.0+1',
);

int _macroEstimateSize(
  Macro object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.actions.length * 3;
  {
    final offsets = allOffsets[ActionItem]!;
    for (var i = 0; i < object.actions.length; i++) {
      final value = object.actions[i];
      bytesCount += ActionItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _macroSerialize(
  Macro object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<ActionItem>(
    offsets[0],
    allOffsets,
    ActionItemSchema.serialize,
    object.actions,
  );
  writer.writeBool(offsets[1], object.isLoopActive);
  writer.writeBool(offsets[2], object.isStandalone);
  writer.writeString(offsets[3], object.name);
  writer.writeLong(offsets[4], object.repeatCount);
}

Macro _macroDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Macro(
    actions: reader.readObjectList<ActionItem>(
          offsets[0],
          ActionItemSchema.deserialize,
          allOffsets,
          ActionItem(),
        ) ??
        const [],
    id: id,
    isLoopActive: reader.readBoolOrNull(offsets[1]) ?? false,
    isStandalone: reader.readBoolOrNull(offsets[2]) ?? false,
    name: reader.readString(offsets[3]),
    repeatCount: reader.readLongOrNull(offsets[4]) ?? 1,
  );
  return object;
}

P _macroDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<ActionItem>(
            offset,
            ActionItemSchema.deserialize,
            allOffsets,
            ActionItem(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _macroGetId(Macro object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _macroGetLinks(Macro object) {
  return [];
}

void _macroAttach(IsarCollection<dynamic> col, Id id, Macro object) {
  object.id = id;
}

extension MacroQueryWhereSort on QueryBuilder<Macro, Macro, QWhere> {
  QueryBuilder<Macro, Macro, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MacroQueryWhere on QueryBuilder<Macro, Macro, QWhereClause> {
  QueryBuilder<Macro, Macro, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Macro, Macro, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterWhereClause> idBetween(
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
}

extension MacroQueryFilter on QueryBuilder<Macro, Macro, QFilterCondition> {
  QueryBuilder<Macro, Macro, QAfterFilterCondition> actionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> actionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> actionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> actionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> actionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> actionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Macro, Macro, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Macro, Macro, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Macro, Macro, QAfterFilterCondition> isLoopActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLoopActive',
        value: value,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> isStandaloneEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isStandalone',
        value: value,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> repeatCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> repeatCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> repeatCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Macro, Macro, QAfterFilterCondition> repeatCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MacroQueryObject on QueryBuilder<Macro, Macro, QFilterCondition> {
  QueryBuilder<Macro, Macro, QAfterFilterCondition> actionsElement(
      FilterQuery<ActionItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'actions');
    });
  }
}

extension MacroQueryLinks on QueryBuilder<Macro, Macro, QFilterCondition> {}

extension MacroQuerySortBy on QueryBuilder<Macro, Macro, QSortBy> {
  QueryBuilder<Macro, Macro, QAfterSortBy> sortByIsLoopActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoopActive', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> sortByIsLoopActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoopActive', Sort.desc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> sortByIsStandalone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isStandalone', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> sortByIsStandaloneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isStandalone', Sort.desc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> sortByRepeatCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatCount', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> sortByRepeatCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatCount', Sort.desc);
    });
  }
}

extension MacroQuerySortThenBy on QueryBuilder<Macro, Macro, QSortThenBy> {
  QueryBuilder<Macro, Macro, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByIsLoopActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoopActive', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByIsLoopActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoopActive', Sort.desc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByIsStandalone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isStandalone', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByIsStandaloneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isStandalone', Sort.desc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByRepeatCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatCount', Sort.asc);
    });
  }

  QueryBuilder<Macro, Macro, QAfterSortBy> thenByRepeatCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatCount', Sort.desc);
    });
  }
}

extension MacroQueryWhereDistinct on QueryBuilder<Macro, Macro, QDistinct> {
  QueryBuilder<Macro, Macro, QDistinct> distinctByIsLoopActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLoopActive');
    });
  }

  QueryBuilder<Macro, Macro, QDistinct> distinctByIsStandalone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isStandalone');
    });
  }

  QueryBuilder<Macro, Macro, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Macro, Macro, QDistinct> distinctByRepeatCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatCount');
    });
  }
}

extension MacroQueryProperty on QueryBuilder<Macro, Macro, QQueryProperty> {
  QueryBuilder<Macro, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Macro, List<ActionItem>, QQueryOperations> actionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actions');
    });
  }

  QueryBuilder<Macro, bool, QQueryOperations> isLoopActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLoopActive');
    });
  }

  QueryBuilder<Macro, bool, QQueryOperations> isStandaloneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isStandalone');
    });
  }

  QueryBuilder<Macro, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Macro, int, QQueryOperations> repeatCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatCount');
    });
  }
}
