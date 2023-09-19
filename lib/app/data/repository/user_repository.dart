import 'package:luvit_dating_app/app/data/model/user_dating.dart';


abstract class UserRepository {
  Future<List<UserDating>> getUserDating();
  Stream<List<UserDating>> getStreamUserDating();
  Future<List<UserDating>> getUserDummy();
}
