// ignore_for_file: dead_code

import 'dart:developer';

import 'package:fitness_app/fitness_app/view/admin/create_recipe.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

///search field
class FilteredDataList extends StatefulWidget {
  const FilteredDataList({super.key});

  @override
  _FilteredDataListState createState() => _FilteredDataListState();
}

class _FilteredDataListState extends State<FilteredDataList> {
  String searchText = '';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: searchController,
          decoration: const InputDecoration(labelText: 'Search'),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Blogs')
                .where('title', isGreaterThanOrEqualTo: searchText)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  // Build your list items here using documents[index]
                  return ListTile(
                    title: Text(documents[index]['title']),
                    // subtitle: Text(documents[index]['subTitle']),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// fetch from firestore and show in dropdown

class AdminCategoryTest extends StatefulWidget {
  const AdminCategoryTest({super.key});

  @override
  _AdminCategoryTestState createState() => _AdminCategoryTestState();
}

class _AdminCategoryTestState extends State<AdminCategoryTest> {
  String? selectedValue;
  List<String> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<String> data = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Category').get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic>? documentData =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (documentData != null && documentData.containsKey('category')) {
        String fieldValue = documentData['category'];
        // ignore: unnecessary_null_comparison
        if (fieldValue != null) {
          data.add(fieldValue);
        }
      }
    }

    setState(() {
      dropdownItems = data;
      selectedValue = data.isNotEmpty ? data[0] : "All";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Dropdown Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Select an item:'),
            DropdownButton<String>(
              value: selectedValue,
              items: dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

///fetch from multiCollection

class SubcollectionStream extends StatelessWidget {
  const SubcollectionStream({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        FirebaseFirestore.instance.collection('Recipe').get();
    snapshot.then((value) => log("=========== snapshot ${value.docs}"));

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Category').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            // Process and display data from the breakfast subcollection
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String breakfastItemName = data['category'];

                return true
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(breakfastItemName)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const SizedBox();
                            // Center(child: Text('No data available'));
                          }

                          // Process and display data from the breakfast subcollection
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(breakfastItemName),
                                  const Text("View More")
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data =
                                        document.data() as Map<String, dynamic>;
                                    String breakfastItemName = data['title'];
                                    return Text(breakfastItemName);
                                    // Add more widgets to display other breakfast data as needed
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : ListTile(
                        title: Text(breakfastItemName),
                        // Add more widgets to display other breakfast data as needed
                      );
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.kWhite,
          onPressed: () {
            Get.to(() => const CreateRecipe());
          },
          child: const Icon(
            Icons.create_outlined,
            color: AppColors.lightGrey,
          ),
        ));
  }
}

///upload file to storage and save to fire store

class UploadImageToDB extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  UploadImageToDB({super.key});

  Future<void> pickImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(
        source: ImageSource
            .gallery); // You can also use ImageSource.camera for the camera

    if (pickedFile != null) {
      final imageUrl = await uploadImageToStorage(pickedFile.path);
      await saveImageReferenceToFirestore(imageUrl);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No image selected')));
    }
  }

  Future<String> uploadImageToStorage(String filePath) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('image_name.jpg'); // Replace with your own naming strategy

    UploadTask uploadTask = storageReference.putFile(File(filePath));

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    if (taskSnapshot.state == TaskState.success) {
      return await storageReference.getDownloadURL();
    } else {
      throw 'Failed to upload image';
    }
  }

  Future<void> saveImageReferenceToFirestore(String imageUrl) async {
    CollectionReference images = FirebaseFirestore.instance
        .collection('images'); // Replace with your Firestore collection name

    await images.add({
      'imageUrl': imageUrl,
      // You can add more fields to your document as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => pickImage(context),
          child: const Text('Pick and Upload Image'),
        ),
      ),
    );
  }
}
