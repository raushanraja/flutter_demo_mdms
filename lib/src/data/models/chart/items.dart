// Create a class Items containig a list of items

import 'package:hive/hive.dart';
import 'package:mdms/hive_helper/hive_types.dart';
import 'package:mdms/hive_helper/hive_adapters.dart';
import 'package:mdms/hive_helper/fields/item.dart';

part 'items.g.dart';

@HiveType(typeId: HiveTypes.item, adapterName: HiveAdapters.item)
class Item {
  @HiveField(ItemFields.name)
  final String name;
  @HiveField(ItemFields.wps)
  final double wps; // wps = weight per student
  @HiveField(ItemFields.rpk)
  final double rpk; // rpk = rate per kg
  @HiveField(ItemFields.aps)
  final double aps; // aps = amount per student
  @HiveField(ItemFields.hindi)
  final String hindi; // hindi = hindi name

  Item(
      {required this.name,
      required this.wps,
      required this.rpk,
      required this.aps,
      required this.hindi});
}

@HiveType(typeId: HiveTypes.items, adapterName: HiveAdapters.items)
class Items {
// Item is a dictionary cotinaing the name as key and the value as value
  @HiveField(ItemFields.item)
  final List<Map<String, Item>> items;

  Items({this.items = const []});

  // Function to return the list of items
  List<Map<String, Item>> get getItems {
    return items;
  }

  // Function to create a list of items from json data
  factory Items.fromJson(List<dynamic> json) {
    List<Map<String, Item>> items = [];
    for (var i = 0; i < json.length; i++) {
      Map<String, Item> item = {};
      item[json[i]['name']] = Item(
          name: json[i]['name'],
          wps: json[i]['wps'],
          rpk: json[i]['rpk'],
          aps: json[i]['aps'],
          hindi: json[i]['hindi']);
      items.add(item);
    }
    return Items(items: items);
  }
}
