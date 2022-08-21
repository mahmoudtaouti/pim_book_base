import 'failures.dart';

class UnexpectedValueError extends Error{

  final ValueFailure failureValue;
  UnexpectedValueError(this.failureValue);

  @override
  String toString() {
    return 'Encountered a ValueFailure at an unrecoverable point.'
        '\n Terminating.'
        '\n Failure was: $failureValue';
  }
}