import 'package:hive/hive.dart';
import 'package:mdms/hive_helper/hive_types.dart';
import 'package:mdms/hive_helper/hive_adapters.dart';
import 'package:mdms/hive_helper/fields/weekly_item_fields.dart';

part 'weekly_item.g.dart';

@HiveType(typeId: HiveTypes.weeklyItem, adapterName: HiveAdapters.weeklyItem)
class WeeklyItem extends HiveObject {
  @HiveField(WeeklyItemFields.name)
  final String name;
  @HiveField(WeeklyItemFields.qty)
  final String qty;
  @HiveField(WeeklyItemFields.price)
  final String price;

  WeeklyItem({
    required this.name,
    required this.qty,
    required this.price,
  });

  // From List
  factory WeeklyItem.fromList(List<dynamic> list, String name) {
    print(list);
    return WeeklyItem(
      name: name,
      qty: list[1].toString(),
      price: list[2].toString(),
    );
  }

  factory WeeklyItem.fromJson(Map<String, dynamic> json) {
    return WeeklyItem(
      name: json['name'],
      qty: json['qty'],
      price: json['price'],
    );
  }

  // From Map to WeeklyItem
  factory WeeklyItem.fromMap(Map<String, dynamic> map) {
    return WeeklyItem(
      name: map['name'],
      qty: map['qty'],
      price: map['price'],
    );
  }

  // From WeeklyItem to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'qty': qty,
      'price': price,
    };
  }

  // From WeeklyItem to Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'qty': qty,
      'price': price,
    };
  }
}

@HiveType(typeId: HiveTypes.weeklyItems, adapterName: HiveAdapters.weeklyItems)
class WeeklyItems extends HiveObject {
  // List of WeeklyItem
  @HiveField(WeeklyItemFields.items)
  final Map<String, List<WeeklyItem>> items;

  WeeklyItems({this.items = const {}});

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }
}
