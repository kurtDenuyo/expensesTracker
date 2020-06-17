// To parse this JSON data, do
//
//     final overview = overviewFromJson(jsonString);

import 'dart:convert';

Overview overviewFromJson(String str) => Overview.fromJson(json.decode(str));

String overviewToJson(Overview data) => json.encode(data.toJson());

class Overview {
  Overview({
    this.income,
    this.expenses,
  });

  double income;
  double expenses;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    income: json["income"],
    expenses: json["expenses"],
  );

  Map<String, dynamic> toJson() => {
    "income": income,
    "expenses": expenses,
  };
}
