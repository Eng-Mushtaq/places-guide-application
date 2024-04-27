import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:places/global/global.dart';
import 'package:places/home/drawer/drawer.dart';
import 'package:places/home/hotels/near_hotel.dart';
import 'package:places/home/places/caousel_places.dart';
import 'package:places/home/places/near_place.dart';
import 'package:places/home/restaurent/csrousel_restaurent.dart';
import 'package:places/home/restaurent/near_restatutent.dart';

import '../authintication/styles/app_colors.dart';
import '../authintication/utils/constants.dart';
import 'hotels/carousel_hotels.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  bool isSliding = false;

  String? selectedItem = sharedPreferences!.getString('place') ?? 'place';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();

    setStatusBarColor(
      Colors.blueGrey.shade50,
    );
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      "Places",
      "Restaurants",
      "Hotels",
    ];
    return Scaffold(
      //floatingActionButtonAnimator: ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isSliding
          ? ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.menu),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.deepPurple;
                  }
                  return null; // <-- Splash color
                }),
              ),
            )
          : null,
      key: _scaffoldKey,
      drawer: const Drawer(
        child: NavigationDrawerWidget(),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.blueGrey.shade50,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      Expanded(
                          child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('Search Places'),
                          RotateAnimatedText('Restaurents'),
                          RotateAnimatedText(
                            'Hotels & More',
                          ),
                        ],
                        totalRepeatCount: 20,
                        isRepeatingAnimation: true,
                        // pause: const Duration(milliseconds: 1000),
                        //displayFullTextOnTap: true,
                        //stopPauseOnTap: true,
                      )),
                      IconButton(
                        icon: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  automaticIndicatorColorAdjustment: true,
                  controller: _tabController,
                  isScrollable: false,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      border: Border.all(width: 2.0, color: Colors.deepPurple),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0))),
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    for (final tab in tabs)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: tab),
                      )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        const PlacesTab(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'More places to visit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: NotificationListener<UserScrollNotification>(
                            onNotification: ((notification) {
                              if (notification.direction ==
                                  ScrollDirection.forward) {
                                if (!isSliding) {
                                  setState(() {
                                    isSliding = true;
                                  });
                                }
                              } else if (notification.direction ==
                                  ScrollDirection.reverse) {
                                if (isSliding) {
                                  setState(() {
                                    isSliding = false;
                                  });
                                }
                              }
                              return isSliding;
                            }),
                            child: const NearPlace(),
                          ),
                        ),
                      ],
                    ),
                    //TODOS: RESTAURENT IMPLEMENTATION
                    Column(
                      children: [
                        const CarouselRestaurent(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'More places to visit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: NotificationListener<UserScrollNotification>(
                            onNotification: ((notification) {
                              if (notification.direction ==
                                  ScrollDirection.forward) {
                                if (!isSliding) {
                                  setState(() {
                                    isSliding = true;
                                  });
                                }
                              } else if (notification.direction ==
                                  ScrollDirection.reverse) {
                                if (isSliding) {
                                  setState(() {
                                    isSliding = false;
                                  });
                                }
                              }
                              return isSliding;
                            }),
                            child: const NearRestaurentPlace(),
                          ),
                        ),
                      ],
                    ),
                    //TODOS: Hotel IMPLEMENTATION
                    // second tab bar view widget
                    Column(
                      children: [
                        const CarouselHotel(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'More places to visit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: NotificationListener<UserScrollNotification>(
                            onNotification: ((notification) {
                              if (notification.direction ==
                                  ScrollDirection.forward) {
                                if (!isSliding) {
                                  setState(() {
                                    isSliding = true;
                                  });
                                }
                              } else if (notification.direction ==
                                  ScrollDirection.reverse) {
                                if (isSliding) {
                                  setState(() {
                                    isSliding = false;
                                  });
                                }
                              }
                              return isSliding;
                            }),
                            child: const NearHotel(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
