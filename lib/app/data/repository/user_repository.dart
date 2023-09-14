import 'package:luvit_dating_app/app/data/model/user_dating.dart';


abstract class UserRepository {
  Future<List<UserDating>> getUserDating();
  Future<List<UserDating>> getUserDummy();
}
