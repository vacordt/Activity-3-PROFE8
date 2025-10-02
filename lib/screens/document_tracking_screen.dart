import 'package:flutter/material.dart';
import 'package:activity3_forms/utils/formatters.dart';

class DocumentTrackingScreen extends StatefulWidget {
  const DocumentTrackingScreen({super.key});

  @override
  State<DocumentTrackingScreen> createState() => _DocumentTrackingScreenState();
}

class _DocumentTrackingScreenState extends State<DocumentTrackingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _documentIdController = TextEditingController();
  bool _isUrgent = false;
  bool _isProcessing = false;
  final List<Map<String, dynamic>> _documents = [];

  @override
  void dispose() {
    _documentIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _documentIdController,
                    decoration: createInputDecoration('Document Reference'),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Urgent: '),
                      Switch(
                        value: _isUrgent,
                        onChanged: (value) => setState(() => _isUrgent = value),
                      ),
                      const SizedBox(width: 16),
                      const Text('Processing: '),
                      Checkbox(
                        value: _isProcessing,
                        onChanged: (value) =>
                            setState(() => _isProcessing = value!),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _documents.add({
                            'id': _documentIdController.text,
                            'urgent': _isUrgent,
                            'processing': _isProcessing,
                          });
                          _documentIdController.clear();
                          _isUrgent = false;
                          _isProcessing = false;
                        });
                      }
                    },
                    child: const Text('Track Document'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _documents.length,
                itemBuilder: (context, index) {
                  final doc = _documents[index];
                  return Card(
                    child: ListTile(
                      title: Text('Doc ID: ${doc['id']}'),
                      subtitle: Text(
                        'Urgent: ${doc['urgent'] ? 'Yes' : 'No'} | '
                        'Processing: ${doc['processing'] ? 'Yes' : 'No'}',
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
