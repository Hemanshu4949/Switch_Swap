// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation_profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAutomationProfileCollection on Isar {
  IsarCollection<AutomationProfile> get automationProfiles => this.collection();
}

const AutomationProfileSchema = CollectionSchema(
  name: r'AutomationProfile',
  id: 8576709015658849636,
  properties: {
    r'constraints': PropertySchema(
      id: 0,
      name: r'constraints',
      type: IsarType.object,
      target: r'ExecutionConstraints',
    ),
    r'isEnabled': PropertySchema(
      id: 1,
      name: r'isEnabled',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'triggerSequence': PropertySchema(
      id: 3,
      name: r'triggerSequence',
      type: IsarType.stringList,
    ),
    r'triggerType': PropertySchema(
      id: 4,
      name: r'triggerType',
      type: IsarType.string,
    )
  },
  estimateSize: _automationProfileEstimateSize,
  serialize: _automationProfileSerialize,
  deserialize: _automationProfileDeserialize,
  deserializeProp: _automationProfileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'macro': LinkSchema(
      id: 5815455244425577594,
      name: r'macro',
      target: r'Macro',
      single: true,
    )
  },
  embeddedSchemas: {r'ExecutionConstraints': ExecutionConstraintsSchema},
  getId: _automationProfileGetId,
  getLinks: _automationProfileGetLinks,
  attach: _automationProfileAttach,
  version: '3.1.0+1',
);

int _automationProfileEstimateSize(
  AutomationProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.constraints;
    if (value != null) {
      bytesCount += 3 +
          ExecutionConstraintsSchema.estimateSize(
              value, allOffsets[ExecutionConstraints]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.triggerSequence.length * 3;
  {
    for (var i = 0; i < object.triggerSequence.length; i++) {
      final value = object.triggerSequence[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.triggerType.length * 3;
  return bytesCount;
}

void _automationProfileSerialize(
  AutomationProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<ExecutionConstraints>(
    offsets[0],
    allOffsets,
    ExecutionConstraintsSchema.serialize,
    object.constraints,
  );
  writer.writeBool(offsets[1], object.isEnabled);
  writer.writeString(offsets[2], object.name);
  writer.writeStringList(offsets[3], object.triggerSequence);
  writer.writeString(offsets[4], object.triggerType);
}

AutomationProfile _automationProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AutomationProfile(
    constraints: reader.readObjectOrNull<ExecutionConstraints>(
      offsets[0],
      ExecutionConstraintsSchema.deserialize,
      allOffsets,
    ),
    id: id,
    isEnabled: reader.readBoolOrNull(offsets[1]) ?? true,
    name: reader.readString(offsets[2]),
    triggerSequence: reader.readStringList(offsets[3]) ?? const [],
    triggerType: reader.readString(offsets[4]),
  );
  return object;
}

P _automationProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<ExecutionConstraints>(
        offset,
        ExecutionConstraintsSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? const []) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _automationProfileGetId(AutomationProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _automationProfileGetLinks(
    AutomationProfile object) {
  return [object.macro];
}

void _automationProfileAttach(
    IsarCollection<dynamic> col, Id id, AutomationProfile object) {
  object.id = id;
  object.macro.attach(col, col.isar.collection<Macro>(), r'macro', id);
}

extension AutomationProfileQueryWhereSort
    on QueryBuilder<AutomationProfile, AutomationProfile, QWhere> {
  QueryBuilder<AutomationProfile, AutomationProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AutomationProfileQueryWhere
    on QueryBuilder<AutomationProfile, AutomationProfile, QWhereClause> {
  QueryBuilder<AutomationProfile, AutomationProfile, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterWhereClause>
      idBetween(
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

extension AutomationProfileQueryFilter
    on QueryBuilder<AutomationProfile, AutomationProfile, QFilterCondition> {
  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      constraintsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'constraints',
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      constraintsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'constraints',
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      isEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggerSequence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'triggerSequence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'triggerSequence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'triggerSequence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'triggerSequence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'triggerSequence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'triggerSequence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'triggerSequence',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggerSequence',
        value: '',
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'triggerSequence',
        value: '',
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'triggerSequence',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'triggerSequence',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'triggerSequence',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'triggerSequence',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'triggerSequence',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerSequenceLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'triggerSequence',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'triggerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'triggerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'triggerType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'triggerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'triggerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'triggerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'triggerType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggerType',
        value: '',
      ));
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      triggerTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'triggerType',
        value: '',
      ));
    });
  }
}

extension AutomationProfileQueryObject
    on QueryBuilder<AutomationProfile, AutomationProfile, QFilterCondition> {
  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      constraints(FilterQuery<ExecutionConstraints> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'constraints');
    });
  }
}

extension AutomationProfileQueryLinks
    on QueryBuilder<AutomationProfile, AutomationProfile, QFilterCondition> {
  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      macro(FilterQuery<Macro> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'macro');
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterFilterCondition>
      macroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'macro', 0, true, 0, true);
    });
  }
}

extension AutomationProfileQuerySortBy
    on QueryBuilder<AutomationProfile, AutomationProfile, QSortBy> {
  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      sortByIsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.asc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      sortByIsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.desc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      sortByTriggerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerType', Sort.asc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      sortByTriggerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerType', Sort.desc);
    });
  }
}

extension AutomationProfileQuerySortThenBy
    on QueryBuilder<AutomationProfile, AutomationProfile, QSortThenBy> {
  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      thenByIsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.asc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      thenByIsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.desc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      thenByTriggerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerType', Sort.asc);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QAfterSortBy>
      thenByTriggerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerType', Sort.desc);
    });
  }
}

extension AutomationProfileQueryWhereDistinct
    on QueryBuilder<AutomationProfile, AutomationProfile, QDistinct> {
  QueryBuilder<AutomationProfile, AutomationProfile, QDistinct>
      distinctByIsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEnabled');
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QDistinct>
      distinctByTriggerSequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'triggerSequence');
    });
  }

  QueryBuilder<AutomationProfile, AutomationProfile, QDistinct>
      distinctByTriggerType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'triggerType', caseSensitive: caseSensitive);
    });
  }
}

extension AutomationProfileQueryProperty
    on QueryBuilder<AutomationProfile, AutomationProfile, QQueryProperty> {
  QueryBuilder<AutomationProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AutomationProfile, ExecutionConstraints?, QQueryOperations>
      constraintsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'constraints');
    });
  }

  QueryBuilder<AutomationProfile, bool, QQueryOperations> isEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEnabled');
    });
  }

  QueryBuilder<AutomationProfile, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<AutomationProfile, List<String>, QQueryOperations>
      triggerSequenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'triggerSequence');
    });
  }

  QueryBuilder<AutomationProfile, String, QQueryOperations>
      triggerTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'triggerType');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ExecutionConstraintsSchema = Schema(
  name: r'ExecutionConstraints',
  id: 8199561504724617506,
  properties: {
    r'requireCharging': PropertySchema(
      id: 0,
      name: r'requireCharging',
      type: IsarType.bool,
    ),
    r'requireDeviceUnlocked': PropertySchema(
      id: 1,
      name: r'requireDeviceUnlocked',
      type: IsarType.bool,
    ),
    r'requireHeadset': PropertySchema(
      id: 2,
      name: r'requireHeadset',
      type: IsarType.bool,
    ),
    r'requireLandscape': PropertySchema(
      id: 3,
      name: r'requireLandscape',
      type: IsarType.bool,
    ),
    r'requireScreenOn': PropertySchema(
      id: 4,
      name: r'requireScreenOn',
      type: IsarType.bool,
    ),
    r'requireSpecificApp': PropertySchema(
      id: 5,
      name: r'requireSpecificApp',
      type: IsarType.string,
    ),
    r'requireWiFi': PropertySchema(
      id: 6,
      name: r'requireWiFi',
      type: IsarType.bool,
    )
  },
  estimateSize: _executionConstraintsEstimateSize,
  serialize: _executionConstraintsSerialize,
  deserialize: _executionConstraintsDeserialize,
  deserializeProp: _executionConstraintsDeserializeProp,
);

int _executionConstraintsEstimateSize(
  ExecutionConstraints object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.requireSpecificApp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _executionConstraintsSerialize(
  ExecutionConstraints object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.requireCharging);
  writer.writeBool(offsets[1], object.requireDeviceUnlocked);
  writer.writeBool(offsets[2], object.requireHeadset);
  writer.writeBool(offsets[3], object.requireLandscape);
  writer.writeBool(offsets[4], object.requireScreenOn);
  writer.writeString(offsets[5], object.requireSpecificApp);
  writer.writeBool(offsets[6], object.requireWiFi);
}

ExecutionConstraints _executionConstraintsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExecutionConstraints();
  object.requireCharging = reader.readBool(offsets[0]);
  object.requireDeviceUnlocked = reader.readBool(offsets[1]);
  object.requireHeadset = reader.readBool(offsets[2]);
  object.requireLandscape = reader.readBool(offsets[3]);
  object.requireScreenOn = reader.readBool(offsets[4]);
  object.requireSpecificApp = reader.readStringOrNull(offsets[5]);
  object.requireWiFi = reader.readBool(offsets[6]);
  return object;
}

P _executionConstraintsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ExecutionConstraintsQueryFilter on QueryBuilder<ExecutionConstraints,
    ExecutionConstraints, QFilterCondition> {
  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireChargingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireCharging',
        value: value,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireDeviceUnlockedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireDeviceUnlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireHeadsetEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireHeadset',
        value: value,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireLandscapeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireLandscape',
        value: value,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireScreenOnEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireScreenOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requireSpecificApp',
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requireSpecificApp',
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireSpecificApp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requireSpecificApp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requireSpecificApp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requireSpecificApp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requireSpecificApp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requireSpecificApp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
          QAfterFilterCondition>
      requireSpecificAppContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requireSpecificApp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
          QAfterFilterCondition>
      requireSpecificAppMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requireSpecificApp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireSpecificApp',
        value: '',
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requireSpecificApp',
        value: '',
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireWiFiEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireWiFi',
        value: value,
      ));
    });
  }
}

extension ExecutionConstraintsQueryObject on QueryBuilder<ExecutionConstraints,
    ExecutionConstraints, QFilterCondition> {}
