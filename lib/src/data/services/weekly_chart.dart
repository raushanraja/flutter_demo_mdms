// Class WeekDayChart

import 'package:hive/hive.dart';
import 'package:mdms/src/data/models/chart/items.dart';
import 'package:mdms/src/data/models/chart/weekly_item.dart';
import 'package:mdms/src/data/repositories/price_chart.dart';

final itemBox = Hive.box('weekitems');

class WeekDayChartService {
  String version;
  String classType;
  String today;
  String get key => '$version-$classType';
  WeeklyItems _weekDayItems = WeeklyItems(items: {});

  WeekDayChartService(
      {required this.version, required this.classType, required this.today}) {
    var tempWeekDayItems = itemBox.get(key);
    if (tempWeekDayItems == null) {
      saveItemsInHive();
    } else {
      _weekDayItems = tempWeekDayItems;
    }
  }

  // Getters
  WeeklyItems get weekDayChart => _weekDayItems;

  // Refetch items
  WeeklyItems refetchItems() {
    _weekDayItems =
        WeeklyPriceChartRepository.getWeeklyItemsMap(version, classType, today);
    return _weekDayItems;
  }

  // Save Items to Hive
  WeeklyItems saveItemsInHive() {
    print('saveItemsInHive called');
    _weekDayItems =
        WeeklyPriceChartRepository.getWeeklyItemsMap(version, classType, today);
    itemBox.put(key, _weekDayItems);
    return _weekDayItems;
  }
}
