import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/screens/singin.dart';

class DatabaseService {
  static Future<String> getLastCity() async {
    final Firestore _db = Firestore.instance;
    var snap = await _db.collection('user_last_city').document(email).get();
    print(snap.data['last_city']);
    return snap.data['last_city'] ?? '';
  }

  static Future<void> updateLastCity(String city) async {
    final Firestore _db = Firestore.instance;
    _db.collection('user_last_city')
        .document(email)
        .setData({'last_city': city});
  }
}
