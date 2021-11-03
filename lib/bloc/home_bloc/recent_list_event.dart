import 'package:equatable/equatable.dart';

abstract class NewsListEvent extends Equatable {}

class Fetch extends NewsListEvent {
  @override
  String toString() => 'Fetch';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Query extends NewsListEvent {
  Query({this.params, this.source});
  final String? params;
  final String? source;

  @override
  String toString() => 'Query';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RefreshFetch extends NewsListEvent {
  @override
  String toString() => 'RefreshFetch';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
