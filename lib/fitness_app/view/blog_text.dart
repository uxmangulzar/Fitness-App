import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../commonWidget.dart';

class Blog {
  final String title;
  final String subtitle;
  final String createdAt;

  Blog(this.title, this.subtitle, this.createdAt);
}

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Blog> blogs = [];
  List<Blog> filteredBlogs = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    final QuerySnapshot blogSnapshot =
        await firestore.collection('Blogs').get();
    blogs = blogSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Blog(
        data['title'],
        data['subTitle'],
        data['created_at'],
      );
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

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
        backgroundColor: AppColors.bgGray,
        appBar: appBar(context, "My Fitness Pal"),
        body: SizedBox(
          height: AppSizes.screenHeight,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(labelText: 'Search by Blog Name'),
                  onChanged: (query) {
                    filterBlogs(query);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredBlogs.length,
                  itemBuilder: (context, index) {
                    final blog = filteredBlogs[index];
                    return ListTile(
                      title: Text(blog.title),
                      subtitle: Text(blog.subtitle),
                      trailing: Text(blog.createdAt.toString()),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
