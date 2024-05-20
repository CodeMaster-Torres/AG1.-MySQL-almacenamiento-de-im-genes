import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/api_service.dart';

class NewBookScreen extends StatefulWidget {
  @override
  _NewBookScreenState createState() => _NewBookScreenState();
}

class _NewBookScreenState extends State<NewBookScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _editorial = TextEditingController();
  final TextEditingController _agno = TextEditingController();
  final TextEditingController _paginas = TextEditingController();
  final TextEditingController _genero = TextEditingController();
  File? _image;

  Future<void> _chooseImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future<void> _uploadBook() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image')));
      return;
    }

    try {
      await ApiService().addBook(_titleController.text, _authorController.text, _image!);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload book: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Autor'),
            ),TextField(
              controller: _editorial,
              decoration: InputDecoration(labelText: 'Editorial'),
            ),TextField(
              controller: _agno,
              decoration: InputDecoration(labelText: 'Año'),
            ),
            TextField(
              controller: _paginas,
              decoration: InputDecoration(labelText: 'Paginas'),
            ),
            TextField(
              controller: _genero,
              decoration: InputDecoration(labelText: 'Genero'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _chooseImage,
              child: Text('Seleccionar imagen'),
            ),
            SizedBox(height: 16.0),
            _image != null
                ? Image.file(
              _image!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            )
                : Container(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadBook,
              child: Text('Subir libro'),
            ),
          ],
        ),
      ),
    );
  }
}
