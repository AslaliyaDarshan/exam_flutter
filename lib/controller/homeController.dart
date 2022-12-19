import 'package:databaseapp/model/modelClass.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Map> studentList = <Map>[].obs;
  ModelClass? modelClass;
  RxBool visible = true.obs;
  List<ModelClass> dataList = [];
}
