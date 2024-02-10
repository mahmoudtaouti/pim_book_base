import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class DatabaseFailure<T> with _$DatabaseFailure<T>{

  /// The init method could fail to create the database
  /// due to insufficient permissions or a lack of storage space.
  const factory DatabaseFailure.insufficientStorageSpace(
      ) = InsufficientStorageSpace<T>;
  const factory DatabaseFailure.permissionDenied(
      ) = PermissionDenied<T>;

  /// The database getter could fail to return a valid database object
  /// due to a database error or if the database file is missing.
  const factory DatabaseFailure.notFound(
      ) = NotFound<T>;
}

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T>{

  const factory ValueFailure.notValidToSaveInDatabase() = NotValidToSaveInDatabase<T>;
  const factory ValueFailure.emptyValue() = EmptyValue<T>;
}
