import 'package:databaseapp/controller/dbHelper.dart';
import 'package:databaseapp/controller/homeController.dart';
import 'package:databaseapp/model/modelClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    DbHelper db = DbHelper();
    homeController.studentList.value = await db.readData();
  }

  TextEditingController txtName = TextEditingController();
  TextEditingController txtQuality = TextEditingController();
  TextEditingController txtImage = TextEditingController();
  TextEditingController uTxtName = TextEditingController();
  TextEditingController uTxtQuality = TextEditingController();
  TextEditingController uTxtImage = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Database App"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                if (homeController.visible.value == true) {
                  homeController.visible.value = false;
                  Get.defaultDialog(
                      title: 'Alert',
                      content: Text(
                          "You have only 30 seconds\n to select any item"));
                } else if (homeController.visible.value == false) {
                  homeController.visible.value = true;
                }
                print(homeController.visible.value);
              },
              icon: Icon(Icons.timer)),
          actions: [
            IconButton(
              onPressed: () {
                homeController.visible.value = true;
              },
              icon: Icon(Icons.restart_alt),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed('/second');
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // homeController.visible.value = true;
            Get.defaultDialog(
              content: Column(
                children: [
                  TextField(
                    controller: txtName,
                    decoration:
                        const InputDecoration(hintText: " Product Name"),
                  ),
                  TextField(
                    controller: txtQuality,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Quantity",
                    ),
                  ),
                  // TextField(
                  //   controller: txtImage,
                  //   decoration:
                  //       const InputDecoration(hintText: "Paste Image Url..."),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      DbHelper db = DbHelper();
                      db.insertData(
                          txtName.text, txtQuality.text, txtImage.text);
                      getData();
                      txtName.clear();
                      txtQuality.clear();
                      txtImage.clear();
                      Get.back();
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            );
          },
        ),
        body: Obx(
          () => AnimatedOpacity(
            duration: Duration(seconds: 30),
            opacity: homeController.visible.value == true ? 1.0 : 0.0,
            child: ListView.builder(
              itemCount: homeController.studentList.value.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // if (homeController.dataList.length == 0) {
                    //   homeController.dataList.add(homeController.modelClass!);
                    // } else {
                    //   for (int i = 0; i < homeController.dataList.length; i++) {
                    //     if (homeController.dataList[i].name !=
                    //         homeController.dataList[i].name) {
                    //       homeController.dataList.add(homeController.modelClass!);
                    //     } else {
                    //       Get.defaultDialog(title: 'Alert',content: Text("Sorry"));
                    //     }
                    //   }
                    // }
                    homeController.visible.value = true;
                    homeController.modelClass = ModelClass(
                        name: homeController.studentList.value[index]["name"],
                        quantity: homeController.studentList.value[index]
                            ["quantity"]);
                    homeController.dataList.add(homeController.modelClass!);
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.image,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                    title: Text(
                        "${homeController.studentList.value[index]["id"]}"),
                    subtitle: Text(
                        "${homeController.studentList.value[index]["name"]}"),
                    trailing: SizedBox(
                      width: 120,
                      child: Row(
                        children: [
                          Text(
                              "${homeController.studentList.value[index]["quantity"]}"),
                          IconButton(
                              onPressed: () {
                                uTxtName = TextEditingController(
                                    text:
                                        "${homeController.studentList.value[index]["name"]}");
                                uTxtQuality = TextEditingController(
                                    text:
                                        "${homeController.studentList.value[index]["quantity"]}");
                                // uTxtImage = TextEditingController(
                                //     text:
                                //         "${homeController.studentList.value[index]["image"]}");
                                Get.defaultDialog(
                                  content: Column(
                                    children: [
                                      TextField(
                                        controller: uTxtName,
                                        decoration: const InputDecoration(
                                            hintText: " Product Name"),
                                      ),
                                      TextField(
                                        controller: uTxtQuality,
                                        decoration: const InputDecoration(
                                            hintText: "quantity"),
                                      ),
                                      // TextField(
                                      //   controller: uTxtImage,
                                      //   decoration: const InputDecoration(
                                      //       hintText: "Paste Image Url..."),
                                      // ),
                                      ElevatedButton(
                                        onPressed: () {
                                          DbHelper db = DbHelper();
                                          db.updateData(
                                              "${homeController.studentList.value[index]["id"]}",
                                              uTxtName.text,
                                              uTxtQuality.text,
                                              uTxtImage.text);
                                          getData();
                                          Get.back();
                                        },
                                        child: const Text("Update"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                DbHelper db = DbHelper();
                                db.deleteData(
                                    "${homeController.studentList.value[index]["id"]}");
                                getData();
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
