import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DetalleNotaScreen extends StatefulWidget {
  final String notaKey;

  const DetalleNotaScreen({required this.notaKey, super.key});

  @override
  _DetalleNotaScreenState createState() => _DetalleNotaScreenState();
}

class _DetalleNotaScreenState extends State<DetalleNotaScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _tituloController = TextEditingController();
    _descripcionController = TextEditingController(); 
    _precioController = TextEditingController(); 
  }

 
  _cargarNota() async {
    final snapshot = await _dbRef.child('usuarios/${_user.uid}/notas/${widget.notaKey}').get();
    if (snapshot.exists) {
      final nota = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _tituloController.text = nota['titulo'] ?? ''; 
        _descripcionController.text = nota['descripcion'] ?? ''; 
        _precioController.text = (nota['precio'] ?? '').toString(); 
      });
    }
  }

  _actualizarNota() async {
    await _dbRef.child('usuarios/${_user.uid}/notas/${widget.notaKey}').update({
      'titulo': _tituloController.text,
      'descripcion': _descripcionController.text,
      'precio': double.tryParse(_precioController.text) ?? 0.0,
    });
    Navigator.pop(context);
  }
  _eliminarNota() async {
    await _dbRef.child('usuarios/${_user.uid}/notas/${widget.notaKey}').remove();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_tituloController.text.isEmpty) {
      _cargarNota();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edita tu Nota'),  
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _eliminarNota,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://img1.wallspic.com/previews/7/4/2/9/7/179247/179247-artes_visuales-arte-diseno_grafico-diseno-graficos-500x.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(  
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(  
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  TextField(
                    controller: _tituloController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _descripcionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _precioController,
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _actualizarNota,
                    child: Text('Actualizar Nota'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
