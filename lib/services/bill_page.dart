import 'package:flutter/material.dart';
import 'bills_service.dart';

class BillPage extends StatelessWidget {
  const BillPage({super.key});

  @override
  Widget build(BuildContext context) {
    double billAmount = BillService.getCurrentBill();
    Map<String, double> breakdown = BillService.getBillBreakdown();

    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      appBar: AppBar(
        title: const Text("Mess Bill Overview"),
        backgroundColor: Colors.cyan[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "Total Bill",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${billAmount.toStringAsFixed(0)} TK",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                itemCount: breakdown.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.0, // Makes buttons more square & balanced
                ),
                itemBuilder: (context, index) {
                  String key = breakdown.keys.elementAt(index);
                  double value = breakdown[key]!;

                  IconData icon;
                  switch (key) {
                    case "Food":
                      icon = Icons.restaurant_menu;
                      break;
                    case "Services":
                      icon = Icons.build_circle_outlined;
                      break;
                    case "Internet Bill":
                      icon = Icons.wifi;
                      break;
                    case "Miscellaneous":
                    default:
                      icon = Icons.more_horiz;
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BreakdownPage(
                            category: key,
                            data: BillService.getDailyBreakdown(key),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, size: 38, color: Colors.cyan[700]),
                          const SizedBox(height: 10),
                          Text(
                            key,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${value.toStringAsFixed(0)} TK",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreakdownPage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> data;

  const BreakdownPage({super.key, required this.category, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      appBar: AppBar(
        title: Text("$category Breakdown"),
        backgroundColor: Colors.cyan[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              "Daily $category Expenses",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Amount (TK)")),
                  ],
                  rows: data.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry['date'])),
                        DataCell(Text(entry['amount'].toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
