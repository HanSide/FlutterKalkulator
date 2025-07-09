import 'package:flutter/material.dart';

void main(){
  runApp(KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalkulator Flutter",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor : Colors.teal),
        useMaterial3: true,
        textTheme: TextTheme  (
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
     home: KalkulatorPage(),
      );
  }
}

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage>{
  final TextEditingController _angka1 = TextEditingController();
  final TextEditingController _angka2 = TextEditingController();
  String _hasil = "";

void _reset(){
  _angka1.clear();
  _angka2.clear();                  
  setState(() {
    _hasil = "";
  });
}

void _hitung(String operator) {
    double angka1 = double.tryParse(_angka1.text) ?? 0;
    double angka2 = double.tryParse(_angka2.text) ?? 0;
    double hasil;

    switch (operator) {
      case '+':
        hasil = angka1 + angka2;
        break;
      case '-':
        hasil = angka1 - angka2;
        break;
      case '*':
        hasil = angka1 * angka2;
        break;
      case '/':
        hasil = angka2 != 0 ? angka1 / angka2 : 0; 
        break;
      default:
        hasil = 0;
    }

    setState(() {
      _hasil = "Hasil: $hasil";
    });
  }


  @override
  Widget build(BuildContext context){
return Scaffold(
    appBar : AppBar(title : Text('Kalkulator Flutter')),
    body : Padding(
      padding: EdgeInsets.all(20.0),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller : _angka1,
            keyboardType : TextInputType.number,
            decoration: InputDecoration(
              labelText: "Masukkan Angka Pertama",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              filled: true,
              fillColor: Colors.teal.shade50,
            ),
          ),

          SizedBox(height: 20),
          TextField(
            controller : _angka2,
            keyboardType : TextInputType.number,
              decoration: InputDecoration(
              labelText: "Masukkan Angka Kedua",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              filled: true,
              fillColor: Colors.teal.shade50,
            ),
            ),
          

          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ElevatedButton(
                onPressed: () => _hitung('+'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text('+', style: TextStyle(fontSize: 12)),
              ),

              ElevatedButton(
                onPressed: () => _hitung('-'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text('-', style: TextStyle(fontSize: 12)),
              ),

              ElevatedButton(
                onPressed: () => _hitung('*'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text('*', style: TextStyle(fontSize: 12)),
              ),

              ElevatedButton(
                onPressed: () => _hitung('/'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text('/', style: TextStyle(fontSize: 12)),
              ),

             
            ],
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _reset,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text('Reset'),
          ),
          if (_hasil.isNotEmpty)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child : Center(
              child: Text(
               _hasil,
              style: TextStyle(
                fontSize: 24, 
                color: Colors.teal[700],
                fontWeight: FontWeight.bold
                ),
             )
            ),
          )
          ],
      )
    )
);
  }
}
