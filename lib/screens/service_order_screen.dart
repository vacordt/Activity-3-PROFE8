import 'package:flutter/material.dart';
import 'package:activity3_forms/utils/formatters.dart';

class ServiceOrderScreen extends StatefulWidget {
  const ServiceOrderScreen({super.key});

  @override
  State<ServiceOrderScreen> createState() => _ServiceOrderScreenState();
}

class _ServiceOrderScreenState extends State<ServiceOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedService = 'Legal Consultation';
  DateTime _selectedDate = DateTime.now();
  final List<Map<String, dynamic>> _orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legal Services')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _selectedService,
                    decoration: createInputDecoration('Service Type'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Legal Consultation',
                        child: Text('Legal Consultation'),
                      ),
                      DropdownMenuItem(
                        value: 'Document Review',
                        child: Text('Document Review'),
                      ),
                      DropdownMenuItem(
                        value: 'Legal Representation',
                        child: Text('Legal Representation'),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        _selectedService = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Select Date'),
                    subtitle: Text(
                      formatDate(_selectedDate),
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _orders.add({
                            'service': _selectedService,
                            'date': _selectedDate,
                          });
                        });
                      }
                    },
                    child: const Text('Place Order'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return Card(
                    child: ListTile(
                      title: Text(order['service']),
                      subtitle: Text(formatDate(order['date'])),
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
