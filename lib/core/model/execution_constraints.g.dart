// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_constraints.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ExecutionConstraintsSchema = Schema(
  name: r'ExecutionConstraints',
  id: 8199561504724617506,
  properties: {
    r'requireDeviceUnlocked': PropertySchema(
      id: 0,
      name: r'requireDeviceUnlocked',
      type: IsarType.bool,
    ),
    r'requireScreenOn': PropertySchema(
      id: 1,
      name: r'requireScreenOn',
      type: IsarType.bool,
    ),
    r'requireSpecificAppOpen': PropertySchema(
      id: 2,
      name: r'requireSpecificAppOpen',
      type: IsarType.string,
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
    final value = object.requireSpecificAppOpen;
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
  writer.writeBool(offsets[0], object.requireDeviceUnlocked);
  writer.writeBool(offsets[1], object.requireScreenOn);
  writer.writeString(offsets[2], object.requireSpecificAppOpen);
}

ExecutionConstraints _executionConstraintsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExecutionConstraints();
  object.requireDeviceUnlocked = reader.readBool(offsets[0]);
  object.requireScreenOn = reader.readBool(offsets[1]);
  object.requireSpecificAppOpen = reader.readStringOrNull(offsets[2]);
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
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ExecutionConstraintsQueryFilter on QueryBuilder<ExecutionConstraints,
    ExecutionConstraints, QFilterCondition> {
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
      QAfterFilterCondition> requireScreenOnEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireScreenOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requireSpecificAppOpen',
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requireSpecificAppOpen',
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireSpecificAppOpen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requireSpecificAppOpen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requireSpecificAppOpen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requireSpecificAppOpen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requireSpecificAppOpen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requireSpecificAppOpen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
          QAfterFilterCondition>
      requireSpecificAppOpenContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requireSpecificAppOpen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
          QAfterFilterCondition>
      requireSpecificAppOpenMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requireSpecificAppOpen',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireSpecificAppOpen',
        value: '',
      ));
    });
  }

  QueryBuilder<ExecutionConstraints, ExecutionConstraints,
      QAfterFilterCondition> requireSpecificAppOpenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requireSpecificAppOpen',
        value: '',
      ));
    });
  }
}

extension ExecutionConstraintsQueryObject on QueryBuilder<ExecutionConstraints,
    ExecutionConstraints, QFilterCondition> {}
