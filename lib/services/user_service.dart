
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collection = 'users';

  Future<void> createUser(User user) async {
    await _db.collection(_collection).doc(user.uid).set(user.toMap());
  }

  Future<User?> getUser(String uid) async {
    final doc = await _db.collection(_collection).doc(uid).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await _db.collection(_collection).doc(user.uid).update(user.toMap());
  }
}
