import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
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
  String _input = "";

  final List<String> tombol = 
  ["7","8","9","/",
  "4","5","6","*",
  "1","2","3","-",
  "C","0","=","+"];

void _reset(){
  _angka1.clear();
  _angka2.clear();                  
  setState(() {
    _hasil = "";
    _input = "";
  });
}

void _hitungEkspresi(){
Parser p = Parser();
try{
  Expression exp = p.parse (_input);
  ContextModel  cm = ContextModel();
  double hasil = exp.evaluate(EvaluationType.REAL, cm);
  setState(() {
    _hasil = "$_input = $hasil ";
    _input = "";
      });
} catch (e){
  setState(() {
    _hasil = "Format Salah";
  });
}


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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _input,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
              _hasil,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
             

            SizedBox(height: 20),
            Expanded(
              child : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10, 
                )
                ,itemCount: tombol.length,
                itemBuilder: (context, index) {
                  final label = tombol[index];
                  return ElevatedButton(
                    onPressed: () {
                      if (label == "C"){
                        _reset();
                      }
                      else if (label == "="){
                        _hitungEkspresi();
                      }
                      else {
                        setState(() {
                        _input += label;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ["/", "*", "-", "+"].contains(label) ? Colors.teal : (label == "C" ? Colors.red : Colors.grey[200]),
                      foregroundColor: ["/","*","-","+"].contains(label) ? Colors.white : (label == "C" ? Colors.white : Colors.black),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                  
                }
                ),
              )
          ],

          
      )
));
  }
}
