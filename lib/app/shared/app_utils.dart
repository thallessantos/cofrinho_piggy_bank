import 'package:intl/intl.dart';

const String BRL = "BRL";
const String EUR = "EUR";
const String USD = "USD";

abstract class AppUtils {
  static final List<String> currencyList = [BRL, EUR, USD];

  static String doubleToCurrency(double value, {withSymbol = true, currency = BRL}) {
    if (currency == EUR) return doubleToEUR(value, withSymbol: withSymbol);
    if (currency == USD) return doubleToUSD(value, withSymbol: withSymbol);
    return doubleToBRL(value, withSymbol: withSymbol);
  }

  static String doubleToBRL(double value, {withSymbol = true}) {
    final money = NumberFormat("#,##0.00", "pt_BR");
    return (withSymbol ? "R\$ " : "") + money.format(value);
  }

  static String doubleToEUR(double value, {withSymbol = true}) {
    final money = NumberFormat("#,##0.00", "en_US");
    return (withSymbol ? "\€ " : "") + money.format(value);
  }

  static String doubleToUSD(double value, {withSymbol = true}) {
    final money = NumberFormat("#,##0.00", "en_US");
    return (withSymbol ? "\$ " : "") + money.format(value);
  }
}