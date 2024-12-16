import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:autonoma_1/screens/crear_nota.dart';
import 'package:autonoma_1/screens/detalle_nota.dart';

class PantallaNotas extends StatefulWidget {
  @override
  _PantallaNotasState createState() => _PantallaNotasState();
}

class _PantallaNotasState extends State<PantallaNotas> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  late User _user;
  List<Map<dynamic, dynamic>> _notas = [];

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _cargarNotas();
  }

  _cargarNotas() async {
    _dbRef.child('usuarios/${_user.uid}/notas').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        List<Map<dynamic, dynamic>> listaNotas = [];
        Map<dynamic, dynamic> mapaNotas = data as Map<dynamic, dynamic>;
        mapaNotas.forEach((key, value) {
          listaNotas.add({
            'key': key,
            'titulo': value['titulo'],
            'descripcion': value['descripcion'],
            'precio': value['precio'],
          });
        });
        setState(() {
          _notas = listaNotas;
        });
      }
    });
  }

  _eliminarNota(String notaKey) {
    _dbRef.child('usuarios/${_user.uid}/notas/$notaKey').remove();
  }

  _actualizarNota(String notaKey, String titulo, String descripcion, double precio) async {
    try {
      await _dbRef.child('usuarios/${_user.uid}/notas/$notaKey').update({
        'titulo': titulo,
        'descripcion': descripcion,
        'precio': precio,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nota actualizada correctamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la nota: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Notas'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img1.wallspic.com/previews/7/4/2/9/7/179247/179247-artes_visuales-arte-diseno_grafico-diseno-graficos-500x.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                'Elige una Opción',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Pantalla de Notas'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/pantallaNotas');
              },
            ),
            ListTile(
              title: Text('Crear Nueva Nota'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/crear_nota');
              },
            ),
            ListTile(
              title: Text('Detalles de Nota'),
              onTap: () {
                if (_notas.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleNotaScreen(notaKey: _notas[0]['key']),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://img1.wallspic.com/previews/7/4/2/9/7/179247/179247-artes_visuales-arte-diseno_grafico-diseno-graficos-500x.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          ListView.builder(
            itemCount: _notas.length,
            itemBuilder: (context, index) {
              var nota = _notas[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      nota['titulo'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(nota['descripcion']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarNota(nota['key']),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleNotaScreen(notaKey: nota['key']),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/crear_nota');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
