// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SorteioPage extends StatefulWidget {
  const SorteioPage({super.key});

  @override
  State<SorteioPage> createState() => _SorteioPageState();
}

class _SorteioPageState extends State<SorteioPage> {
  var users = <String>[];

  _getUsers() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Sorteio Meetup Flutter SP",
            style: GoogleFonts.pacifico().copyWith(
              color: Colors.red,
            ),
          ),
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                tooltip: 'Carregar lista de participantes',
                heroTag: 'carregar',
                onPressed: _getUsers,
                child: Text(
                  '⬆️',
                  style: GoogleFonts.roboto().copyWith(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(height: 20),
            FloatingActionButton(
              tooltip: 'Sortear',
              heroTag: 'sortear',
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
                  fontSize: 20,
                ),
              ),
            ),
          ],
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
