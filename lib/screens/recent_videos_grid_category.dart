import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sudo_task/bloc/Recent_videos/recent_list_bloc.dart';
import 'package:sudo_task/bloc/Recent_videos/recent_list_event.dart';
import 'package:sudo_task/bloc/Recent_videos/recent_list_state.dart';
import 'package:sudo_task/resources/api_provider_home.dart';
import 'package:sudo_task/widgets/recent_videos_grid/block.dart';

class RecentGridCategoryScreen extends StatefulWidget {
  RecentGridCategoryScreen(this.languageId, {Key? key}) : super(key: key);

  String languageId;

  @override
  _RecentGridCategoryScreenState createState() =>
      _RecentGridCategoryScreenState(languageId);
}

class _RecentGridCategoryScreenState extends State<RecentGridCategoryScreen> {
  _RecentGridCategoryScreenState(this.languageId);

  String languageId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocProvider<RecentListBloc>(
          create: (BuildContext context) =>
              RecentListBloc(params: "in", sources: 'COUNTRY')..add(Fetch()),
          child: HomePage(),
        ),
      ),
    );
  }
}

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
  RecentListBloc? _postBloc;
  int pageCount = 1;
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  String greetings = '';

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
    _postBloc = BlocProvider.of<RecentListBloc>(context);
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
                              return GestureDetector(
                                onTap: () {
                                  _postBloc!.add(Query(
                                      params: countryList[index]['code'],
                                      source: 'COUNTRY'));
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    elevation: 2,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          child: SvgPicture.network(
                                            '${countryList[index]['image']}',
                                            fit: BoxFit.fill,
                                            height: 130,
                                            width: double.infinity,
                                            placeholderBuilder: (BuildContext
                                                    context) =>
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
                                                    child:
                                                        const CircularProgressIndicator()),
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8)),
                                        ),
                                        SizedBox(height: 18),
                                        Text('${countryList[index]['country']}')
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
                              return GestureDetector(
                                onTap: () {
                                  print('');
                                  _postBloc!.add(Query(
                                      params: countryList[index]['code'],
                                      source: 'LANGUAGE'));
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 2,
                                    child: Center(
                                      child: Text(
                                          '${countryCode[index]['language']}'),
                                    ),
                                  ),
                                ),
                              );
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
                    Text('$greetings'),
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
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'montserrat_Medium'),
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Search for articles',
                        hintStyle: TextStyle(
                            fontFamily: 'montserrat_Medium',
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (_emailController.text.isNotEmpty) {
                          _postBloc!.add(Query(
                              params: _emailController.text, source: 'SEARCH'));
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: Text(
                      'News Feed',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Montserrat-Bold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<RecentListBloc, RecentListState>(
                bloc: _postBloc,
                //child: BlocBuilder<ProductListBloc, ProductListState>(
                builder: (BuildContext context, RecentListState state) {
                  final Size size = MediaQuery.of(context).size;
                  final double itemWidth = size.width / 2 - 8;
                  final double itemHeight = itemWidth * (3 / 2) + 90;

                  if (state is RecentListError) {
                    if (state.error != null) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text('${state.error}')),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: Center(child: Text('failed to fetch posts')),
                    );
                  }

                  if (state is RecentListLoaded) {
                    if (state.posts!.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(child: Text('no posts')),
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
                        childAspectRatio: 1.4,
                      ),
                      delegate:
                          SliverChildBuilderDelegate((BuildContext c, int i) {
                        return i >= state.posts!.length
                            ? const Text('')
                            : RecentVideosGridCategoryblock(
                                index: i,
                                modelResponse: state.posts,
                              );
                      }, childCount: state.posts!.length),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: Container(
                      child: CircularProgressIndicator(),
                      height: size.height,
                    ),
                  );
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
