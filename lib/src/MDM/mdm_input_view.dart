import 'package:flutter/material.dart';
// Import the localization package
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mdms/src/data/services/settings.dart';

import 'mdm_inputs.dart';
import '../price_chart/chart.dart';

// Map weekday to string
Map<int, String> weekday = {
  1: 'monday',
  2: 'tuesday',
  3: 'wednesday',
  4: 'thursday',
  5: 'friday',
  6: 'saturday',
};

// calculate wps
String ItemWps(item, priceChart, numberOfStudentsController) {
  var wps = priceChart[item]['wps'];
  var noOfStudent = double.tryParse(numberOfStudentsController.text) ?? 0;
  return (noOfStudent * wps).toStringAsFixed(3);
}

// Calculate rps
String ItemRpk(item, priceChart, numberOfStudentsController) {
  var rps = priceChart[item]['rpk'];
  var noOfStudent = double.tryParse(numberOfStudentsController.text) ?? 0;
  return (noOfStudent * rps).toStringAsFixed(2);
}

// calculate aps
String ItemAps(item, priceChart, numberOfStudentsController) {
  var aps = priceChart[item]['aps'];
  var noOfStudent = double.tryParse(numberOfStudentsController.text) ?? 0;
  return (noOfStudent * aps).toStringAsFixed(2);
}

//
String getTotal(numberOfStudentsController, forClass) {
  var noOfStudent = int.tryParse(numberOfStudentsController.text) ?? 0;
  var total = 0.0;
  total = noOfStudent * getDailyRate(forClass: forClass);
  return total.toStringAsFixed(3);
}

// Create a class MDMForm extends StatefulWidget
class MDMForm extends StatefulWidget {
  // Create a const constructor

  const MDMForm({Key? key, required this.controller}) : super(key: key);
  final SettingsController controller;
  @override
  _MDMFormState createState() => _MDMFormState();

  // Create a static const String routeName
  static const routeName = '/mdmform';
}

// Create a class _MDMFormState extends State<MDMForm>
// with fields: date and number_of_students
class _MDMFormState extends State<MDMForm> {
  // Create a DateTime field date
  DateTime date = DateTime.now();
  ThemeMode themeMode = ThemeMode.light;
  Map priceChart = getVpriceChart(day: 'monday');
  String for_calss = 'to8';
  // Create a int field number_of_students
  // create a text controller for the text field
  final TextEditingController _num_of_student_controller =
      TextEditingController();

  @override
  void initState() {
    _num_of_student_controller.text = '0';
    themeMode = widget.controller.themeMode;
    priceChart = getVpriceChart(day: weekday[date.weekday]!);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _num_of_student_controller.text = '0';
    for_calss = MDMRouteInfo.fromMap(
            ModalRoute.of(context)!.settings.arguments as Map<String, String>)
        .class_type;
    super.didChangeDependencies();
  }

  // create a dispose
  @override
  void dispose() {
    // dispose the text controller
    _num_of_student_controller.dispose();
    super.dispose();
  }

  // Create a method _selectDate
  Future<void> _selectDate(BuildContext context) async {
    // Create a final DateTime picked
    final DateTime? picked = await showDatePicker(
      selectableDayPredicate: (DateTime val) => val.weekday != 7,
      // Set the context
      context: context,
      // Set the initialDate
      initialDate: date,
      // Set the firstDate
      firstDate: DateTime(2021),
      // Set the lastDate
      lastDate: DateTime(2030),
    );
    // If picked is not null
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        priceChart = getVpriceChart(day: weekday[date.weekday]!);
      });
    }
  }

  // Create a method _increment
  void _increment() {
    int currentValue = int.tryParse(_num_of_student_controller.text) ?? 0;

    currentValue++;
    // Set the state of number_of_students
    setState(() {
      _num_of_student_controller.text = currentValue.toString();
      _num_of_student_controller.selection = TextSelection.collapsed(
          offset: _num_of_student_controller.text.length);
    });
  }

  void _num_of_student_chaged(String value) {
    // print(value);
    if (value != '-' || value != '.' || value != ',') {
      setState(() {
        _num_of_student_controller.text =
            (double.tryParse(value) ?? 0).toStringAsFixed(0);
        _num_of_student_controller.selection = TextSelection.collapsed(
            offset: _num_of_student_controller.text.length);
      });
    }
  }

  // Create a method _decrement
  void _decrement() {
    int currentValue = int.tryParse(_num_of_student_controller.text) ?? 0;
    currentValue--;
    // Set the state of number_of_students
    setState(() {
      _num_of_student_controller.text =
          (currentValue > 0 ? currentValue : 0).toString();
      _num_of_student_controller.selection = TextSelection.collapsed(
          offset: _num_of_student_controller.text.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = MDMRouteInfo.fromMap(
        ModalRoute.of(context)!.settings.arguments as Map<String, String>);

    // Create a scaffold
    return Scaffold(
        // Create an app bar
        appBar: AppBar(
            // Use the AppLocalizations to retrieve the correct localized title
            title: Text(args.title)),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display Element
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titile
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        "${AppLocalizations.of(context)!.input_page_main_title}  (${args.title})",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(),
                  // Student | Rate
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Student

                        Text(
                          "${AppLocalizations.of(context)!.number_of_students_field_label}: ${_num_of_student_controller.text} ",
                          style: const TextStyle(fontSize: 17),
                        ),
                        // Rate
                        Text(
                          "${AppLocalizations.of(context)!.rate}: ${getDailyRate(forClass: "to5")} ",
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 15, right: 15, bottom: 10),
                    child: Text(
                        "Day: ${DateFormat("EEEE", Localizations.localeOf(context).toString()).format(date)}",
                        style: const TextStyle(fontSize: 17)),
                  ),
                  const Divider(),
                  // Day
                  // Whole Detail Table with header "item" | "rate" | "quantity" | "amount"
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child:
                        Table(border: TableBorder.all(), columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    }, children: [
                      TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 32, 31, 39),
                          ),
                          children: [
                            GetSizedBox(
                              AppLocalizations.of(context)!.item,
                              is_head: true,
                            ),
                            // GetSizedBox(AppLocalizations.of(context)!.rate, is_head: true,),
                            GetSizedBox(
                              AppLocalizations.of(context)!.quantity,
                              is_head: true,
                            ),
                            GetSizedBox(
                              AppLocalizations.of(context)!.amount,
                              is_head: true,
                            ),
                          ]),
                      GetTableDataRow(
                          AppLocalizations.of(context)!.rice, "chaawal",
                          decorated: true),
                      GetTableDataRow(
                          AppLocalizations.of(context)!.pulse, "daal"),
                      GetTableDataRow(
                          AppLocalizations.of(context)!.spices, "masala"),
                      GetTableDataRow(
                          AppLocalizations.of(context)!.vegetabales, "sabji",
                          decorated: true),
                      GetTableDataRow(AppLocalizations.of(context)!.oil, "tel",
                          decorated: true),
                      GetTableDataRow(
                          AppLocalizations.of(context)!.firewood, "jalawan"),
                    ]),
                  ),

                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 20, right: 15),
                    child: Text(
                      "${AppLocalizations.of(context)!.total}: ${getTotal(_num_of_student_controller, "to5")}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const Divider(),
              // Input Element
              CForm(context)
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

  // ignore: non_constant_identifier_names
  TableRow GetTableDataRow(name, item, {decorated = false}) {
    return TableRow(
        decoration: decorated ? tableRowDecoration : whiteDecoration,
        children: [
          GetSizedBox(name, decorated: decorated),
          // GetSizedBox(ItemRpk(item, priceChart, _num_of_student_controller)),
          item == 'masala'
              ? GetSizedBox('--', decorated: decorated)
              : item == 'jalawan'
                  ? GetSizedBox('--', decorated: decorated)
                  : GetSizedBox(
                      ItemWps(item, priceChart, _num_of_student_controller),
                      decorated: decorated),
          item == 'chaawal'
              ? GetSizedBox('--', decorated: decorated)
              : GetSizedBox(
                  ItemAps(item, priceChart, _num_of_student_controller),
                  decorated: decorated),
        ]);
  }

  SizedBox GetSizedBox(name, {is_head = false, decorated = false}) {
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

  Widget CForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(children: <Widget>[
        // Add a background color
        // Create  two form fields for date and number of students
        // Create a form field for date
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.date_field_label),
                  TextButton(
                    // Set the onPressed
                    onPressed: () => _selectDate(context),
                    // Set the child
                    child: Text(
                      // Set the text
                      '${date.toLocal()}'.split(' ')[0],
                      // Set the style
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!
                      .number_of_students_field_label),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _num_of_student_controller,
                    decoration: const InputDecoration(
                      // Set the border to bottom
                      border: UnderlineInputBorder(),
                      hintText: "Input number of students",
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                    // Add an onChanged listener
                    onChanged: (value) => _num_of_student_chaged(value),
                  ),
                ],
              ),
            ),
          ],
        ),
        // create a form field for number of students
        // Create a button
        Divider(),
        SaveButton(
            date: date, num_of_student_controller: _num_of_student_controller)
      ]),
    );
  }

  FormField<dynamic> NumberInput(BuildContext context) {
    return FormField(
      // Set the builder
      builder: (FormFieldState state) {
        return SizedBox(
          // height: 10,
          width: 300,
          child: InputDecorator(
            decoration: InputDecoration(
              // Set the label text
              labelText:
                  AppLocalizations.of(context)!.number_of_students_field_label,
            ),
            // Create a child
            child: Row(
              // Set the mainAxisAlignment to center
              mainAxisAlignment: MainAxisAlignment.center,
              // Set the crossAxisAlignment to center
              crossAxisAlignment: CrossAxisAlignment.center,
              // Create a list of widgets
              children: [
                // Create a TextButton
                TextButton(
                  // Set the onPressed
                  onPressed: () {
                    _decrement();
                  },
                  // Set the child
                  child: const Text('-'),
                ),
                // Create a sized box
                SizedBox(
                  // Set the width to max
                  width: 100,
                  // Set the child
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _num_of_student_controller,
                      decoration: const InputDecoration(
                        // Set the border
                        border: OutlineInputBorder(),
                        hintText: "Input number of students",
                      ),
                      // Add an onChanged listener
                      onChanged: (value) => _num_of_student_chaged(value)),
                ),
                // Create a TextButton
                TextButton(
                  // Set the onPressed
                  onPressed: () {
                    _increment();
                  },
                  // Set the child
                  child: const Text('+'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FormField<dynamic> DateSelector(BuildContext context) {
    return FormField(
      // Set the builder
      builder: (FormFieldState state) {
        return SizedBox(
          width: 80,
          child: InputDecorator(
            decoration: InputDecoration(
              // Set the label text
              labelText: AppLocalizations.of(context)!.date_field_label,
            ),
            // Create a child
            child: TextButton(
              // Set the onPressed
              onPressed: () => _selectDate(context),
              // Set the child
              child: Text(
                // Set the text
                '${date.toLocal()}'.split(' ')[0],
                // Set the style
                style: const TextStyle(
                  // Set the color
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.date,
    required TextEditingController num_of_student_controller,
  })  : _num_of_student_controller = num_of_student_controller,
        super(key: key);

  final DateTime date;
  final TextEditingController _num_of_student_controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        // Set the onPressed
        onPressed: () {
          // Create a MDMInputs object
          final MDMInput mdmInputs = MDMInput(
              // Set the date
              date,
              // Set the number of students
              int.tryParse(_num_of_student_controller.text) ?? 0);
          // Create a Navigator
          Navigator.pop(context, mdmInputs);
        },
        // Set the child
        child: Text(
          AppLocalizations.of(context)!.save_button_label,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
