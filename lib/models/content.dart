import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'content.g.dart';

@HiveType(typeId: 1)
class Content {
  @HiveField(0)
  String name;
  @HiveField(1)
  String location;

  @HiveField(2)
  // ignore: prefer_typing_uninitialized_variables
  var image;
  Content(this.name, this.location, this.image, 
  // this.locPicker,
  //     this.description, this.price
      );
}
