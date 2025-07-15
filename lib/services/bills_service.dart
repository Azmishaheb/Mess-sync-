class BillService {
  static double getCurrentBill() {
    return 3200.0;
  }

  static Map<String, double> getBillBreakdown() {
    return {
      "Food": 1500,
      "Services": 900,
      "Internet Bill": 400,
      "Miscellaneous": 400,
    };
  }

  static List<Map<String, dynamic>> getDailyBreakdown(String category) {
    switch (category) {
      case "Food":
        return [
          {"date": "July 10", "amount": 100},
          {"date": "July 11", "amount": 120},
          {"date": "July 12", "amount": 150},
          {"date": "July 13", "amount": 130},
        ];
      case "Services":
        return [
          {"date": "July 10", "amount": 300},
          {"date": "July 12", "amount": 600},
        ];
      case "Internet Bill":
        return [
          {"date": "July 01", "amount": 400},
        ];
      case "Miscellaneous":
        return [
          {"date": "July 11", "amount": 200},
          {"date": "July 13", "amount": 200},
        ];
      default:
        return [];
    }
  }
}
