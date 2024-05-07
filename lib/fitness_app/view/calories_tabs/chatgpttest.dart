import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class QuestionAnswerApp extends StatefulWidget {
  const QuestionAnswerApp({super.key});

  @override
  _QuestionAnswerAppState createState() => _QuestionAnswerAppState();
}

class _QuestionAnswerAppState extends State<QuestionAnswerApp> {
  TextEditingController questionController = TextEditingController();
  String answer = '';

  Future<void> askQuestion() async {
    const apiKey = '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';
    const apiUrl = 'https://api.openai.com/v1/answers';
    // ignore: unused_local_variable
    final question = questionController.text;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'prompt': "what is dart",
        'max_tokens': 150,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        answer = data['choices'][0]['text'];
      });
    } else {
      throw Exception('Failed to fetch answer');
    }
  }
  abc() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer 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'
    };
    var request = http.Request('POST', Uri.parse('https://api.openai.com/v1/answers'));
    request.body = json.encode({
      "model": "ipsum occaecat",
      "question": "What is the capital of Japan?",
      "examples": [
        [
          "esse",
          "dolo"
        ]
      ],
      "examples_context": "Ottawa, Canada's capital, is located in the east of southern Ontario, near the city of Montréal and the U.S. border.",
      "documents": [
        "est in mollit nisi elit",
        "consectetur exercitation quis cil"
      ],
      "file": "ipsum esse minim Lorem",
      "search_model": "ada",
      "max_rerank": 200,
      "temperature": 0,
      "logprobs": null,
      "max_tokens": 16,
      "stop": "\n",
      "n": 1,
      "logit_bias": null,
      "return_metadata": false,
      "return_prompt": false,
      "user": "user-1234"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log(await response.stream.bytesToString());
    }
    else {
      log(response.reasonPhrase.toString());
    }

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer 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'
    // };
    // var request = http.Request('POST', Uri.parse('https://api.openai.com/v1/chat/completions'));
    // request.body = json.encode({
    //   "model": "gpt-3.5-turbo",
    //   "messages": [
    //     {"role": "assistant", "content": "The Los Angeles Dodgers won the World Series in 2020."},
    //   ],
    //   "temperature": 1,
    //   "top_p": 1,
    //   "n": 1,
    //   "stream": false,
    //   "max_tokens": 250,
    // });
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    // if (response.statusCode == 200) {
    //   log(await response.stream.bytesToString());
    // }
    // else {
    // log(response.reasonPhrase);
    // }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Question Answer App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(
                  labelText: 'Ask a question',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: ()  {
                  // askQuestion();
                  abc();
                },
                child: const Text('Get Answer'),
              ),
             const SizedBox(height: 20.0),
              const Text(
                'Answer:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Text(
                answer,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
