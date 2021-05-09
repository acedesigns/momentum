import 'dart:math';

class NewAccount {
  int accountnumber, accountbalance, accounttype, accountoverdraft;

  Random rnd = new Random();
  int min = 11111111, max = 99999999;

  NewAccount(
      {this.accountnumber,
      this.accountbalance,
      this.accounttype,
      this.accountoverdraft});
  factory NewAccount.fromJson(Map<String, dynamic> json) {
    return NewAccount(
      accountnumber: json['date'],
      accountbalance: json['start_time'],
      accounttype: json['id'],
    );
  }
}
