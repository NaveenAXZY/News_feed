import 'package:equatable/equatable.dart';
import 'package:sudo_task/models/news_model.dart';
import 'package:sudo_task/models/recent_videos_model.dart';

abstract class RecentListState extends Equatable {
  const RecentListState();

  @override
  List<Object> get props => [];
}

class RecentListUninitialized extends RecentListState {
  @override
  String toString() => 'ProductListUninitialized';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RecentListError extends RecentListState {
  @override
  String toString() => 'ProductListError';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RecentListLoaded extends RecentListState {
  final List<Articles>? posts;
  final bool? hasReachedMax;
  final bool? loadingAdditionalResults;
  final int? pageCount;
  final int? startAt;
  final int? endAt;
  final int? totalPages;
  final int? page;
  final String? params;
  final String? sources;

  RecentListLoaded(
      {this.posts,
      this.hasReachedMax,
      this.loadingAdditionalResults,
      this.pageCount,
      this.startAt,
      this.endAt,
      this.totalPages,
      this.page,
      this.params,
      this.sources});

  RecentListLoaded copyWith({
    List<Articles>? posts,
    Path? path,
    int? total,
    bool? hasReachedMax,
    bool? loadingAdditionalResults,
    int? pageCount,
    int? startAt,
    int? endAt,
    int? totalPages,
    int? page,
    String? params,
    String? sources,
  }) {
    return RecentListLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loadingAdditionalResults:
          loadingAdditionalResults ?? this.loadingAdditionalResults,
      pageCount: pageCount ?? this.pageCount,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
      params: params ?? this.params,
      sources: sources ?? this.sources,
    );
  }

  @override
  List<Object> get props => [
        posts!,
        hasReachedMax!,
        loadingAdditionalResults!,
        pageCount!,
        startAt!,
        endAt!,
        totalPages!,
        page!,
      ];

  @override
  String toString() =>
      'ProductListLoaded { posts: ${posts!.length}, hasReachedMax: $hasReachedMax }';
}
