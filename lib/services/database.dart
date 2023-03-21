import 'package:brew_app/models/brew.dart';
import 'package:brew_app/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DatabaseService {

  final String uid;

  DatabaseService({required this.uid});

    // collection reference
    final CollectionReference brewCollection = FirebaseFirestore.instance.collection(
        'brews');

    Future updateUserData(String sugars, String name, int strength) async {
      return await brewCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });

    }
    // brew list from snapshot
  List<Brew>? _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: (doc.data() as Map<String, dynamic>)['name'] ?? '',
        sugars: (doc.data() as Map<String, dynamic>)['sugars'] ?? '0',
        strength: (doc.data() as Map<String, dynamic>)['strength'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
      return UserData(
          uid: uid,
        name: (snapshot.data() as Map<String, dynamic>)['name'] ?? '',
        sugars: (snapshot.data() as Map<String, dynamic>)['sugars'] ?? '0',
        strength: (snapshot.data() as Map<String, dynamic>)['strength'] ?? 0,
      );
  }

  // get brew stream

    Stream<List<Brew>?> get brews {
      return brewCollection.snapshots().map(_brewListFromSnapshot);
    }

    // get user doc streams

    Stream<UserData> get userData {
      return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot
      );
    }
  }


