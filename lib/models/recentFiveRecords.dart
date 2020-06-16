// To parse this JSON data, do
//
//     final recentFiveRecords = recentFiveRecordsFromJson(jsonString);

import 'dart:convert';

RecentFiveRecords recentFiveRecordsFromJson(String str) => RecentFiveRecords.fromJson(json.decode(str));

String recentFiveRecordsToJson(RecentFiveRecords data) => json.encode(data.toJson());

class RecentFiveRecords {
  RecentFiveRecords({
    this.records,
  });

  List<Record> records;

  factory RecentFiveRecords.fromJson(Map<String, dynamic> json) => RecentFiveRecords(
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class Record {
  Record({
    this.id,
    this.date,
    this.notes,
    this.category,
    this.amount,
    this.recordType,
  });

  int id;
  DateTime date;
  String notes;
  Category category;
  double amount;
  int recordType;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    notes: json["notes"],
    category: Category.fromJson(json["category"]),
    amount: json["amount"],
    recordType: json["record_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date == null ? null : date.toIso8601String(),
    "notes": notes,
    "category": category.toJson(),
    "amount": amount,
    "record_type": recordType,
  };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
