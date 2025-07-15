import 'package:flutter/material.dart';
import 'services/bill_page.dart';

void main() {
  runApp(const MessSyncApp());
}

class MessSyncApp extends StatelessWidget {
  const MessSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MessSyncHome(),
    );
  }
}

class MessSyncHome extends StatelessWidget {
  const MessSyncHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Mess Sync",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Manage your mess activities quickly & easily",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  buildActionButton(
                    context,
                    Icons.meeting_room_outlined,
                    "Room",
                    "Request or book a room",
                  ),
                  buildActionButton(
                    context,
                    Icons.restaurant_menu,
                    "Menu",
                    "See today’s meals",
                  ),
                  buildActionButton(
                    context,
                    Icons.receipt_long,
                    "Bill",
                    "View your mess bill",
                  ),
                  buildActionButton(
                    context,
                    Icons.miscellaneous_services,
                    "Services",
                    "Request mess services",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return InkWell(
      onTap: () {
        if (title == "Bill") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BillPage()),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("$title Selected")));
        }
      },
      borderRadius: BorderRadius.circular(18),
      splashColor: Colors.cyan.withOpacity(0.2),
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.cyan[700]),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
