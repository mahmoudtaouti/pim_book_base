// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ValueFailureTearOff {
  const _$ValueFailureTearOff();

  EmptyTitle<T> emptyTitle<T>({String? failedValue}) {
    return EmptyTitle<T>(
      failedValue: failedValue,
    );
  }

  NoData<T> noData<T>({String? failedValue}) {
    return NoData<T>(
      failedValue: failedValue,
    );
  }
}

/// @nodoc
const $ValueFailure = _$ValueFailureTearOff();

/// @nodoc
mixin _$ValueFailure<T> {
  String? get failedValue => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? failedValue) emptyTitle,
    required TResult Function(String? failedValue) noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? failedValue)? emptyTitle,
    TResult Function(String? failedValue)? noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? failedValue)? emptyTitle,
    TResult Function(String? failedValue)? noData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyTitle<T> value) emptyTitle,
    required TResult Function(NoData<T> value) noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyTitle<T> value)? emptyTitle,
    TResult Function(NoData<T> value)? noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyTitle<T> value)? emptyTitle,
    TResult Function(NoData<T> value)? noData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValueFailureCopyWith<T, ValueFailure<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueFailureCopyWith<T, $Res> {
  factory $ValueFailureCopyWith(
          ValueFailure<T> value, $Res Function(ValueFailure<T>) then) =
      _$ValueFailureCopyWithImpl<T, $Res>;
  $Res call({String? failedValue});
}

/// @nodoc
class _$ValueFailureCopyWithImpl<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  _$ValueFailureCopyWithImpl(this._value, this._then);

  final ValueFailure<T> _value;
  // ignore: unused_field
  final $Res Function(ValueFailure<T>) _then;

  @override
  $Res call({
    Object? failedValue = freezed,
  }) {
    return _then(_value.copyWith(
      failedValue: failedValue == freezed
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class $EmptyTitleCopyWith<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  factory $EmptyTitleCopyWith(
          EmptyTitle<T> value, $Res Function(EmptyTitle<T>) then) =
      _$EmptyTitleCopyWithImpl<T, $Res>;
  @override
  $Res call({String? failedValue});
}

/// @nodoc
class _$EmptyTitleCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res>
    implements $EmptyTitleCopyWith<T, $Res> {
  _$EmptyTitleCopyWithImpl(
      EmptyTitle<T> _value, $Res Function(EmptyTitle<T>) _then)
      : super(_value, (v) => _then(v as EmptyTitle<T>));

  @override
  EmptyTitle<T> get _value => super._value as EmptyTitle<T>;

  @override
  $Res call({
    Object? failedValue = freezed,
  }) {
    return _then(EmptyTitle<T>(
      failedValue: failedValue == freezed
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EmptyTitle<T> implements EmptyTitle<T> {
  const _$EmptyTitle({this.failedValue});

  @override
  final String? failedValue;

  @override
  String toString() {
    return 'ValueFailure<$T>.emptyTitle(failedValue: $failedValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmptyTitle<T> &&
            const DeepCollectionEquality()
                .equals(other.failedValue, failedValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(failedValue));

  @JsonKey(ignore: true)
  @override
  $EmptyTitleCopyWith<T, EmptyTitle<T>> get copyWith =>
      _$EmptyTitleCopyWithImpl<T, EmptyTitle<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? failedValue) emptyTitle,
    required TResult Function(String? failedValue) noData,
  }) {
    return emptyTitle(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? failedValue)? emptyTitle,
    TResult Function(String? failedValue)? noData,
  }) {
    return emptyTitle?.call(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? failedValue)? emptyTitle,
    TResult Function(String? failedValue)? noData,
    required TResult orElse(),
  }) {
    if (emptyTitle != null) {
      return emptyTitle(failedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyTitle<T> value) emptyTitle,
    required TResult Function(NoData<T> value) noData,
  }) {
    return emptyTitle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyTitle<T> value)? emptyTitle,
    TResult Function(NoData<T> value)? noData,
  }) {
    return emptyTitle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyTitle<T> value)? emptyTitle,
    TResult Function(NoData<T> value)? noData,
    required TResult orElse(),
  }) {
    if (emptyTitle != null) {
      return emptyTitle(this);
    }
    return orElse();
  }
}

abstract class EmptyTitle<T> implements ValueFailure<T> {
  const factory EmptyTitle({String? failedValue}) = _$EmptyTitle<T>;

  @override
  String? get failedValue;
  @override
  @JsonKey(ignore: true)
  $EmptyTitleCopyWith<T, EmptyTitle<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoDataCopyWith<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  factory $NoDataCopyWith(NoData<T> value, $Res Function(NoData<T>) then) =
      _$NoDataCopyWithImpl<T, $Res>;
  @override
  $Res call({String? failedValue});
}

/// @nodoc
class _$NoDataCopyWithImpl<T, $Res> extends _$ValueFailureCopyWithImpl<T, $Res>
    implements $NoDataCopyWith<T, $Res> {
  _$NoDataCopyWithImpl(NoData<T> _value, $Res Function(NoData<T>) _then)
      : super(_value, (v) => _then(v as NoData<T>));

  @override
  NoData<T> get _value => super._value as NoData<T>;

  @override
  $Res call({
    Object? failedValue = freezed,
  }) {
    return _then(NoData<T>(
      failedValue: failedValue == freezed
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NoData<T> implements NoData<T> {
  const _$NoData({this.failedValue});

  @override
  final String? failedValue;

  @override
  String toString() {
    return 'ValueFailure<$T>.noData(failedValue: $failedValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoData<T> &&
            const DeepCollectionEquality()
                .equals(other.failedValue, failedValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(failedValue));

  @JsonKey(ignore: true)
  @override
  $NoDataCopyWith<T, NoData<T>> get copyWith =>
      _$NoDataCopyWithImpl<T, NoData<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? failedValue) emptyTitle,
    required TResult Function(String? failedValue) noData,
  }) {
    return noData(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? failedValue)? emptyTitle,
    TResult Function(String? failedValue)? noData,
  }) {
    return noData?.call(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? failedValue)? emptyTitle,
    TResult Function(String? failedValue)? noData,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData(failedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyTitle<T> value) emptyTitle,
    required TResult Function(NoData<T> value) noData,
  }) {
    return noData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyTitle<T> value)? emptyTitle,
    TResult Function(NoData<T> value)? noData,
  }) {
    return noData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyTitle<T> value)? emptyTitle,
    TResult Function(NoData<T> value)? noData,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData(this);
    }
    return orElse();
  }
}

abstract class NoData<T> implements ValueFailure<T> {
  const factory NoData({String? failedValue}) = _$NoData<T>;

  @override
  String? get failedValue;
  @override
  @JsonKey(ignore: true)
  $NoDataCopyWith<T, NoData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
