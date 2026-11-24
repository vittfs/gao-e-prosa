import 'package:flutter/material.dart';
import '../services/message_db.dart';
import '../theme.dart';

class ContactScreen extends StatefulWidget {
  final VoidCallback onBack;

  const ContactScreen({super.key, required this.onBack});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSaving = false;

  Future<void> _sendMessage() async {
    final name = _nameController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha seu nome e sua mensagem.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    await MessageDb.instance.insertMessage(
      ContactMessage(
        name: name,
        message: message,
        createdAt: DateTime.now().toIso8601String(),
      ),
    );

    _nameController.clear();
    _messageController.clear();

    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mensagem enviada com sucesso!')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho "< Contato"
          Row(
            children: [
              InkWell(
                onTap: widget.onBack,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.only(right: 10, top: 4, bottom: 4),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              Text(
                'Contato',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Card Horário
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Horário',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Seg a Sáb, 08h às 20h',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Card Endereço
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Endereço',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Rua das Acácias, 240 — Centro',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Campo Nome
          const Text(
            'Nome',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Seu nome',
              hintStyle: const TextStyle(color: Color(0xFF9E9187), fontSize: 13.5),
              filled: true,
              fillColor: AppTheme.surface,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppTheme.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppTheme.terracotta),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Campo Mensagem
          const Text(
            'Mensagem',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Como podemos ajudar?',
              hintStyle: const TextStyle(color: Color(0xFF9E9187), fontSize: 13.5),
              filled: true,
              fillColor: AppTheme.surface,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppTheme.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppTheme.terracotta),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Botão escuro "Enviar"
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _sendMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryDark,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: Text(
                _isSaving ? 'Enviando...' : 'Enviar',
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
