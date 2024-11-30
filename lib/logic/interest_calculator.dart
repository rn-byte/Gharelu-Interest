import 'dart:math';

double compoundInterestCalculator(
    {required double principal,
    required double annualRate,
    required DateTime startDate,
    required DateTime endDate}) {
  // Calculate the number of years between the dates
  int totalDays = endDate.difference(startDate).inDays;
  double years = totalDays / 365;

  // Calculate the compound interest formula
  double totalAmount = principal * pow((1 + annualRate / 100), years);
  return totalAmount - principal; // Return only the interest
}
