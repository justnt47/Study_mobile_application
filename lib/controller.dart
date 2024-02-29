import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class dataController extends GetxController {
  var doc_id = null;

  @override
  void oninit() {
    super.onInit();
    var data = Get.parameters;
    doc_id = data['doc_id'];
  }

  printDoc() async {
    var result = await FirebaseFirestore.instance
        .collection("Users")
        .doc(doc_id)
        .collection("MyBookMark")
        .where("isBooked", isEqualTo: true)
        .get();

    print("result: ${result.docs.length}");
  }
}
