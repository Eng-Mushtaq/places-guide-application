import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../global/global.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../utils/constants.dart';
import '../signin.dart';
import 'onboarding_contents.dart';
import 'size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  _storeToFirestore(
      {int? index,
      String? description,
      String? img,
      String? rating,
      String? title,
      String? charge}) async {
    // Assuming 'sharedPreferences' is already initialized and available
    String Place = sharedPreferences!.getString('place') ?? 'place';

    // Create a reference to the document
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('hotel_near')
        .doc('T8RZhZF8EmkEEdrGDaIc')
        .collection(Place)
        .doc(); // Create a new document

    // Data to store
    Map<String, dynamic> data = {
      "desc": description,
      "img": img,
      "rating": rating,
      "title": title,
      "charge": charge
    };

    // Store data in Firestore
    await docRef.set(data).then((_) {
      print('Data stored successfully!');
    }).catchError((error) {
      print('Failed to store data: $error');
    });
  }

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      setStatusBarColor(AppColors.whiteshade);
    });
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return Scaffold(
      // backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 40,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 55 : 25,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 25 : 30,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          contents[i].desc,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 17 : 20,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: ElevatedButton(
                            onPressed:
                                // () => _storeToFirestore(
                                // title: 'فندق إيفا إن ',
                                // description:
                                //     'Located in Abha, less than 1 km from Muftaha Palace Museum, فندق إيفا إن provides accommodation with a terrace, free private parking and a restaurant. This 4-star hotel offers room service, a 24-hour front desk and free WiFi. The property is non-smoking and is situated 1.7 km from Reservoir Park.The hotel will provide guests with air-conditioned rooms with a desk, a coffee machine, a fridge, a safety deposit box, a flat-screen TV, a balcony and a private bathroom with a bidet. At فندق إيفا إن every room comes with bed linen and towels.',
                                // charge: '300.00',
                                // img:
                                //     'https://cf.bstatic.com/xdata/images/hotel/max1024x768/486376914.jpg?k=4138405a5576555863d5f71eaba8479dddc7bfdf8c932b37c5f75b2924322c9d&o=&hp=1',
                                // rating: '5'),

                                () {
                              Get.to(() => Signin());
                            },
                            child: const Text(
                              "START",
                              style: KTextStyle.authButtonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: (width <= 550)
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 20)
                                  : EdgeInsets.symmetric(
                                      horizontal: width * 0.2, vertical: 25),
                              textStyle:
                                  TextStyle(fontSize: (width <= 550) ? 13 : 17),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                child: const Text(
                                  "SKIP",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: (width <= 550) ? 13 : 17,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const Text(
                                  "NEXT",
                                  style: KTextStyle.authButtonTextStyle,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                  padding: (width <= 550)
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 25),
                                  textStyle: KTextStyle.authButtonTextStyle
                                      .copyWith(
                                          fontSize: (width <= 550) ? 13 : 17),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
