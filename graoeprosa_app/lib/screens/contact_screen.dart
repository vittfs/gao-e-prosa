import 'package:flutter/material.dart';

import '../services/message_db.dart';
import '../theme.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _name = TextEditingController();
  final _message = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final name = _name.text.trim();
    final message = _message.text.trim();
    final messenger = ScaffoldMessenger.of(context);

    if (name.isEmpty || message.isEmpty) {
      messenger.showSnackBar(const SnackBar(content: Text('Preencha seu nome e a mensagem.')));
      return;
    }

    setState(() => _sending = true);
    await MessageDb.insert(name, message);
    if (!mounted) return;
    setState(() => _sending = false);
    _name.clear();
    _message.clear();
    FocusScope.of(context).unfocus();
    messenger.showSnackBar(const SnackBar(content: Text('Mensagem enviada. Obrigado!')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      children: [
        Row(
          children: [
            IconButton(onPressed: widget.onBack, icon: const Icon(Icons.chevron_left, size: 28)),
            Text('Contato', style: displayStyle(26)),
          ],
        ),
        const _InfoCard(title: 'Horário', text: 'Seg a Sáb, [00h] às [00h]'),
        const SizedBox(height: 10),
        const _InfoCard(title: 'Endereço', text: '[RUA E NÚMERO], [CIDADE]'),
        const SizedBox(height: 16),
        _Field(label: 'Nome', hint: 'Seu nome', controller: _name),
        const SizedBox(height: 12),
        _Field(label: 'Mensagem', hint: 'Como podemos ajudar?', controller: _message, lines: 3),
        const SizedBox(height: 16),
        SizedBox(
          height: 50,
          child: FilledButton(
            onPressed: _sending ? null : _send,
            style: FilledButton.styleFrom(
              backgroundColor: espresso,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            child: const Text('Enviar'),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.hint, required this.controller, this.lines = 1});

  final String label;
  final String hint;
  final TextEditingController controller;
  final int lines;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: fieldBorder),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          minLines: lines,
          maxLines: lines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: espresso.withAlpha(128), fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            enabledBorder: border,
            focusedBorder: border.copyWith(borderSide: const BorderSide(color: terracotta)),
          ),
        ),
      ],
    );
  }
}
