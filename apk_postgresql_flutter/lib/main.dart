import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  hintText: "ID",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: questionController,
                decoration: InputDecoration(
                  hintText: "Question",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: answerController,
                decoration: InputDecoration(
                  hintText: "Answer",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () async {
                  final connection = PostgreSQLConnection(
                    'localhost',
                    5432,
                    'database_iman_ba',
                    username: 'postgres',
                    password: 'Withtide123',
                  );
                  try {
                    await connection.open();

                    // Use the connection to perform database operations
                    await connection.execute(
                      "INSERT INTO questions (question_text, answer_text) VALUES (@question, @answer)",
                      substitutionValues: {
                        'question': questionController.text,
                        'answer': answerController.text,
                      },
                    );
                    print('Insert successful');
                  } catch (e) {
                    print('Error: $e');
                  } finally {
                    await connection.close();
                  }
                },
                child: const Text("Insert Data"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
