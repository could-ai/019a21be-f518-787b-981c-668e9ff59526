class Withdrawal {
  final String id;
  final double amount;
  final DateTime date;

  Withdrawal({
    required this.id,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'date': date.toIso8601String(),
  };

  factory Withdrawal.fromJson(Map<String, dynamic> json) => Withdrawal(
    id: json['id'],
    amount: json['amount'],
    date: DateTime.parse(json['date']),
  );
}