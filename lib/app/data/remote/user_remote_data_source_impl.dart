import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '/app/core/base/base_remote_source.dart';
import '/app/data/remote/user_remote_data_source.dart';

class UserRemoteDataImpl extends BaseRemoteSource
    implements UserRemoteData {


  @override
  Future<DataSnapshot> getSnapshotData() async{
    return getDatabase().child('data').get();
  }

  @override
  Stream<DatabaseEvent> getStreamSnapshotData() {
    return getDatabase().child('data').onValue;
  }
}
