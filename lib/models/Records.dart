// To parse this JSON data, do
//
//     final recordsModel = recordsModelFromJson(jsonString);

import 'dart:convert';

RecordsModel recordsModelFromJson(String str) => RecordsModel.fromJson(json.decode(str));

String recordsModelToJson(RecordsModel data) => json.encode(data.toJson());

class RecordsModel {
  RecordsModel({
    this.records,
    this.pagination,
  });

  List<Record> records;
  Pagination pagination;

  factory RecordsModel.fromJson(Map<String, dynamic> json) => RecordsModel(
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  Pagination({
    this.currentUrl,
    this.nextUrl,
    this.previousUrl,
    this.current,
    this.perPage,
    this.pages,
    this.count,
  });

  String currentUrl;
  String nextUrl;
  String previousUrl;
  int current;
  int perPage;
  int pages;
  int count;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentUrl: json["current_url"],
    nextUrl: json["next_url"],
    previousUrl: json["previous_url"],
    current: json["current"],
    perPage: json["per_page"],
    pages: json["pages"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "current_url": currentUrl,
    "next_url": nextUrl,
    "previous_url": previousUrl,
    "current": current,
    "per_page": perPage,
    "pages": pages,
    "count": count,
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
