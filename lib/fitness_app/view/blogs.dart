// ignore_for_file: dead_code

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/view/admin/view_blog_admin.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/get_di.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Blog {
  final String title;
  final String subtitle;
  final String createdAt;
  final String createdBy;

  Blog(this.title, this.subtitle, this.createdAt, this.createdBy);
}

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  final CollectionReference userRequest =
      FirebaseFirestore.instance.collection('Blogs');
  List<Blog> blogs = [];
  List<Blog> filteredBlogs = [];
  TextEditingController controller = TextEditingController();
  String selectedValue = 'All';
  List<String> dropdownItems = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks'
  ];
  final List<String> allFoods = [
    'Pizza',
    'Sushi',
    'Spaghetti',
    'Hamburger',
    'Tacos',
    'Salad',
    'Fried Chicken',
    'Ice Cream',
    'Pancakes',
    'Steak',
  ];

  List<String> filteredFoods = [];
  @override
  void initState() {
    fetchBlogs();
    super.initState();
    filteredFoods = allFoods;
  }

  Future<void> fetchBlogs() async {
    final QuerySnapshot blogSnapshot =
        await firestore.collection('Blogs').get();
    blogs = blogSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Blog(data['title'], data['subTitle'], data['created_at'],
          data['createdBy']);
    }).toList();
    setState(() {
      filteredBlogs = blogs;
    });
  }

  void filterBlogs(String query) {
    setState(() {
      filteredBlogs = blogs
          .where(
              (blog) => blog.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterFoods(String query) {
    setState(() {
      controller.text = query;
      filteredFoods = allFoods
          .where((food) => food.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log('Insidee blogs page');
    AppSizes().init(context);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Column(
        children: [
          SizedBox(
            height: size.width * 0.1,
          ),
          // SizedBox(
          //   height: AppSizes.screenHeight * 0.29,
          //   width: AppSizes.screenWidth,
          //   child: Stack(
          //     children: [
          //       SizedBox(
          //           height: double.infinity,
          //           width: double.infinity,
          //           child: Image.asset(
          //             "assets/images/pexels-dziana-hasanbekava-7809735.jpg",
          //             fit: BoxFit.fill,
          //           )),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: TextFormField(
          //             style: const TextStyle(color: AppColors.bgGray),
          //             controller: controller,
          //             cursorColor: AppColors.bgGray,

          //             decoration: InputDecoration(
          //               prefixIcon: const Icon(
          //                 Icons.search,
          //                 color: AppColors.bgGray,
          //               ),
          //               hintText: "Search for fitness tips",
          //               filled: true,
          //               fillColor: AppColors.kWhite,
          //               hintStyle: const TextStyle(color: AppColors.bgGray),
          //               enabledBorder: OutlineInputBorder(
          //                 borderSide: const BorderSide(
          //                     color: AppColors.bgGray), //<-- SEE HERE
          //                 borderRadius: BorderRadius.circular(24),
          //               ),
          //               focusedBorder: OutlineInputBorder(
          //                 borderSide: const BorderSide(
          //                     color: AppColors.bgGray), //<-- SEE HERE
          //                 borderRadius: BorderRadius.circular(24),
          //               ),
          //             ),
          //             onChanged: (query) {
          //               filterBlogs(query);
          //             },
          //             // onChanged: (query){
          //             //   setState(() {
          //             //     controller.text=query;
          //             //     // filteredFoods = allFoods
          //             //     //     .where((food) => food.toLowerCase().contains(query.toLowerCase()))
          //             //     //     .toList();
          //             //   });
          //             // },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Row(
          //   children: [
          //    const Text(
          //       "View  ",
          //       style: styledText,
          //     ),
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         DropdownButton<String>(
          //           value: selectedValue,
          //           onChanged: (newValue) {
          //             setState(() {
          //               selectedValue = newValue!;
          //             });
          //           },
          //           items: dropdownItems.map((String item) {
          //             return DropdownMenuItem<String>(
          //               value: item,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                 const  SizedBox(
          //                     height: 16,
          //                   ),
          //                   Text(
          //                     item,
          //                     style:const TextStyle(color: Colors.white), // White text
          //                   ),
          //                   const Divider(
          //                     color: Colors.grey,
          //                   )
          //                 ],
          //               ),
          //             );
          //           }).toList(),
          //           style:const TextStyle(
          //             // backgroundColor: Colors.black, // Black background
          //             color:
          //            Colors.red, // White text for the selected item
          //           ),
          //           dropdownColor: AppColors
          //               .kGreyShade,
          //           iconEnabledColor: AppColors.kGrey,
          //           // icon: SizedBox(),
          //           // Black background for dropdown menu
          //           underline: const SizedBox(),
          //         )
          //       ],
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "Heath ,Wellness and Goals",
          //     style: styledText.copyWith(fontSize: 22),
          //   ),
          // ),
          Expanded(
            child: filteredBlogs.isEmpty
                ? Center(
                    child: Text(
                    'No data available',
                    style: styledText.copyWith(fontSize: 18),
                  ))
                : ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final blog = filteredBlogs[index];

                      String timestamp = blog.createdAt.toString();
                      DateTime dateTime = DateTime.parse(timestamp);
                      String formattedTime = DateFormat.jm().format(
                          dateTime); // Format to 12-hour time with AM/PM

                      return true
                          ? Material(
                              elevation: 4,
                              color: AppColors.bgGray,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                  width: double.maxFinite, // Set maximum width

                                  decoration: BoxDecoration(
                                      color: AppColors.bgGray,
                                      borderRadius: BorderRadius.circular(8)),
                                  height: size.height * 0.5,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        height: size.width * 0.4,
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/img_image_8_123x320.png')),
                                            color: AppColors.kGrey,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ListTile(
                                            horizontalTitleGap: 2,
                                            leading: CircleAvatar(
                                              maxRadius: 16,
                                              minRadius: 16,
                                              child: Image.asset(
                                                  'assets/images/img_contact_list.png'),
                                            ),
                                            title: Text(
                                              blog.createdBy,
                                              style: styledText.copyWith(
                                                  color: AppColors.primaryBlue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            trailing: Text(
                                              formattedTime,
                                              style: styledText.copyWith(
                                                  color: AppColors.tertiaryGray,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.5),
                                            )),
                                      ),
                                      ListTile(
                                        title: Text(
                                          blog.title,
                                          style: styledText.copyWith(
                                              color: AppColors.primaryGreen,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          '${blog.subtitle}It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                                          maxLines: 5,
                                          textAlign: TextAlign.justify,
                                          textScaleFactor: 1.1,
                                          style: styledText.copyWith(
                                              fontSize: 14,
                                              color:
                                                  AppColors.tertiaryBlackText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton(
                                                onPressed: () {
                                                  Get.to(() => ViewBlogAdmin(
                                                        title: blog.title,
                                                        subTitle: blog.subtitle,
                                                        created: formattedTime,
                                                        createdBy:
                                                            blog.createdBy,
                                                      ));
                                                },
                                                child: Text(
                                                  'Read more',
                                                  style: styledText.copyWith(
                                                      color: AppColors
                                                          .primaryGreen,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          : Card(
                              child: ListTile(
                                title: Text(blog.title),
                                subtitle: Text(blog.subtitle),
                                trailing: Text(blog.createdAt.toString()),
                              ),
                            );
                    },
                  ),
          ),
          // true?
          // Expanded(
          //   child: Container(
          //     padding:
          //     EdgeInsets.all(AppSizes.appHorizontalXs),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5),
          //         border:
          //         Border.all(color: AppColors.kLightBlue)),
          //     child: Column(
          //       children: [
          //         Expanded(
          //             child: StreamBuilder<QuerySnapshot>(
          //               // stream: rejectStream,
          //               stream: FirebaseFirestore.instance.collection('Blogs').where('title', isGreaterThanOrEqualTo: controller.text.trim()).snapshots(),
          //               builder: (BuildContext context,
          //                   AsyncSnapshot<QuerySnapshot>
          //                   snapshot) {
          //                 if (snapshot.hasError) {
          //                   return const Text('Something went wrong');
          //                 }
          //                 if (snapshot.connectionState == ConnectionState.waiting) {
          //                   return const Center(child: Text('Loading...'));
          //                 }
          //                 print("=========== documents ${snapshot.data!.docs.length}");
          //                 List<QueryDocumentSnapshot>documents = snapshot.data!.docs;
          //                 return documents.isEmpty
          //                     ?  Center(
          //                   child: Text("No Topic Added Yet",style: styledText.copyWith(fontSize: 32),),
          //                 )
          //                     :
          //
          //                 ListView.builder(
          //                   itemCount: documents.length,
          //                   itemBuilder: (BuildContext context, int index) {
          //                     // Extract the data for each document
          //                     Map<String, dynamic> data =
          //                     documents[index].data() as Map<String, dynamic>;
          //                     print("-============== time ${data["created_at"]}");
          //                     String timestamp = data["created_at"];
          //                     DateTime dateTime = DateTime.parse(timestamp);
          //                     String formattedTime = DateFormat.jm().format(dateTime); // Format to 12-hour time with AM/PM
          //                     print(formattedTime);
          //                     return
          //
          //                     InkWell(
          //                       onTap:(){
          //                         Get.to(()=>ViewBlogAdmin(title:data["title"] ,subTitle:data["subTitle"] ,created: formattedTime,));
          //                       },
          //                       child: Column(
          //                         children: [
          //                           Container(
          //                             color:AppColors. kDarkBlue,
          //                             height: AppSizes.screenHeight*0.3,
          //                             child: Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: SizedBox(
          //                                 child: Column(
          //                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                                   crossAxisAlignment: CrossAxisAlignment.start,
          //                                   children: [
          //                                     Text(data["title"],style: styledText.copyWith(fontSize: 20,fontWeight: FontWeight.bold),),
          //                                     Text(data["subTitle"],style: styledText.copyWith(),),
          //                                     Row(
          //                                       mainAxisAlignment: MainAxisAlignment.end,
          //                                       children: [
          //                                         Text(formattedTime,textAlign: TextAlign.end,style: styledText.copyWith(),),
          //                                         const   SizedBox(width: 4,),
          //                                         const Icon(Icons.timer_outlined,color: AppColors.kGrey,size: 16,)
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                           const Divider(color: Colors.white,)
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 );
          //               },
          //             ))
          //       ],
          //     ),
          //   ),
          // )
          //     :  Expanded(
          //     child: SingleChildScrollView(
          //         child:
          //
          //         Column(
          //       children: List.generate(
          //           filteredFoods.length,
          //           (index) => Column(
          //             children: [
          //               SizedBox(
          //                 height: AppSizes.screenHeight*0.3,
          //                 child: Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: SizedBox(
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           children: [
          //                             Text("Introduce Your Self",style: styledText.copyWith(fontSize: 16,fontWeight: FontWeight.bold),),
          //                             Text("If you're new to MyFitnessPal please post a message here and say hello!",style: styledText.copyWith(),),
          //                             Text(
          //                               filteredFoods[index].toString(),
          //                               style: styledText,
          //                             ),
          //                             Row(
          //                               mainAxisAlignment: MainAxisAlignment.end,
          //                               children: [
          //                                 Text("4:35 pm",textAlign: TextAlign.end,style: styledText.copyWith(),),
          //                                 SizedBox(width: 4,),
          //                                 Icon(Icons.timer_outlined,color: AppColors.kGrey,size: 16,)
          //                               ],
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //               ),
          //               Divider(color: Colors.white,)
          //             ],
          //           )),
          //     )),
          //   )
        ],
      ),
    );
  }
}
