

import 'dart:developer';

import 'package:flutter/material.dart';

///test
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = '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';

class CreateNewStory extends StatefulWidget {
  const CreateNewStory({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateNewStoryState createState() => _CreateNewStoryState();
}

class _CreateNewStoryState extends State<CreateNewStory> {
  final TextEditingController _questionController = TextEditingController();
  String _answer = '';

  Future<void> _getAnswer() async {
    String question = _questionController.text;
    if (question.isNotEmpty) {
      String apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };
      Map<String, dynamic> body = {
        'prompt': 'Question: $question\nAnswer:',
        'max_tokens': 200,
        'temperature': 0.5,
        'top_p': 1.0,
        'n': 1,
        'stop': '\n',
      };

      try {
        http.Response response = await http.post(
          Uri.parse(apiUrl),
          headers: headers,
          body: jsonEncode(body),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          setState(() {
            _answer = responseData['choices'][0]['text'];
          });
        } else {
          setState(() {
            _answer = 'Error occurred while fetching the answer.';
          });
        }
      } catch (e) {
        log('Error: $e');
        setState(() {
          _answer = 'Error occurred while fetching the answer.';
        });
      }
    }
  }
  openAi() async {
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
  log(response.reasonPhrase. toString());
  }

}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question-Answering'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Enter a question',
              ),
            ),
          ),
          ElevatedButton(
            onPressed:()=> openAi(),
            child: const Text('Get Answer'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _answer,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///final

