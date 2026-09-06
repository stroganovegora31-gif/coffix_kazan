import 'package:flutter/material.dart';
import '../../services/telegram_service.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final List<int> allowedUsers = [
    8951231617, // Я
    1119299539, // Даша Фролова
    637951686, // Катя УК
    1322340874, // Даша СС
    652592982, // Лера Дашкина
    1636847884, // Катя СС
    856632404, // Саша
    1370942362 // влад

  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAccess();
    });
  }

  void _checkAccess() {
    final userId = TelegramService.getUserId();

    if (userId != null && allowedUsers.contains(userId)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = TelegramService.getUserId();

    return Scaffold(
      body: Center(
        child: allowedUsers.contains(userId)
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock, size: 80, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    'Доступ запрещён',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ваш Telegram ID: $userId',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
      ),
    );
  }
}
