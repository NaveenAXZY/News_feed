import 'package:equatable/equatable.dart';

abstract class RecentListEvent extends Equatable {}

class Fetch extends RecentListEvent {
  @override
  String toString() => 'Fetch';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Query extends RecentListEvent {
  Query({this.params, this.source});
  final String? params;
  final String? source;

  @override
  String toString() => 'Query';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RefreshFetch extends RecentListEvent {
  @override
  String toString() => 'RefreshFetch';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
