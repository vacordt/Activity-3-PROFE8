import 'package:flutter/material.dart';
import 'package:activity3_forms/utils/formatters.dart';

class ConsultationReservationScreen extends StatefulWidget {
  const ConsultationReservationScreen({super.key});

  @override
  State<ConsultationReservationScreen> createState() =>
      _ConsultationReservationScreenState();
}

class _ConsultationReservationScreenState
    extends State<ConsultationReservationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _nameController = TextEditingController();
  final List<Map<String, dynamic>> _reservations = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consultation Reservation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: createInputDecoration('Client Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Name required' : null,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Select Date'),
                    subtitle: Text(formatDate(_selectedDate)),
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
                  ListTile(
                    title: const Text('Select Time'),
                    subtitle: Text(formatTime(_selectedTime)),
                    trailing: const Icon(Icons.access_time),
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedTime = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _reservations.add({
                            'name': _nameController.text,
                            'date': _selectedDate,
                            'time': _selectedTime,
                          });
                          _nameController.clear();
                        });
                      }
                    },
                    child: const Text('Make Reservation'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _reservations.length,
                itemBuilder: (context, index) {
                  final reservation = _reservations[index];
                  return Card(
                    child: ListTile(
                      title: Text(reservation['name']),
                      subtitle: Text(
                        '${formatDate(reservation['date'])} '
                        'at ${formatTime(reservation['time'])}',
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
