import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T>{



  const factory ValueFailure.emptyTitle(
      {@required String ?failedValue
      }) = EmptyTitle<T>;

  const factory ValueFailure.noData(
      {@required String ?failedValue
      }) = NoData<T>;

}
