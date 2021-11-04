import 'package:flutter/material.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_bloc.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_event.dart';

class LanguageListBlock extends StatelessWidget {
  LanguageListBlock(
      {Key? key,
      this.postBloc,
      this.countryCode,
      this.colorsList,
      this.randomColors,
      this.index})
      : super(key: key);

  NewsListBloc? postBloc;
  var countryCode;
  List<Color>? colorsList;
  int? randomColors;
  int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('');
        postBloc!
            .add(Query(params: countryCode[index]['code'], source: 'LANGUAGE'));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: colorsList![randomColors!],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          child: Center(
            child: Text(
              '${countryCode[index]['language']}',
              style: TextStyle(fontFamily: 'montserrat_medium', fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
