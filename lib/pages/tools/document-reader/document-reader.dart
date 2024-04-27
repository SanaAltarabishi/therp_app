import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';

//!text  file reader

class DocumentReader extends StatefulWidget {
  const DocumentReader({super.key});
  @override
  _DocumentReaderState createState() => _DocumentReaderState();
}

class _DocumentReaderState extends State<DocumentReader> {
  String _fileContent = '';
  bool isPicked = false;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String content = await file.readAsString();
      setState(() {
        _fileContent = content;
        isPicked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isPicked
                    ? Text('')
                    : Container(
                        width: 300,
                        height: 300,
                        child: Image.asset('images/toolsImages/pick.png'),
                      ).animate().fade(delay: .3.seconds, duration: .4.seconds),
                isPicked
                    ? const Text(
                        'File Content:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffcb8780)),
                      )
                    : const Text(''),
                const SizedBox(height: 10),
                isPicked
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            _fileContent,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    : const Text(''),
                ElevatedButton(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    // textStyle: TextStyle(color:Color(0xfff3dbcc),fontSize: 20,fontWeight: FontWeight.bold),
                    backgroundColor: const Color(0xffcb8780),
                    shadowColor: const Color(0xffcb8780),
                    foregroundColor: const Color.fromARGB(255, 136, 24, 12),
                  ),
                  child: const Text(
                    'Pick File',
                    style: TextStyle(
                        color: Color(0xfff3dbcc),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ).animate().fade(delay: .4.seconds, duration: .4.seconds),
                const SizedBox(height: 20),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffcb8780),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}
