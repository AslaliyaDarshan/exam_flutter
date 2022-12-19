import 'package:databaseapp/controller/homeController.dart';
import 'package:databaseapp/model/modelClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SecondScreen"),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Text("Buy")),
      body: ListView.builder(
          itemCount: homeController.dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              subtitle: Text("${homeController.dataList[index].name}"),
              title: Text("${homeController.dataList[index].quantity}"),
            );
          }),
    );
  }
}
