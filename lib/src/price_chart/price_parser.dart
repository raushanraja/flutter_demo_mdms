// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Welcome {
    Welcome({
        required this.welcomeClass,
    });

    Class welcomeClass;

    factory Welcome.fromJson(String str) => Welcome.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        welcomeClass: Class.fromMap(json["class"]),
    );

    Map<String, dynamic> toMap() => {
        "class": welcomeClass.toMap(),
    };
}

class Class {
    Class({
        required this.to5,
        required this.to8,
    });

    To5 to5;
    To8 to8;

    factory Class.fromJson(String str) => Class.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Class.fromMap(Map<String, dynamic> json) => Class(
        to5: To5.fromMap(json["to5"]),
        to8: To8.fromMap(json["to8"]),
    );

    Map<String, dynamic> toMap() => {
        "to5": to5.toMap(),
        "to8": to8.toMap(),
    };
}

class To5 {
    To5({
        required this.items,
        required this.weekly,
    });

    Items items;
    Weekly weekly;

    factory To5.fromJson(String str) => To5.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory To5.fromMap(Map<String, dynamic> json) => To5(
        items: Items.fromMap(json["items"]),
        weekly: Weekly.fromMap(json["weekly"]),
    );

    Map<String, dynamic> toMap() => {
        "items": items.toMap(),
        "weekly": weekly.toMap(),
    };
}

class Items {
    Items({
        required this.chaawal,
        required this.daal,
        required this.masala,
        required this.sabji,
        required this.tel,
        required this.jalawan,
    });

    ChaawalClass chaawal;
    ChaawalClass daal;
    ChaawalClass masala;
    ChaawalClass sabji;
    ChaawalClass tel;
    ChaawalClass jalawan;

    factory Items.fromJson(String str) => Items.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Items.fromMap(Map<String, dynamic> json) => Items(
        chaawal: ChaawalClass.fromMap(json["chaawal"]),
        daal: ChaawalClass.fromMap(json["daal"]),
        masala: ChaawalClass.fromMap(json["masala"]),
        sabji: ChaawalClass.fromMap(json["sabji"]),
        tel: ChaawalClass.fromMap(json["tel"]),
        jalawan: ChaawalClass.fromMap(json["jalawan"]),
    );

    Map<String, dynamic> toMap() => {
        "chaawal": chaawal.toMap(),
        "daal": daal.toMap(),
        "masala": masala.toMap(),
        "sabji": sabji.toMap(),
        "tel": tel.toMap(),
        "jalawan": jalawan.toMap(),
    };
}

class ChaawalClass {
    ChaawalClass({
        required this.item,
        required this.hi,
        required this.wps,
        required this.rpk,
        required this.aps,
    });

    String item;
    String hi;
    double wps;
    double rpk;
    double aps;

    factory ChaawalClass.fromJson(String str) => ChaawalClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ChaawalClass.fromMap(Map<String, dynamic> json) => ChaawalClass(
        item: json["item"],
        hi: json["hi"],
        wps: json["wps"].toDouble(),
        rpk: json["rpk"].toDouble(),
        aps: json["aps"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "item": item,
        "hi": hi,
        "wps": wps,
        "rpk": rpk,
        "aps": aps,
    };
}

class Weekly {
    Weekly({
        required this.common,
        required this.monday,
        required this.tuesday,
        required this.wednesday,
        required this.thursday,
        required this.friday,
        required this.saturday,
    });

    Common common;
    MondayClass monday;
    FridayClass tuesday;
    MondayClass wednesday;
    MondayClass thursday;
    FridayClass friday;
    MondayClass saturday;

    factory Weekly.fromJson(String str) => Weekly.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Weekly.fromMap(Map<String, dynamic> json) => Weekly(
        common: Common.fromMap(json["common"]),
        monday: MondayClass.fromMap(json["monday"]),
        tuesday: FridayClass.fromMap(json["tuesday"]),
        wednesday: MondayClass.fromMap(json["wednesday"]),
        thursday: MondayClass.fromMap(json["thursday"]),
        friday: FridayClass.fromMap(json["friday"]),
        saturday: MondayClass.fromMap(json["saturday"]),
    );

    Map<String, dynamic> toMap() => {
        "common": common.toMap(),
        "monday": monday.toMap(),
        "tuesday": tuesday.toMap(),
        "wednesday": wednesday.toMap(),
        "thursday": thursday.toMap(),
        "friday": friday.toMap(),
        "saturday": saturday.toMap(),
    };
}

class Common {
    Common({
        required this.chaawal,
        required this.daal,
        required this.masala,
        required this.sabji,
        required this.tel,
        required this.jalawan,
    });

    List<dynamic> chaawal;
    List<dynamic> daal;
    List<dynamic> masala;
    List<dynamic> sabji;
    List<dynamic> tel;
    List<dynamic> jalawan;

    factory Common.fromJson(String str) => Common.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Common.fromMap(Map<String, dynamic> json) => Common(
        chaawal: List<dynamic>.from(json["chaawal"].map((x) => x)),
        daal: List<dynamic>.from(json["daal"].map((x) => x)),
        masala: List<dynamic>.from(json["masala"].map((x) => x)),
        sabji: List<dynamic>.from(json["sabji"].map((x) => x)),
        tel: List<dynamic>.from(json["tel"].map((x) => x)),
        jalawan: List<dynamic>.from(json["jalawan"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "chaawal": List<dynamic>.from(chaawal.map((x) => x)),
        "daal": List<dynamic>.from(daal.map((x) => x)),
        "masala": List<dynamic>.from(masala.map((x) => x)),
        "sabji": List<dynamic>.from(sabji.map((x) => x)),
        "tel": List<dynamic>.from(tel.map((x) => x)),
        "jalawan": List<dynamic>.from(jalawan.map((x) => x)),
    };
}

class FridayClass {
    FridayClass({
        required this.daal,
        required this.sabji,
    });

    List<dynamic> daal;
    List<dynamic> sabji;

    factory FridayClass.fromJson(String str) => FridayClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FridayClass.fromMap(Map<String, dynamic> json) => FridayClass(
        daal: List<dynamic>.from(json["daal"].map((x) => x)),
        sabji: List<dynamic>.from(json["sabji"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "daal": List<dynamic>.from(daal.map((x) => x)),
        "sabji": List<dynamic>.from(sabji.map((x) => x)),
    };
}

class MondayClass {
    MondayClass();

    factory MondayClass.fromJson(String str) => MondayClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MondayClass.fromMap(Map<String, dynamic> json) => MondayClass(
    );

    Map<String, dynamic> toMap() => {
    };
}

class To8 {
    To8({
        required this.items,
    });

    Items items;

    factory To8.fromJson(String str) => To8.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory To8.fromMap(Map<String, dynamic> json) => To8(
        items: Items.fromMap(json["items"]),
    );

    Map<String, dynamic> toMap() => {
        "items": items.toMap(),
    };
}
