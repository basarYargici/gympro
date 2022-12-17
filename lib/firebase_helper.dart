import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/message_model.dart';
import 'models/user_model.dart';

class FirebaseHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<MessageModel> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return MessageModel(isSuccess: true);
    } on FirebaseException catch (e) {
      return MessageModel(isSuccess: false, message: e.message);
    }
  }

  Future<void> createUserDetailRecord({
    required MyUser user,
  }) async {
    final docUser = _firebaseStore.collection('userDetail').doc(user.id);
    await docUser.set(user.toMap());
  }

  Stream<List<MyUser>> getUserDetail() {
    return _firebaseStore
        .collection('userDetail')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => MyUser.fromMap(doc.data()),
            )
            .toList());
  }

  Future<MyUser> getUserBodyModel(String userId) {
    final docRef =
        FirebaseFirestore.instance.collection("userDetail").doc(userId);
    return docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MyUser.fromMap(data);
      },
      onError: (e) => Future.error(e),
    );
  }
}
