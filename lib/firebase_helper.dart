import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/body_model.dart';
import 'models/notify_model.dart';
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

  Future<void> addUserBodyModel(String userId, BodyModel bodyModel) {
    final docRef =
        FirebaseFirestore.instance.collection("userDetail").doc(userId);
    List<BodyModel> updatedList = List.empty(growable: true);
    List<BodyModel> originalList = List.empty(growable: true);
    return getUserBodyModelList(userId).then(
      (value) => {
        if (value != null)
          {
            originalList = value,
            // ignore: avoid_function_literals_in_foreach_calls
            originalList.forEach((e) => updatedList.add(e)),
            updatedList.add(bodyModel),
          }
        else
          {updatedList.add(bodyModel)},
        docRef.update(toMapBodyModelList(updatedList)),
      },
      onError: (e) => Future.error(e),
    );
  }

  Future<List<BodyModel>?> getUserBodyModelList(String userId) {
    final docRef =
        FirebaseFirestore.instance.collection("userDetail").doc(userId);
    return docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MyUser.fromMap(data).bodyModel;
      },
      onError: (e) => Future.error(e),
    );
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

  Stream<NotifyModel> getNotified() {
    return _firebaseStore.collection('news').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => NotifyModel.fromMap(
                  doc.data(),
                ),
              )
              .first,
        );
  }
}
