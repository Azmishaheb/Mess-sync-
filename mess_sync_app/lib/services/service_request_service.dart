import 'package:flutter/material.dart';

class ServiceRequestPage extends StatefulWidget {
  const ServiceRequestPage({super.key});

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  final Map<String, bool> _services = {
    "Room Cleaning": false,
    "Laundry": false,
    "Dish Washing": false,
    "Garbage Disposal": false,
    "Maintenance Request": false,
    "Extra Bedding": false,
  };

  void _submitRequest() {
    final requestedServices = _services.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (requestedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one service.")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Requested services: ${requestedServices.join(', ')}"),
        duration: const Duration(seconds: 3),
      ),
    );

    // TODO: Send the request to backend or handle further
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mess Services"),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Select the services you want to request:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _services.entries.map((entry) {
                  return SwitchListTile(
                    title: Text(entry.key),
                    value: entry.value,
                    activeColor: Colors.cyan[700],
                    onChanged: (bool newValue) {
                      setState(() {
                        _services[entry.key] = newValue;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _submitRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan[700],
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Submit Request"),
            ),
          ],
        ),
      ),
    );
  }
}
