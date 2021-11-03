import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_event.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_state.dart';
import 'package:sudo_task/models/news_model.dart';
import 'package:sudo_task/resources/repository.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsListBloc({@required this.params, this.sources})
      : super(NewsListUninitialized());

  String? params;
  String? sources;

  final Repository _repository = Repository();

  NewsListState? get currentState => null;

  @override
  Stream<Transition<NewsListEvent, NewsListState>> transformEvents(
    Stream<NewsListEvent> events,
    TransitionFunction<NewsListEvent, NewsListState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  NewsListState get initialState => NewsListUninitialized();

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    final currentState = state;
    if (event is Query) {
      yield NewsListUninitialized();
    }

    if (event is RefreshFetch) {
      yield NewsListUninitialized();
    }

    if (event is Query ||
        event is RefreshFetch ||
        event is Fetch && !_hasReachedMax(currentState)) {
      try {
        NewsModel posts;
        List<Articles>? currentDataList;

        if (currentState is NewsListUninitialized) {
          int page = 1;
          int pageCount = 10;
          int startAt = 0;
          int? endAt;
          int totalPages = 0;

          posts = await _repository.fetchNewsApiModel(params, sources);

          if (posts.error != null) {
            yield NewsListError(
              error: posts.error,
            );
          }

          endAt = startAt + pageCount;
          totalPages = (posts.articles!.length / pageCount).floor();

          if (posts.articles!.length / pageCount > totalPages) {
            totalPages = totalPages + 1;
          }

          currentDataList = posts.articles!.getRange(startAt, endAt).toList();
          yield NewsListLoaded(
              posts: currentDataList,
              hasReachedMax: (posts.totalResults! > 10) ? false : true,
              loadingAdditionalResults: false,
              pageCount: pageCount,
              startAt: startAt,
              endAt: endAt,
              totalPages: totalPages,
              page: page,
              params: params,
              sources: sources);
        }

        if (currentState is NewsListLoaded) {
          int? startAt;
          int? endAt;

          yield (currentState as NewsListLoaded).copyWith(
            loadingAdditionalResults: true,
          );
          if (event is Query) {
            (currentState as NewsListLoaded).posts!.clear();

            int page = 1;
            int pageCount = 10;
            int startAt = 0;
            int? endAt;
            int totalPages = 0;

            posts =
                await _repository.fetchNewsApiModel(event.params, event.source);

            if (posts.error != null) {
              yield NewsListError(
                error: posts.error,
              );
            }

            endAt = startAt + pageCount;
            totalPages = (posts.articles!.length / pageCount).floor();

            if (posts.articles!.length / pageCount > totalPages) {
              totalPages = totalPages + 1;
            }

            currentDataList = posts.articles!.getRange(startAt, endAt).toList();

            yield (currentState as NewsListLoaded).copyWith(
              loadingAdditionalResults: false,
            );
            yield NewsListLoaded(
                posts: currentDataList,
                hasReachedMax: (posts.totalResults! > 10) ? false : true,
                loadingAdditionalResults: false,
                pageCount: pageCount,
                startAt: startAt,
                endAt: endAt,
                totalPages: totalPages,
                page: page,
                params: event.params,
                sources: event.source);
          } else if (currentState.page! < currentState.totalPages!) {
            List<Articles>? currentDataList;
            NewsModel posts;
            posts = await _repository.fetchNewsApiModel(
                currentState.params, currentState.sources);
            startAt = currentState.startAt! + currentState.pageCount!;
            endAt = posts.articles!.length >
                    currentState.endAt! + currentState.pageCount!
                ? currentState.endAt! + currentState.pageCount!
                : posts.articles!.length;

            currentDataList = posts.articles!.getRange(startAt, endAt).toList();

            yield (currentState as NewsListLoaded).copyWith(
              loadingAdditionalResults: false,
            );

            yield currentDataList.isEmpty
                ? (currentState as NewsListLoaded).copyWith(
                    hasReachedMax: true,
                  )
                : NewsListLoaded(
                    posts: (currentState as NewsListLoaded).posts! +
                        currentDataList,
                    hasReachedMax:
                        (currentDataList.length != 10) ? true : false,
                    loadingAdditionalResults: false,
                    pageCount: currentState.pageCount,
                    startAt: currentState.startAt,
                    endAt: currentState.endAt,
                    totalPages: currentState.totalPages,
                    page: currentState.page! + 1,
                    params: currentState.params,
                    sources: currentState.sources);
          } else {
            yield (currentState as NewsListLoaded).copyWith(
              hasReachedMax: true,
              loadingAdditionalResults: false,
            );
          }
        }
      } catch (error) {
        yield NewsListError();
      }
    }
  }

  bool _hasReachedMax(NewsListState state) =>
      state is NewsListLoaded && state.hasReachedMax!;
}
