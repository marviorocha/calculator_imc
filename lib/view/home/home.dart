import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController(text: '');
  TextEditingController alturaController = TextEditingController(text: '');

  double imc = 0.0;
  String classified = "Peso Normal";
  Color colorsResult = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Text(
                  'Calculadora IMC',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              imc == 0.0
                  ? Text(
                      textAlign: TextAlign.center,
                      "Calcule seu Índice de Massa Corporal (IMC) de forma rápida e fácil: \n basta informar seu peso e altura nos campos abaixo.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    )
                  : Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150),
                          border: Border.all(
                            color: colorsResult,
                            width: 15,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            imc.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.green[300],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            classified,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 30),
              SafeArea(
                child: SizedBox(
                  width: 400,
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              'Peso atual',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextField(
                              controller: pesoController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                suffixText: 'KG',
                                suffixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.balance,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white60,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              'Altura',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextField(
                              controller: alturaController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                suffixText: 'CM',
                                suffixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.straighten,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white60,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  try {
                    double peso = double.parse(pesoController.text);
                    double altura = double.parse(alturaController.text);
                    setState(() {
                      imc = peso / (altura * altura);
                      classified = getClassiedIMC(imc);
                      colorsResult = getColorsIMC(imc);
                    });
                  } on Exception {
                    setState(() {
                      pesoController.clear();
                      alturaController.clear();
                      imc = 0.0;
                      classified = "Peso Normal";
                      colorsResult = Colors.black;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  fixedSize: Size(300, 60),
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // button's shape
                  ),
                ),
                child: Text("Calcular"),
              ),
            ],
          ),
        ));
  }

  Color getColorsIMC(double imc) {
    if (imc < 18.5) {
      return Color(0xFF72b8db);
    } else if (imc >= 18.5 && imc < 24.9) {
      return Colors.green;
    } else if (imc >= 25 && imc < 29.9) {
      return Color(0xffffff7f);
    } else if (imc >= 30 && imc < 34.9) {
      return Color(0xfff18600);
    } else if (imc >= 35 && imc < 39.9) {
      return Color(0xFFff0000);
    } else {
      return Color.fromARGB(255, 111, 10, 10);
    }
  }

  String getClassiedIMC(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do Peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Peso Normal';
    } else if (imc >= 25 && imc < 29.9) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc < 34.9) {
      return 'Obesidade Grau I';
    } else if (imc >= 35 && imc < 39.9) {
      return 'Obesidade Grau II (severa)';
    } else {
      return 'Obesidade Grau III (mórbida)';
    }
  }
}
