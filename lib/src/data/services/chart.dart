import 'package:hive/hive.dart';
import 'package:mdms/src/data/models/chart/items.dart';
import 'package:mdms/src/data/repositories/price_chart.dart';

final itemBox = Hive.box('items');

class ItemController {
  String version;
  String classType;
  String today;
  String get key => '$version-$classType';
  Items _items = Items(items: []);

  ItemController(
      {required this.version, required this.classType, required this.today}) {
    _items = itemBox.get(key, defaultValue: saveItemsInHive());
    print(_items.items.length);
  }

  // Getters
  Items get items => _items;

  // Refetch items
  Future<Items> refetchItems() async {
    _items = Items(items: getItems(version, classType, today));
    return _items;
  }

  // Getters
  Items get getitems => itemBox.get(key, defaultValue: saveItemsInHive);

  // Getters with an argument
  Item getItem(String name) {
    return _items.items
        .firstWhere((item) => item.keys.first == name)
        .values
        .first;
  }

  // Update and persist  a single Item

  // Get Items from json and save to Hive
  Items saveItemsInHive() {
    print("items does not exits in Hive, saving in hive");
    _items = Items(items: getItems(version, classType, today));
    itemBox.put(key, _items);
    return _items;
  }
}
