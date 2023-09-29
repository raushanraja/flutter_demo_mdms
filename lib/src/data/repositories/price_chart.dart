import 'dart:convert';

import 'package:mdms/src/config/constants/price_chats.dart';
import 'package:mdms/src/data/models/chart/items.dart';
import 'package:mdms/src/data/models/chart/weekly_item.dart';

// Define a method that takes version and classType as arguments
// Returns a List of Map<String, Item> containing the items

List<Map<String, Item>> getItems(
    String version, String classType, String today) {
  final Map<String, dynamic> jsonMap = json.decode(jsonData);
  print('jsonMap: $jsonMap');
  final parsedClass = jsonMap[version][classType];
  final commonChart = parsedClass["weekly"]["common"];
  final dailyChart = parsedClass["weekly"][today];

  for (final name in dailyChart.keys) {
    commonChart[name] = dailyChart[name];
  }

  List<Item> listitems = [];
  List<Map<String, Item>> itemsMap = [];
  for (var i = 0; i < commonChart.length; i++) {
    print(commonChart);
    // Create a new item
    Item item = Item(
        name: commonChart[i]['name'],
        wps: commonChart[i]['wps'],
        rpk: commonChart[i]['rpk'],
        aps: commonChart[i]['aps'],
        hindi: commonChart[i]['hindi']);
    // Add the item to the list
    listitems.add(item);
    itemsMap.add({commonChart[i]['name']: item});
  }

  return itemsMap;
}

// Define a method that takes version and classType as arguments
// Returns   final dailyRate = parsedClass["daily_rate"];
int getDailyRate(String version, String classType) {
  final Map<String, dynamic> jsonMap = json.decode(jsonData);
  return jsonMap[version][classType]["daily_rate"];
}

// Define a method that takes classType and returns a map of Items
class PriceChartRepository {
  Items getItemsMap(String version, String classType) {
    final Map<String, dynamic> jsonMap = json.decode(jsonData);
    final parsedClass = jsonMap[version][classType];
    final itemsObj = parsedClass["items"];

    Map<String, Item> itemsMap = {};
    List<Map<String, Item>> itemsMapList = [];
    for (final item in itemsObj) {
      Item tempItemObj = Item(
          name: item['item'],
          wps: item['wps'],
          rpk: item['rpk'],
          aps: item['aps'],
          hindi: item['hi']);
      itemsMap[item['name']] = tempItemObj;
      itemsMapList.add({item['name']: tempItemObj});
    }
    return Items(items: itemsMapList);
  }
}

// WeeklyPriceChartRepository
class WeeklyPriceChartRepository {
  static WeeklyItems getWeeklyItemsMap(
      String version, String classType, String today) {
    final Map<String, dynamic> jsonMap = json.decode(jsonData);
    final parsedClass = jsonMap[version][classType];
    final commonChart = parsedClass["weekly"]["common"];
    final dailyChart = parsedClass["weekly"][today];

    for (final name in dailyChart.keys) {
      commonChart[name] = dailyChart[name];
    }

    List<WeeklyItem> listitems = [];
    for (final name in commonChart.keys) {
      // Create a new item
      WeeklyItem item = WeeklyItem.fromList(commonChart[name], name);
      // Add the item to the list
      listitems.add(item);
    }
    return WeeklyItems(items: {today: listitems});
  }
}
