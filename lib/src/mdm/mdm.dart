import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mdms/src/data/services/chart.dart';
import 'package:mdms/src/data/services/weekly_chart.dart';

// Map weekday to string
Map<int, String> weekday = {
  1: 'monday',
  2: 'tuesday',
  3: 'wednesday',
  4: 'thursday',
  5: 'friday',
  6: 'saturday',
};

// Create a StatefulWidget class MDM with a key and a title
class MDM extends StatefulWidget {
  // Create a const constructor with a key and a title
  const MDM({Key? key, required this.title, required this.classType})
      : super(key: key);

  // Create a final String title
  final String title;
  final String classType;

  // Create a static String routeName
  static const String routeName = '/mdmform';

  @override
  State<MDM> createState() => _MDMState();
}

// Create a State class _MDMFormState
class _MDMState extends State<MDM> {
  // Date for the calculatoin
  DateTime date = DateTime.now();
  final String _num_of_student_chaged = "0";
  late ItemController _itemController = ItemController(
      version: '1.0.0', classType: '5', today: weekday[date.weekday]!);
  late WeekDayChartService _weekDayChartService = WeekDayChartService(
      version: '1.0.0', classType: '5', today: weekday[date.weekday]!);

  // Create a method to handle the date change
  void _handleDateChange(DateTime date) {
    setState(() {
      this.date = date;
    });
  }

  // Initstate
  @override
  void initState() {
    super.initState();
    // _itemController = ItemController(
    //     version: '1.0.0', classType: '5', today: weekday[date.weekday]!);

    _weekDayChartService = WeekDayChartService(
        version: '1.0.0', classType: '5', today: weekday[date.weekday]!);
    print(_weekDayChartService.weekDayChart.toJson());
  }

  static const COLUMNWIDTHS = {
    0: FlexColumnWidth(2),
    1: FlexColumnWidth(1),
    2: FlexColumnWidth(1),
    3: FlexColumnWidth(1),
  };
  @override
  Widget build(BuildContext context) {
    // Create a scaffold
    return Scaffold(
        // Create an app bar
        appBar: AppBar(
          // Use the AppLocalizations to retrieve the correct localized title
          title: Text(widget.title),
        ),
        // Create a body
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    padding: const EdgeInsets.only(top: 10),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    text: AppLocalizations.of(context)!.input_page_main_title,
                  ),
                  const Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          padding: EdgeInsets.zero,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          text: AppLocalizations.of(context)!
                              .number_of_students_field_label,
                        ),
                        TextWidget(
                          padding: EdgeInsets.zero,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          text: AppLocalizations.of(context)!.rate,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  DayTextWidget(context),
                  const Divider(),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: COLUMNWIDTHS,
                    children: [
                      TableRow(children: getTableRowList),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  // create const table row decoration
  static const tableRowDecoration =
      BoxDecoration(color: Color.fromARGB(255, 35, 49, 68));
  static const whiteDecoration = BoxDecoration();
  // Create const table row text style
  static const tableHeadRowTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const tableRowTextStyle = TextStyle(fontSize: 17);
  static const textAlignment = TextAlign.start;

  SizedBox getSizedBox(name, {is_head = false, decorated = false}) {
    return SizedBox(
      height: 40,
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: is_head
              ? tableHeadRowTextStyle
              : decorated
                  ? tableRowTextStyle.copyWith(color: Colors.white)
                  : tableRowTextStyle,
          textAlign: textAlignment,
        ),
      ),
    );
  }

  // Function returning a list of table rows for head
  List<Widget> get getTableRowList {
    List<String> rowNames = [
      AppLocalizations.of(context)!.item,
      AppLocalizations.of(context)!.quantity,
      AppLocalizations.of(context)!.amount,
    ];
    return rowNames
        .map((e) => getSizedBox(e, is_head: true, decorated: true))
        .toList();
  }

  //  Function return a list of table rows for body with data
  List<Widget> get getTableRowListWithData {
    const List<String> ITEMNAMES = [
      'chaawal',
      'daal',
      'masala',
      'sabji',
      'tel',
      'jalawan'
    ];

    return ITEMNAMES
        .map((e) => getSizedBox(e, is_head: true, decorated: true))
        .toList();
  }

  // DateSelector(
  //   date: date,
  //   onChanged: _handleDateChange,
  // ),
  Widget DayTextWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Text(
        "Day: ${DateFormat("EEEE", Localizations.localeOf(context).toString()).format(date)}",
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.padding,
    required this.fontSize,
    required this.fontWeight,
    required this.text,
  }) : super(key: key);

  final EdgeInsets padding;
  final double fontSize;
  final FontWeight fontWeight;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}

// Create a date selector widget
class DateSelector extends StatelessWidget {
  const DateSelector({Key? key, required this.date, required this.onChanged})
      : super(key: key);

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              selectableDayPredicate: (DateTime val) => val.weekday != 7,
            ).then((value) {
              if (value != null) {
                onChanged(value);
              }
            });
          },
          child: Text(
            '${date.day}.${date.month}.${date.year}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

// create const table row decoration
const tableRowDecoration =
    BoxDecoration(color: Color.fromARGB(255, 35, 49, 68));
const whiteDecoration = BoxDecoration();
// Create const table row text style
const tableHeadRowTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const tableRowTextStyle = TextStyle(fontSize: 17);
const textAlignment = TextAlign.start;

// ignore: non_constant_identifier_names
// TableRow GetTableDataRow(name, item, {decorated = false}) {
//   return TableRow(
//       decoration: decorated ? tableRowDecoration : whiteDecoration,
//       children: [
//         getSizedBox(name, decorated: decorated),
//         // GetSizedBox(ItemRpk(item, priceChart, _num_of_student_controller)),
//         item == 'masala'
//             ? getSizedBox('--', decorated: decorated)
//             : item == 'jalawan'
//                 ? getSizedBox('--', decorated: decorated)
//                 : getSizedBox(
//                     ItemWps(item, priceChart, _num_of_student_controller),
//                     decorated: decorated),
//         item == 'chaawal'
//             ? getSizedBox('--', decorated: decorated)
//             : getSizedBox(ItemAps(item, priceChart, _num_of_student_controller),
//                 decorated: decorated),
//       ]);
// }

SizedBox getSizedBox(name, {is_head = false, decorated = false}) {
  return SizedBox(
    height: 40,
    child: Container(
      padding: const EdgeInsets.only(left: 8),
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: is_head
            ? tableHeadRowTextStyle
            : decorated
                ? tableRowTextStyle.copyWith(color: Colors.white)
                : tableRowTextStyle,
        textAlign: textAlignment,
      ),
    ),
  );
}
