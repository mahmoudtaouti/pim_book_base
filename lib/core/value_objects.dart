import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import 'failures/failures.dart';
import 'failures/unexpected_value_error.dart';

///simple Value Object contains basic functionality
@immutable
abstract class ValueObjects<T>{

  const ValueObjects();

  Either<ValueFailure<T>,T> get value;

  @override
  String toString() {
    return 'ValueObjects {value: $value}';
  }

  bool isValid() => value.isRight();

  /// return the value if it is right else
  /// Throws [UnexpectedValueError] containing [ValueFailure]
  T getOrCrash(){
    return value.fold( (l) => throw UnexpectedValueError(l), (r) => r);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ValueObjects &&
              runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;
}