import 'package:hive/hive.dart';

part 'content.g.dart';

class Content {
  @HiveField(0)
  String name;
  @HiveField(1)
  String location;
  Content(this.name, this.location);
}
