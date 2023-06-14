import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  const ErrorModel({
    this.errMsg = '',
  });

  final String errMsg;

  @override
  List<Object> get props => [errMsg];

  @override
  String toString() => 'ErrorModel(errMsg: $errMsg)';
}
