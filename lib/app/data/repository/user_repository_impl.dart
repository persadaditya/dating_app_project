import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luvit_dating_app/app/data/model/user_dating.dart';
import 'package:luvit_dating_app/flavors/build_config.dart';

import '/app/data/remote/user_remote_data_source.dart';
import '/app/data/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteData _remoteSource =
      Get.find(tag: (UserRemoteData).toString());

  final Logger logger = BuildConfig.instance.config.logger;

  @override
  Future<List<UserDating>> getUserDating() async{
    final List<UserDating> list = [];

    final snapshot = await _remoteSource.getSnapshotData();
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      logger.d('snapshot($key): $value');
      final user = UserDating.fromJson(value);
      list.add(user);
    });

    return list;
  }

  @override
  Stream<List<UserDating>> getStreamUserDating() {
    var stream = _remoteSource.getStreamSnapshotData();

    StreamController<List<UserDating>> controller = StreamController<List<UserDating>>();
    stream.listen((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>;
      final List<UserDating> list = [];
      map.forEach((key, value) {
        logger.d('snapshot($key): $value');
        final user = UserDating.fromJson(value);
        list.add(user);
      });
      controller.add(list);
    });

    return controller.stream;
  }

  @override
  Future<List<UserDating>> getUserDummy() async{
    List<UserDating> dummyData = [
      UserDating(
          age: 30,
          description: "Hi this is fruit. I like you",
          images: ["https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/300px-Apple_logo_black.svg.png"
            ,"https://www.applesfromny.com/wp-content/uploads/2020/05/20Ounce_NYAS-Apples2.png"
            ,"https://healthiersteps.com/wp-content/uploads/2021/12/green-apple-benefits.jpeg"
            ,"https://healthiersteps.com/wp-content/uploads/2021/12/green-apple-basket.jpeg" ],
          likeCount: 18, location: "seoul", name: "apple",
          tags:[ "smocking","exercise","INFP","goodSmile"]
      ),
      UserDating(
          age: 27,
          description: "Hi this is fruit. I like you",
          images: ["https://domf5oio6qrcr.cloudfront.net/medialibrary/6372/202ebeef-6657-44ec-8fff-28352e1f5999.jpg"
            ,"https://cdn.britannica.com/92/13192-050-6644F8C3/bananas-bunch.jpg?w=400&h=300&c=crop"
            ,"https://res.cloudinary.com/roundglass/image/upload/v1653327652/rg/collective/media/Banana%20KP_yg3asc.png"
            ,"https://www.thedailymeal.com/img/gallery/13-delicious-things-you-can-make-with-bananas/intro-1673458653.sm.webp" ],
          likeCount: 40, location: "busan", name: "banana",
          tags:[ "nonSmocking","INTP","goodSmile","goodFace"]
      ),
      UserDating(
          age: 32,
          description: "Hi this is fruit. I like you",
          images: ["https://www.agroponiente.com/wp-content/uploads/2021/09/melon-amarillo-Agroponiente.png"
            ,"https://www.agroponiente.com/wp-content/uploads/2021/09/sandia-snack-Kisy-Agroponiente.png"
            ,"https://sunrisefruits.com/wp-content/uploads/2018/05/Productos-Melon-Sunrisefruitscompany.jpg"
            ,"data:image/jpeg;base64,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" ],
          likeCount: 142, location: "seoul", name: "melon",
          tags:[ "ENFP","goodFace","goodShape"]
      ),
      UserDating(
          age: 35,
          description: "Hi this is fruit. I like you",
          images: ["https://www.shape.com/thmb/ZSJYlnhHXphGy1WwUa8whO56zqY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/peaches-promo-a0d430283f7440a1955a71c014d2628e.jpg"
            ,"https://billsberryfarm.com/wp-content/uploads/2020/08/peach.png"
            ,"https://cdn.britannica.com/38/125438-004-9FF41186/Fruit-peach-tree.jpg?w=300"
            ,"https://cdn.britannica.com/68/124168-050-33A2B851/Fruit-peach-tree.jpg?w=300" ],
          likeCount: 2003, location: "seoul", name: "peach",
          tags:[ "ENFP","goodFace","goodShape"]
      ),
    ];

    return dummyData;
  }


}
