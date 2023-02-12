import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message = 'Server Failure'});

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {}

