// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SorteioPage extends StatefulWidget {
  const SorteioPage({super.key});

  @override
  State<SorteioPage> createState() => _SorteioPageState();
}

class _SorteioPageState extends State<SorteioPage> {
  var users = <String>[];

  _getParticipantsFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      final blob = html.Blob([result.files.first.bytes!]);
      final reader = html.FileReader();
      reader.readAsText(blob);
      reader.onLoadEnd.listen((event) {
        if (reader.readyState == html.FileReader.DONE) {
          final fileContents = reader.result.toString();
          final lines = const LineSplitter().convert(fileContents);
          setState(() {
            users = lines;
          });
        }
      });
    }
  }

  _getParticipantsFromClipboard() async {
    await Clipboard.getData('text/plain').then((value) {
      if (value == null || value.text == null) {
        return;
      }

      late final List<String> lines;
      final text = value.text!;

      if (text.contains(',')) {
        lines = text.split(',').map((e) => e.trim().toUpperCase()).toList();
      } else {
        lines = const LineSplitter().convert(value.text!).map((e) => e.trim().toUpperCase()).toList();
      }

      setState(() {
        users = lines;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sorteio Meetup",
            style: GoogleFonts.pacifico().copyWith(
              color: Colors.red,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: () async {
                _getParticipantsFromClipboard();
              },
            ),
            IconButton(
              icon: const Icon(Icons.upload_file),
              onPressed: () async {
                _getParticipantsFromFile();
              },
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _getAvatarImage(users[index]),
                Text(
                  users[index],
                  style: GoogleFonts.roboto().copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Sortear',
          onPressed: () {
            if (users.isEmpty) {
              return;
            }

            final random = Random();
            final index = random.nextInt(users.length);
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                      title: const Text("🎉 O ganhador é ..."),
                      content: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _getAvatarImage(users[index]),
                          Text(
                            users[index],
                            style: GoogleFonts.roboto().copyWith(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Fechar"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              users.removeAt(index);
                            });
                          },
                          child: const Text("Remover da lista"),
                        ),
                      ],
                    ));
          },
          child: Text(
            '🎉',
            style: GoogleFonts.roboto().copyWith(
              fontSize: 24,
            ),
          ),
        ));
  }

  _getAvatarImage(String text) {
    String hash = _textToMd5(text.toLowerCase());
    return Image.network("https://www.gravatar.com/avatar/$hash?d=robohash");
  }

  String _textToMd5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }
}
