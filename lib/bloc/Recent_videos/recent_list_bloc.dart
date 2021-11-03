import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sudo_task/bloc/Recent_videos/recent_list_event.dart';
import 'package:sudo_task/bloc/Recent_videos/recent_list_state.dart';
import 'package:sudo_task/bloc/news_event_listner.dart';
import 'package:sudo_task/models/news_model.dart';
import 'package:sudo_task/resources/repository.dart';

class RecentListBloc extends Bloc<RecentListEvent, RecentListState> {
  RecentListBloc({@required this.params, this.sources})
      : super(RecentListUninitialized());

  String? params;
  String? sources;

  final Repository _repository = Repository();

  RecentListState? get currentState => null;

  @override
  Stream<Transition<RecentListEvent, RecentListState>> transformEvents(
    Stream<RecentListEvent> events,
    TransitionFunction<RecentListEvent, RecentListState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  RecentListState get initialState => RecentListUninitialized();

  @override
  Stream<RecentListState> mapEventToState(RecentListEvent event) async* {
    final currentState = state;
    if (event is Query) {
      yield RecentListUninitialized();
    }

    if (event is RefreshFetch) {
      yield RecentListUninitialized();
    }

    if (event is Query ||
        event is RefreshFetch ||
        event is Fetch && !_hasReachedMax(currentState)) {
      try {
        NewsModel posts;
        List<Articles>? currentDataList;

        if (currentState is RecentListUninitialized) {
          int page = 1;
          int pageCount = 10;
          int startAt = 0;
          int? endAt;
          int totalPages = 0;

          posts = await _repository.fetchNewsApiModel(params, sources);

          print('@@@@@@INSIDE${posts.error}');
          if (posts.error != null) {
            yield RecentListError(
              error: posts.error,
            );
          }

          endAt = startAt + pageCount;
          totalPages = (posts.articles!.length / pageCount).floor();

          if (posts.articles!.length / pageCount > totalPages) {
            totalPages = totalPages + 1;
            print('Pages$totalPages');
          }

          print('@@@@@@INSIDE  Firstcondition1---CC$startAt----EE$endAt');

          print(
              '@@@@@@INSIDE  Firstcondition---CC${posts.articles!.getRange(startAt, endAt)}');

          currentDataList = posts.articles!.getRange(startAt, endAt).toList();
          yield RecentListLoaded(
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

        if (currentState is RecentListLoaded) {
          int? startAt;
          int? endAt;

          yield (currentState as RecentListLoaded).copyWith(
            loadingAdditionalResults: true,
          );
          print(
              '@@@@@@INSIDE RecentListLoaded---PAGE--${currentState.page!}++++totalpages--${currentState.totalPages}');
          if (event is Query) {
            (currentState as RecentListLoaded).posts!.clear();

            int page = 1;
            int pageCount = 10;
            int startAt = 0;
            int? endAt;
            int totalPages = 0;

            posts =
                await _repository.fetchNewsApiModel(event.params, event.source);

            if (posts.error != null) {
              yield RecentListError(
                error: posts.error,
              );
            }

            endAt = startAt + pageCount;
            totalPages = (posts.articles!.length / pageCount).floor();

            if (posts.articles!.length / pageCount > totalPages) {
              totalPages = totalPages + 1;
              print('Pages$totalPages');
            }

            currentDataList = posts.articles!.getRange(startAt, endAt).toList();

            yield (currentState as RecentListLoaded).copyWith(
              loadingAdditionalResults: false,
            );
            yield RecentListLoaded(
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

            print('@@@@@@INSIDE  condition1---CC$startAt----EE$endAt');
            print('@@@@@@INSIDE  condition2---CC${posts.articles!.length}');
            print(
                '@@@@@@INSIDE  condition3---CC${posts.articles!.getRange(startAt, endAt)}');

            currentDataList = posts.articles!.getRange(startAt, endAt).toList();

            yield (currentState as RecentListLoaded).copyWith(
              loadingAdditionalResults: false,
            );

            yield currentDataList.isEmpty
                ? (currentState as RecentListLoaded).copyWith(
                    hasReachedMax: true,
                  )
                : RecentListLoaded(
                    posts: (currentState as RecentListLoaded).posts! +
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
            print('@@@@@@@INSIDE else');
            yield (currentState as RecentListLoaded).copyWith(
              hasReachedMax: true,
              loadingAdditionalResults: false,
            );
          }
        }
      } catch (error) {
        print('@@@@@@@INSIDE RecentListError${error}');
        yield RecentListError();
      }
    }
  }

  bool _hasReachedMax(RecentListState state) =>
      state is RecentListLoaded && state.hasReachedMax!;
}
