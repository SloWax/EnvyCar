import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Util/CarManager.dart';

class FirebaseManager {
  // 정적 변수로 싱글톤 인스턴스를 저장
  static final FirebaseManager _instance = FirebaseManager._internal();

  // 팩토리 생성자는 기존 인스턴스를 반환
  factory FirebaseManager() {
    return _instance;
  }

  // private 생성자로 내부에서만 호출 가능
  FirebaseManager._internal();

  Future<void> roadFirebase(String email) async {
    final docRef = FirebaseFirestore.instance.collection(email).doc('backup');
    try {
      final doc = await docRef.get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;

        String userJson = data['data'] as String;
        final decode = jsonDecode(userJson);
        final user = CarUser.fromJson(decode);

        CarManager().setUser(user);
      }
    } catch (e) {
      print('Firebase Firestore error: $e');
    }
  }

  void backupFirebase(String email, String value) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Firestore에 데이터 쓰기
    firestore.collection(email).doc('backup').set({'data': value});
  }
}
