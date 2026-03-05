// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CountrySummaryModel {
  String get name => throw _privateConstructorUsedError;
  String get flag => throw _privateConstructorUsedError;
  int get population => throw _privateConstructorUsedError;
  String get cca2 => throw _privateConstructorUsedError;

  /// Create a copy of CountrySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountrySummaryModelCopyWith<CountrySummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountrySummaryModelCopyWith<$Res> {
  factory $CountrySummaryModelCopyWith(
    CountrySummaryModel value,
    $Res Function(CountrySummaryModel) then,
  ) = _$CountrySummaryModelCopyWithImpl<$Res, CountrySummaryModel>;
  @useResult
  $Res call({String name, String flag, int population, String cca2});
}

/// @nodoc
class _$CountrySummaryModelCopyWithImpl<$Res, $Val extends CountrySummaryModel>
    implements $CountrySummaryModelCopyWith<$Res> {
  _$CountrySummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountrySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flag = null,
    Object? population = null,
    Object? cca2 = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            flag:
                null == flag
                    ? _value.flag
                    : flag // ignore: cast_nullable_to_non_nullable
                        as String,
            population:
                null == population
                    ? _value.population
                    : population // ignore: cast_nullable_to_non_nullable
                        as int,
            cca2:
                null == cca2
                    ? _value.cca2
                    : cca2 // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CountrySummaryModelImplCopyWith<$Res>
    implements $CountrySummaryModelCopyWith<$Res> {
  factory _$$CountrySummaryModelImplCopyWith(
    _$CountrySummaryModelImpl value,
    $Res Function(_$CountrySummaryModelImpl) then,
  ) = __$$CountrySummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String flag, int population, String cca2});
}

/// @nodoc
class __$$CountrySummaryModelImplCopyWithImpl<$Res>
    extends _$CountrySummaryModelCopyWithImpl<$Res, _$CountrySummaryModelImpl>
    implements _$$CountrySummaryModelImplCopyWith<$Res> {
  __$$CountrySummaryModelImplCopyWithImpl(
    _$CountrySummaryModelImpl _value,
    $Res Function(_$CountrySummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CountrySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flag = null,
    Object? population = null,
    Object? cca2 = null,
  }) {
    return _then(
      _$CountrySummaryModelImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        flag:
            null == flag
                ? _value.flag
                : flag // ignore: cast_nullable_to_non_nullable
                    as String,
        population:
            null == population
                ? _value.population
                : population // ignore: cast_nullable_to_non_nullable
                    as int,
        cca2:
            null == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$CountrySummaryModelImpl implements _CountrySummaryModel {
  const _$CountrySummaryModelImpl({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
  });

  @override
  final String name;
  @override
  final String flag;
  @override
  final int population;
  @override
  final String cca2;

  @override
  String toString() {
    return 'CountrySummaryModel(name: $name, flag: $flag, population: $population, cca2: $cca2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountrySummaryModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flag, flag) || other.flag == flag) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.cca2, cca2) || other.cca2 == cca2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, flag, population, cca2);

  /// Create a copy of CountrySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountrySummaryModelImplCopyWith<_$CountrySummaryModelImpl> get copyWith =>
      __$$CountrySummaryModelImplCopyWithImpl<_$CountrySummaryModelImpl>(
        this,
        _$identity,
      );
}

abstract class _CountrySummaryModel implements CountrySummaryModel {
  const factory _CountrySummaryModel({
    required final String name,
    required final String flag,
    required final int population,
    required final String cca2,
  }) = _$CountrySummaryModelImpl;

  @override
  String get name;
  @override
  String get flag;
  @override
  int get population;
  @override
  String get cca2;

  /// Create a copy of CountrySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountrySummaryModelImplCopyWith<_$CountrySummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
