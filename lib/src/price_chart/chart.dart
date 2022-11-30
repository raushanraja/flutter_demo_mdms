import 'dart:convert';
import './price_parser.dart';

const jsonData = '''{
  "class": {
    "to5": {
      "daily_rate":"5.45",
      "items": {
        "chaawal": {
          "item": "chaawal",
          "hi": "चावल",
          "wps": 0.1,
          "rpk": 0,
          "aps": 0
        },
        "daal": {
          "item": "daal",
          "hi": "दाल",
          "wps": 20.0,
          "rpk": 103.0,
          "aps": 2.06
        },
        "masala": {
          "item": "masala",
          "hi": "मसाला",
          "wps": 1,
          "rpk": 1,
          "aps": 0.49
        },
        "sabji": {
          "item": "sabji",
          "hi": "सब्ज़ी",
          "wps": 50.0,
          "rpk": 22.0,
          "aps": 1.10
        },
        "tel": {
          "item": "tel",
          "hi": "तेल",
          "wps": 5.0,
          "rpk": 121.0,
          "aps": 0.60
        },
        "jalawan": {
          "item": "jalawan",
          "hi": "जलावन",
          "wps": 100.0,
          "rpk": 12.0,
          "aps": 1.20
        }
      },
      "weekly": {
        "common": {
          "chaawal": [
            "चावल",
            0.1,
            "--"
          ],
          "daal": [
            "दाल",
            0.02,
            2.06
          ],
          "masala": [
            "मसाला",
            "--",
            0.49
          ],
          "sabji": [
            "सब्ज़ी",
            0.05,
            1.1
          ],
          "tel": [
            "तेल",
            0.005,
            0.6
          ],
          "jalawan": [
            "जलावन",
            0.1,
            1.2
          ]
        },
        "monday": {},
        "tuesday": {
          "daal": [
            "दाल",
            0.0,
            0.00
          ],
          "sabji": [
            "सब्ज़ी",
            0.05,
            3.16
          ]
        },
        "wednesday": {},
        "thursday": {},
        "friday": {
          "daal": [
            "दाल",
            0.0,
            0.00
          ],
          "sabji": [
            "सब्ज़ी",
            0.05,
            3.16
          ]
        },
        "saturday": {}
      }
    },
    "to8": {
      "items": {
        "chaawal": {
          "item": "chaawal",
          "hi": "चावल",
          "wps": 0.15,
          "rpk": 0,
          "aps": 0
        },
        "daal": {
          "item": "daal",
          "wps": 30.0,
          "rpk": 103.0,
          "aps": 3.09
        },
        "sabji": {
          "item": "sabji",
          "wps": 75.0,
          "rpk": 22.0,
          "aps": 1.65
        },
        "tel": {
          "item": "tel",
          "wps": 7.5,
          "rpk": 121.0,
          "aps": 0.9
        },
        "masala": {
          "item": "masala",
          "wps": 1,
          "rpk": 1,
          "aps": 0.73
        },
        "jalawan": {
          "item": "jalawan",
          "wps": 150.0,
          "rpk": 12.0,
          "aps": 1.80
        }
      }
    }
  }
}''';

final parsedJson = jsonDecode(jsonData);

// Create a method to get sunday price chart
Map<String, dynamic> getVpriceChart({day}) {
  var common = parsedJson['class']['to5']['weekly']['common'];
  var dayData = parsedJson['class']['to5']['weekly'][day];
  print(day);
  print(dayData);
  Map<String, dynamic> priceChart = {};
  for (var item in common.keys) {
    var itemData = common[item];
    var itemName = itemData[0];
    var itemWps = itemData[1];
    var itemAps = itemData[2];
    var itemRpk = 0.0;
    if (dayData != null) {
      if (dayData.containsKey(item)) {
        itemWps = dayData[item][1];
        itemAps = dayData[item][2];
      }
    }
    priceChart[item] = {
      'item': item,
      'hi': itemName,
      'wps': itemWps,
      'rpk': itemRpk,
      'aps': itemAps
    };
  }
  // print(priceChart);
  return priceChart;
}

// Create a method to get daily_rate
double getDailyRate({forClass = 'to5'}) {
  var dailyRate = parsedJson['class'][forClass]['daily_rate'];
  return double.parse(dailyRate) ?? 0.0;
}
