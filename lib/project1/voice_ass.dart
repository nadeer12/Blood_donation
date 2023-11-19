
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'update.dart';
import 'home.dart';
import 'add.dart';


class VoiceAssistantPage extends StatefulWidget {
  @override
  _VoiceAssistantPageState createState() => _VoiceAssistantPageState();
}

class _VoiceAssistantPageState extends State<VoiceAssistantPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _resultText = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print('Speech recognition status: $status');
      },
      onError: (errorNotification) {
        print('Speech recognition error: $errorNotification');
      },
    );

    if (available) {
      setState(() {
        _isListening = false;
      });
    } else {
      print('Speech recognition not available');
    }
  }

  void processVoiceCommand(String command) {
    print('Recognized command: $command');
  
    if (command.toLowerCase().contains("create new donor")) {
      print('Opening Create Item Page');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddUser()),
      );
    } else if (command.toLowerCase().contains("back home")) {
      print('Opening View Items Page');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      print('Command not recognized');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Assistant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Voice Assistant is $_isListening'),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     if (!_isListening) {
            //       _startListening();
            //     }
            //   },
            //   child: Text('Start Listening'),
            // ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_isListening){
            _startListening();
          }
        },
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.keyboard_voice, size: 26),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _startListening() async {
    if (_speech.isAvailable) {
      try {
        await _speech.listen(
          onResult: (result) {
            setState(() {
              _resultText = result.recognizedWords;
            });
            processVoiceCommand(result.recognizedWords);
          },
          listenFor: Duration(seconds: 10),
        );
      } catch (e) {
        print('Error starting listening: $e');
      }
    } else {
      print('Speech recognition not available');
    }
  }
}