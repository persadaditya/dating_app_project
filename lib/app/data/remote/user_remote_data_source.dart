import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

abstract class UserRemoteData {

  Future<DataSnapshot> getSnapshotData();

  Stream<DatabaseEvent> getStreamSnapshotData();
}
