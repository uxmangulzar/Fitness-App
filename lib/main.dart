import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/fitness_app/openAi/model/chatmodel.dart';

import 'package:fitness_app/fitness_app/view/splash_screen.dart';
import 'package:fitness_app/provider/days_provider.dart';
import 'package:fitness_app/provider/profile_provider.dart';
import 'package:fitness_app/provider/recipe_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/view/calories_page.dart';
import 'package:fitness_app/view/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DaysProvider()),
          ChangeNotifierProvider(create: (_) => RecipeProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => ChatModel()),
        ],
        child: const GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home:
                // SignUpScreen()
                // LogInScreen(),
                // OnboardingScreen()
                SplashScreen()
            // UploadImageToDB()
            // AdminHome()
            // HomePage()
            // AnimatedBottomNavigationBar(),
            ),
      ),
    );
  }
}

class AnimatedBottomNavigationBar extends StatefulWidget {
  const AnimatedBottomNavigationBar({super.key});

  @override
  _AnimatedBottomNavigationBarState createState() =>
      _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState
    extends State<AnimatedBottomNavigationBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.kLightBlack,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: <Widget>[
              const CaloryPage(),
              // RecipiePage(),
              const TestApp(),
              Container(
                color: Colors.orange,
                child: const Center(
                  child: Text('Page 3'),
                ),
              ),
              Container(
                color: Colors.orange,
                child: const Center(
                  child: Text('Page 4'),
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: AppColors.kPrimary,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(
                        bottom: 16, left: 16, right: 16, top: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            _onItemTapped(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.kLightBlack),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/bottom_icons/calories.png",
                                    height: 40,
                                    color: Colors.white,
                                  ),
                                  // const Icon(Icons.home,color: Colors.white,),
                                  _currentIndex == 0
                                      ? const Text(
                                          "Calories",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            _onItemTapped(1);
                          },
                          child: Container(
                            // padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.kLightBlack),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/bottom_icons/recipie.png",
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                  _currentIndex == 1
                                      ? const Padding(
                                          padding: EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            "Recipe",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            _onItemTapped(2);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.kLightBlack),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/bottom_icons/blogs.png",
                                  height: 40,
                                  color: Colors.white,
                                ),
                                _currentIndex == 2
                                    ? const Text(
                                        "Blogs",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            _onItemTapped(3);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.kLightBlack),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(
                                      "assets/bottom_icons/support.png",
                                      height: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                  _currentIndex == 3
                                      ? const Padding(
                                          padding: EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            "Support",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ))
        ],
      ),
      // bottomNavigationBar: true
      //     ?
      //
      // Container(
      //         decoration: BoxDecoration(
      //             color: AppColors.kPrimary, borderRadius: BorderRadius.circular(10)),
      //         margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16,top: 16),
      //         padding:const EdgeInsets.symmetric(horizontal:8,vertical: 16),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             InkWell(
      //               splashColor: Colors.white,
      //               onTap: (){
      //                 _onItemTapped(0);
      //                 },
      //               child:  Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10),
      //                     color: AppColors.kLightBlack),
      //                 child: Padding(
      //                   padding: const EdgeInsets.only(right: 4.0),
      //                   child: Row(
      //                     children: [
      //                       Image.asset("assets/bottom_icons/calories.png",height: 40,color: Colors.white,),
      //                      // const Icon(Icons.home,color: Colors.white,),
      //                       _currentIndex==0? const Text("Calories",style: TextStyle(fontSize: 20,color:Colors.white),):SizedBox(),
      //
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //
      //             InkWell(
      //               splashColor: Colors.white,
      //               onTap: (){
      //                 _onItemTapped(1);
      //               },
      //               child:  Container(
      //                 // padding: EdgeInsets.all(4),
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10),
      //                     color:AppColors.kLightBlack),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(4.0),
      //                   child: Row(
      //                     children: [
      //                       Image.asset("assets/bottom_icons/recipie.png",height: 30,color: Colors.white,),
      //                       _currentIndex==1? Padding(
      //                         padding: const EdgeInsets.only(left:4.0),
      //                         child: const Text("Recipe",style: TextStyle(fontSize: 20,color:Colors.white),),
      //                       ):SizedBox(),
      //
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             InkWell(
      //               splashColor: Colors.white,
      //               onTap: (){
      //                 _onItemTapped(2);
      //               },
      //               child:  Container(
      //                 padding: EdgeInsets.only(right:4),
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10),
      //                     color:AppColors.kLightBlack),
      //                 child: Row(
      //                   children: [
      //                     Image.asset("assets/bottom_icons/blogs.png",height: 40,color: Colors.white,),
      //                     _currentIndex==2? const Text("Blogs",style: TextStyle(fontSize: 20,color:Colors.white),):SizedBox(),
      //
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             InkWell(
      //               splashColor: Colors.white,
      //               onTap: (){
      //                 _onItemTapped(3);
      //               },
      //               child:  Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10),
      //                     color:AppColors.kLightBlack),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(4.0),
      //                   child: Row(
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.all(2.0),
      //                         child: Image.asset("assets/bottom_icons/support.png",height: 26,color: Colors.white,),
      //                       ),
      //                       _currentIndex==3? Padding(
      //                         padding: const EdgeInsets.only(left: 4.0),
      //                         child: const Text("Support",style: TextStyle(fontSize: 20,color:Colors.white),),
      //                       ):SizedBox(),
      //
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //
      //           ],
      //         ))
      //     :
      //     BottomNavigationBar(
      //         currentIndex: _currentIndex,
      //         onTap: _onItemTapped,
      //         items: [
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.home),
      //             label: 'Home',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.search),
      //             label: 'Search',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.person),
      //             label: 'Profile',
      //           ),
      //         ],
      //       ),
    );
  }
}
