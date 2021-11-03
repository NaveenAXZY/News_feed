import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_bloc.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_event.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_state.dart';
import 'package:sudo_task/resources/api_provider_home.dart';
import 'package:sudo_task/widgets/home_screen_list/block.dart';
import 'package:sudo_task/widgets/home_screen_list/country_list_block.dart';
import 'package:sudo_task/widgets/home_screen_list/language_list_block.dart';

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeApiProvider homeApiProvider = HomeApiProvider();
  ScrollController _scrollController = ScrollController();
  double? _scrollThreshold = 170.0;
  bool? loadingAdditionalResults;
  int? total;
  NewsListBloc? _postBloc;
  TextEditingController _searchController = TextEditingController();
  String greetings = '';
  int? randomColors;

  var countryCode = [
    {"language": "Arabic", "code": "ar"},
    {"language": "German", "code": "de"},
    {"language": "English", "code": "en"},
    {"language": "Spanish", "code": "es"},
    {"language": "French", "code": "fr"},
    {"language": "Hebrew", "code": "he"},
    {"language": "Italian", "code": "it"},
    {"language": "Norwegian", "code": "no"},
    {"language": "Russian", "code": "ru"},
    {"language": "Northern Sami", "code": "se"},
  ];

  List<Color> colorsList = [
    Colors.lightGreen.shade100,
    Colors.brown.shade100,
    Colors.deepPurpleAccent.shade100,
    Colors.orange.shade100,
    Colors.redAccent.shade100,
    Colors.teal.shade100,
    Colors.indigo.shade100,
    Colors.purple.shade100,
  ];

  var countryList = [
    {
      "image": "https://newsapi.org/images/flags/ar.svg",
      "country": "Argentina",
      "code": "ar"
    },
    {
      "image": "https://newsapi.org/images/flags/au.svg",
      "country": "Australia",
      "code": "au"
    },
    {
      "image": "https://newsapi.org/images/flags/at.svg",
      "country": "Austria",
      "code": "at"
    },
    {
      "image": "https://newsapi.org/images/flags/br.svg",
      "country": "Brazil",
      "code": "br"
    },
    {
      "image": "https://newsapi.org/images/flags/ca.svg",
      "country": "Canada",
      "code": "ca"
    },
    {
      "image": "https://newsapi.org/images/flags/cn.svg",
      "country": "China",
      "code": "cn"
    },
    {
      "image": "https://newsapi.org/images/flags/co.svg",
      "country": "Colombia",
      "code": "co"
    },
    {
      "image": "https://newsapi.org/images/flags/cu.svg",
      "country": "Cuba",
      "code": "cu"
    },
    {
      "image": "https://newsapi.org/images/flags/eg.svg",
      "country": "Egypt",
      "code": "eg"
    },
    {
      "image": "https://newsapi.org/images/flags/fr.svg",
      "country": "France",
      "code": "fr"
    },
    {
      "image": "https://newsapi.org/images/flags/de.svg",
      "country": "Germany",
      "code": "de"
    },
    {
      "image": "https://newsapi.org/images/flags/hk.svg",
      "country": "Hong Kong",
      "code": "hk"
    },
    {
      "image": "https://newsapi.org/images/flags/hu.svg",
      "country": "Hungary",
      "code": "hu"
    },
    {
      "image": "https://newsapi.org/images/flags/in.svg",
      "country": "india",
      "code": "in"
    },
    {
      "image": "https://newsapi.org/images/flags/il.svg",
      "country": "Israel",
      "code": "il"
    },
    {
      "image": "https://newsapi.org/images/flags/it.svg",
      "country": "Italy",
      "code": "it"
    },
    {
      "image": "https://newsapi.org/images/flags/jp.svg",
      "country": "Japan",
      "code": "jp"
    },
    {
      "image": "https://newsapi.org/images/flags/my.svg",
      "country": "Malaysia",
      "code": "my"
    },
    {
      "image": "https://newsapi.org/images/flags/mx.svg",
      "country": "Mexico",
      "code": "mx"
    },
    {
      "image": "https://newsapi.org/images/flags/nz.svg",
      "country": "New Zealand",
      "code": "nz"
    },
    {
      "image": "https://newsapi.org/images/flags/ph.svg",
      "country": "Philippines",
      "code": "ph"
    },
    {
      "image": "https://newsapi.org/images/flags/ro.svg",
      "country": "Romania",
      "code": "ro"
    },
    {
      "image": "https://newsapi.org/images/flags/ru.svg",
      "country": "Russia",
      "code": "ru"
    },
    {
      "image": "https://newsapi.org/images/flags/sa.svg",
      "country": "Saudi Arabia",
      "code": "sa"
    },
    {
      "image": "https://newsapi.org/images/flags/sg.svg",
      "country": "Singapore",
      "code": "sg"
    },
    {
      "image": "https://newsapi.org/images/flags/za.svg",
      "country": "South Africa",
      "code": "za"
    },
    {
      "image": "https://newsapi.org/images/flags/ch.svg",
      "country": "Switzerland",
      "code": "ch"
    },
    {
      "image": "https://newsapi.org/images/flags/th.svg",
      "country": "Thailand",
      "code": "th"
    },
    {
      "image": "https://newsapi.org/images/flags/ae.svg",
      "country": "UAE",
      "code": "ae"
    },
    {
      "image": "https://newsapi.org/images/flags/ua.svg",
      "country": "Ukraine",
      "code": "ua"
    },
    {
      "image": "https://newsapi.org/images/flags/gb.svg",
      "country": "United Kingdom",
      "code": "gb"
    },
    {
      "image": "https://newsapi.org/images/flags/us.svg",
      "country": "United States",
      "code": "us"
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<NewsListBloc>(context);
    loadingAdditionalResults = false;
    total = 0;
    greeting().then((value) {
      setState(() {
        greetings = value;
      });
    });
  }

  Future<String> greeting() async {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  void _showBottomSheetForCountry(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1,
                builder: (_, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.grey[600],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: Center(child: Text('Choose your Country')),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            controller: controller, //kill scrollable
                            shrinkWrap: true,
                            itemCount: countryList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return CountryListBlock(
                                  postBloc: _postBloc,
                                  countryList: countryList,
                                  index: index);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheetForLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 0.6,
                builder: (_, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.grey[600],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: Center(
                                child: Text('Choose your Preferred Language')),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            controller: controller, //kill scrollable
                            shrinkWrap: true,
                            itemCount: countryCode.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2, crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              randomColors =
                                  Random().nextInt(colorsList.length);
                              return LanguageListBlock(
                                  postBloc: _postBloc,
                                  countryCode: countryCode,
                                  colorsList: colorsList,
                                  randomColors: randomColors,
                                  index: index);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$greetings',
                      style: TextStyle(
                          fontFamily: 'quicksand_semibold', fontSize: 18),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _showBottomSheetForCountry(context);
                            },
                            icon: Image.asset(
                              'assets/images/country-removebg-preview.png',
                              height: 25,
                              width: 25,
                              fit: BoxFit.fill,
                            )),
                        IconButton(
                            onPressed: () {
                              _showBottomSheetForLanguage(context);
                            },
                            icon: Image.asset(
                              'assets/images/lang.png',
                              height: 28,
                              width: 28,
                              fit: BoxFit.fill,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.25,
                    height: 40,
                    color: const Color(0xffD8D9D9),
                    padding: const EdgeInsets.only(left: 8),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'montserrat_Medium'),
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Search for articles...',
                        hintStyle: TextStyle(
                            fontFamily: 'gotham_medium',
                            letterSpacing: 1.5,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          _postBloc!.add(Query(
                              params: _searchController.text,
                              source: 'SEARCH'));
                        }
                      },
                      icon: Icon(
                        Icons.search_outlined,
                        size: 30,
                      ))
                ],
              ),
            ],
          ),
        ),
        Expanded(
            child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(top: 25, bottom: 15, left: 12),
                    child: Text(
                      'News Feed',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Montserrat-Bold',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<NewsListBloc, NewsListState>(
                bloc: _postBloc,
                //child: BlocBuilder<ProductListBloc, ProductListState>(
                builder: (BuildContext context, NewsListState state) {
                  final Size size = MediaQuery.of(context).size;
                  final double itemWidth = size.width / 2 - 8;
                  final double itemHeight = itemWidth * (3 / 2) + 90;

                  if (state is NewsListError) {
                    if (state.error != null) {
                      return SliverToBoxAdapter(
                        child: Center(
                            child: Text(
                          '${state.error}',
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                              color: Colors.red.shade200,
                              fontFamily: 'quicksand_regular'),
                        )),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: Center(
                          child: Text(
                        'failed to fetch posts',
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1,
                            color: Colors.red.shade200,
                            fontFamily: 'quicksand_regular'),
                      )),
                    );
                  }

                  if (state is NewsListLoaded) {
                    if (state.posts!.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                            child: Text(
                          'Loading...',
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                              color: Colors.red.shade200,
                              fontFamily: 'quicksand_regular'),
                        )),
                      );
                    }

                    if (state.loadingAdditionalResults!) {
                      if (!loadingAdditionalResults!) {
                        WidgetsBinding.instance!
                            .addPostFrameCallback((_) => setState(() {
                                  loadingAdditionalResults = true;
                                }));
                      }
                    } else {
                      if (loadingAdditionalResults!) {
                        WidgetsBinding.instance!
                            .addPostFrameCallback((_) => setState(() {
                                  loadingAdditionalResults = false;
                                }));
                      }
                    }
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.35,
                      ),
                      delegate:
                          SliverChildBuilderDelegate((BuildContext c, int i) {
                        return i >= state.posts!.length
                            ? const Text('')
                            : HomescreenBlock(
                                index: i,
                                modelResponse: state.posts,
                              );
                      }, childCount: state.posts!.length),
                    );
                  }
                  return SliverToBoxAdapter(
                      child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
                }),
            loadingAdditionalResults!
                ? SliverToBoxAdapter(
                    child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    child: Center(
                      child: const SizedBox(
                        width: 33.0,
                        height: 33.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                    ),
                  ))
                : const SliverToBoxAdapter()
          ],
        )),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold!) {
      _postBloc!.add(Fetch());
    }
  }
}
