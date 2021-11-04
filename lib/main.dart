import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudo_task/bloc/home_bloc/bloc.dart';
import 'package:sudo_task/bloc/simple_bloc_delegate.dart';
import 'package:sudo_task/screens/homescreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFF9EB),
        body: Container(
          child: BlocProvider<NewsListBloc>(
            create: (BuildContext context) =>
                NewsListBloc(params: "in", sources: 'COUNTRY')..add(Fetch()),
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}
