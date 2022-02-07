
import 'dart:io';
import 'dart:typed_data';

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
  String description;
  @HiveField(3)
  String price;
  Content(this.name, this.location, this.description, this.price);
}
