class TradePower {
  final String id;
  final double value;
  final DateTime startDate;
  final String fundingSource;
  final bool isActive;
  final DateTime expirationDate; // Auto-calculated as startDate + 20 days

  TradePower({
    required this.id,
    required this.value,
    required this.startDate,
    required this.fundingSource,
    this.isActive = true,
  }) : expirationDate = startDate.add(const Duration(days: 20));

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'startDate': startDate.toIso8601String(),
    'fundingSource': fundingSource,
    'isActive': isActive,
  };

  factory TradePower.fromJson(Map<String, dynamic> json) => TradePower(
    id: json['id'],
    value: json['value'],
    startDate: DateTime.parse(json['startDate']),
    fundingSource: json['fundingSource'],
    isActive: json['isActive'] ?? true,
  );
}