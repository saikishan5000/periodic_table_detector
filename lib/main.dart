import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PeriodicTableApp(),
  ));
}

class PeriodicTableApp extends StatefulWidget {
  @override
  _PeriodicTableAppState createState() => _PeriodicTableAppState();
}

class _PeriodicTableAppState extends State<PeriodicTableApp> {
  final TextEditingController _sentenceController = TextEditingController();
  String _result = '';
  bool _showResult = false;

  // Function to check the periodic table elements in the input sentence
  void checkPeriodicTable() {
    String sentence = _sentenceController.text.toLowerCase();
    Map<String, String> elements = periodicTableElements;

    Set<String> elementsFound = {};

    for (int i = 0; i < sentence.length; i++) {
      for (int j = i + 1; j <= sentence.length; j++) {
        String substring = sentence.substring(i, j);
        if (elements.containsKey(substring) &&
            !elementsFound.contains(elements[substring])) {
          elementsFound.add(elements[substring]!);
        }
      }
    }


    setState(() {
      if (elementsFound.isNotEmpty) {
        _result = elementsFound.join(' ');
        _showResult = true;
      } else {
        _result = "Oops! We cannot spell it with periodic elements.";
        _showResult = true;
      }
    });
  }

  // Function to show element info popup
  void _showElementInfo(BuildContext context, String element) {
    final elementData = periodicTableData[element.toLowerCase()];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(element),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Atomic Number: ${elementData?['atomicNumber'] ?? 'N/A'}"),
              Text("Symbol: ${elementData?['symbol'] ?? 'N/A'}"),
              Text("Atomic Weight: ${elementData?['atomicWeight'] ?? 'N/A'}"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  List<Color> _boxColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
    Colors.deepOrange,
    Colors.cyan,
    Colors.deepPurple,
    Colors.lime,
    Colors.lightBlue,
    Colors.pink,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Periodic Table Checker'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _sentenceController,
                maxLines: null, // Allows the text field to expand vertically
                decoration: InputDecoration(
                  labelText: 'Enter a sentence',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_sentenceController.text.isNotEmpty) {
                  checkPeriodicTable();
                  FocusScope.of(context).unfocus();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter a sentence.'),
                  ));
                }
              },
              child: Text(
                'Check',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            if (_showResult)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_result.contains("Oops"))
                    Text(
                      'Congratulations! Your comment can be spelled using the elements of the periodic table:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  SizedBox(height: 10.0),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: _result.split(' ').map((element) {
                      final index = periodicTableElements.keys.toList().indexOf(element.toLowerCase()) + 1;
                      final color = _boxColors[index % _boxColors.length]; // Assign color based on atomic number

                      return GestureDetector(
                        onTap: () {
                          _showElementInfo(context, element);
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$index',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                              Text(
                                element,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sentenceController.dispose();
    super.dispose();
  }
}

// Constants
const Map<String, String> periodicTableElements = {
  'h': 'H',
  'he': 'He',
  'li': 'Li',
  'be': 'Be',
  'b': 'B',
  'c': 'C',
  'n': 'N',
  'o': 'O',
  'f': 'F',
  'ne': 'Ne',
  'na': 'Na',
  'mg': 'Mg',
  'al': 'Al',
  'si': 'Si',
  'p': 'P',
  's': 'S',
  'cl': 'Cl',
  'ar': 'Ar',
  'k': 'K',
  'ca': 'Ca',
  'sc': 'Sc',
  'ti': 'Ti',
  'v': 'V',
  'cr': 'Cr',
  'mn': 'Mn',
  'fe': 'Fe',
  'co': 'Co',
  'ni': 'Ni',
  'cu': 'Cu',
  'zn': 'Zn',
  'ga': 'Ga',
  'ge': 'Ge',
  'as': 'As',
  'se': 'Se',
  'br': 'Br',
  'kr': 'Kr',
  'rb': 'Rb',
  'sr': 'Sr',
  'y': 'Y',
  'zr': 'Zr',
  'nb': 'Nb',
  'mo': 'Mo',
  'tc': 'Tc',
  'ru': 'Ru',
  'rh': 'Rh',
  'pd': 'Pd',
  'ag': 'Ag',
  'cd': 'Cd',
  'in': 'In',
  'sn': 'Sn',
  'sb': 'Sb',
  'te': 'Te',
  'i': 'I',
  'xe': 'Xe',
  'cs': 'Cs',
  'ba': 'Ba',
  'la': 'La',
  'ce': 'Ce',
  'pr': 'Pr',
  'nd': 'Nd',
  'pm': 'Pm',
  'sm': 'Sm',
  'eu': 'Eu',
  'gd': 'Gd',
  'tb': 'Tb',
  'dy': 'Dy',
  'ho': 'Ho',
  'er': 'Er',
  'tm': 'Tm',
  'yb': 'Yb',
  'lu': 'Lu',
  'hf': 'Hf',
  'ta': 'Ta',
  'w': 'W',
  're': 'Re',
  'os': 'Os',
  'ir': 'Ir',
  'pt': 'Pt',
  'au': 'Au',
  'hg': 'Hg',
  'tl': 'Tl',
  'pb': 'Pb',
  'bi': 'Bi',
  'po': 'Po',
  'at': 'At',
  'rn': 'Rn',
  'fr': 'Fr',
  'ra': 'Ra',
  'ac': 'Ac',
  'th': 'Th',
  'pa': 'Pa',
  'u': 'U',
  'np': 'Np',
  'pu': 'Pu',
  'am': 'Am',
  'cm': 'Cm',
  'bk': 'Bk',
  'cf': 'Cf',
  'es': 'Es',
  'fm': 'Fm',
  'md': 'Md',
  'no': 'No',
  'lr': 'Lr',
  'rf': 'Rf',
  'db': 'Db',
  'sg': 'Sg',
  'bh': 'Bh',
  'hs': 'Hs',
  'mt': 'Mt',
  'ds': 'Ds',
  'rg': 'Rg',
  'cn': 'Cn',
  'nh': 'Nh',
  'fl': 'Fl',
  'mc': 'Mc',
  'lv': 'Lv',
  'ts': 'Ts',
  'og': 'Og'
};

// Element data with atomic number, symbol, and atomic weight
const Map<String, Map<String, dynamic>> periodicTableData = {
  'h': {'atomicNumber': 1, 'symbol': 'H', 'atomicWeight': 1.008},
  'he': {'atomicNumber': 2, 'symbol': 'He', 'atomicWeight': 4.0026},
  'li': {'atomicNumber': 3, 'symbol': 'Li', 'atomicWeight': 6.94},
  'be': {'atomicNumber': 4, 'symbol': 'Be', 'atomicWeight': 9.0122},
  'b': {'atomicNumber': 5, 'symbol': 'B', 'atomicWeight': 10.81},
  'c': {'atomicNumber': 6, 'symbol': 'C', 'atomicWeight': 12.011},
  'n': {'atomicNumber': 7, 'symbol': 'N', 'atomicWeight': 14.007},
  'o': {'atomicNumber': 8, 'symbol': 'O', 'atomicWeight': 15.999},
  'f': {'atomicNumber': 9, 'symbol': 'F', 'atomicWeight': 18.998},
  'ne': {'atomicNumber': 10, 'symbol': 'Ne', 'atomicWeight': 20.180},
  'na': {'atomicNumber': 11, 'symbol': 'Na', 'atomicWeight': 22.990},
  'mg': {'atomicNumber': 12, 'symbol': 'Mg', 'atomicWeight': 24.305},
  'al': {'atomicNumber': 13, 'symbol': 'Al', 'atomicWeight': 26.982},
  'si': {'atomicNumber': 14, 'symbol': 'Si', 'atomicWeight': 28.085},
  'p': {'atomicNumber': 15, 'symbol': 'P', 'atomicWeight': 30.974},
  's': {'atomicNumber': 16, 'symbol': 'S', 'atomicWeight': 32.06},
  'cl': {'atomicNumber': 17, 'symbol': 'Cl', 'atomicWeight': 35.45},
  'ar': {'atomicNumber': 18, 'symbol': 'Ar', 'atomicWeight': 39.948},
  'k': {'atomicNumber': 19, 'symbol': 'K', 'atomicWeight': 39.098},
  'ca': {'atomicNumber': 20, 'symbol': 'Ca', 'atomicWeight': 40.078},
  'sc': {'atomicNumber': 21, 'symbol': 'Sc', 'atomicWeight': 44.956},
  'ti': {'atomicNumber': 22, 'symbol': 'Ti', 'atomicWeight': 47.867},
  'v': {'atomicNumber': 23, 'symbol': 'V', 'atomicWeight': 50.942},
  'cr': {'atomicNumber': 24, 'symbol': 'Cr', 'atomicWeight': 51.996},
  'mn': {'atomicNumber': 25, 'symbol': 'Mn', 'atomicWeight': 54.938},
  'fe': {'atomicNumber': 26, 'symbol': 'Fe', 'atomicWeight': 55.845},
  'co': {'atomicNumber': 27, 'symbol': 'Co', 'atomicWeight': 58.933},
  'ni': {'atomicNumber': 28, 'symbol': 'Ni', 'atomicWeight': 58.693},
  'cu': {'atomicNumber': 29, 'symbol': 'Cu', 'atomicWeight': 63.546},
  'zn': {'atomicNumber': 30, 'symbol': 'Zn', 'atomicWeight': 65.38},
  'ga': {'atomicNumber': 31, 'symbol': 'Ga', 'atomicWeight': 69.723},
  'ge': {'atomicNumber': 32, 'symbol': 'Ge', 'atomicWeight': 72.63},
  'as': {'atomicNumber': 33, 'symbol': 'As', 'atomicWeight': 74.922},
  'se': {'atomicNumber': 34, 'symbol': 'Se', 'atomicWeight': 78.971},
  'br': {'atomicNumber': 35, 'symbol': 'Br', 'atomicWeight': 79.904},
  'kr': {'atomicNumber': 36, 'symbol': 'Kr', 'atomicWeight': 83.798},
  'rb': {'atomicNumber': 37, 'symbol': 'Rb', 'atomicWeight': 85.468},
  'sr': {'atomicNumber': 38, 'symbol': 'Sr', 'atomicWeight': 87.62},
  'y': {'atomicNumber': 39, 'symbol': 'Y', 'atomicWeight': 88.906},
  'zr': {'atomicNumber': 40, 'symbol': 'Zr', 'atomicWeight': 91.224},
  'nb': {'atomicNumber': 41, 'symbol': 'Nb', 'atomicWeight': 92.906},
  'mo': {'atomicNumber': 42, 'symbol': 'Mo', 'atomicWeight': 95.95},
  'tc': {'atomicNumber': 43, 'symbol': 'Tc', 'atomicWeight': 98},
  'ru': {'atomicNumber': 44, 'symbol': 'Ru', 'atomicWeight': 101.07},
  'rh': {'atomicNumber': 45, 'symbol': 'Rh', 'atomicWeight': 102.91},
  'pd': {'atomicNumber': 46, 'symbol': 'Pd', 'atomicWeight': 106.42},
  'ag': {'atomicNumber': 47, 'symbol': 'Ag', 'atomicWeight': 107.87},
  'cd': {'atomicNumber': 48, 'symbol': 'Cd', 'atomicWeight': 112.41},
  'in': {'atomicNumber': 49, 'symbol': 'In', 'atomicWeight': 114.82},
  'sn': {'atomicNumber': 50, 'symbol': 'Sn', 'atomicWeight': 118.71},
  'sb': {'atomicNumber': 51, 'symbol': 'Sb', 'atomicWeight': 121.76},
  'te': {'atomicNumber': 52, 'symbol': 'Te', 'atomicWeight': 127.6},
  'i': {'atomicNumber': 53, 'symbol': 'I', 'atomicWeight': 126.9},
  'xe': {'atomicNumber': 54, 'symbol': 'Xe', 'atomicWeight': 131.29},
  'cs': {'atomicNumber': 55, 'symbol': 'Cs', 'atomicWeight': 132.91},
  'ba': {'atomicNumber': 56, 'symbol': 'Ba', 'atomicWeight': 137.33},
  'la': {'atomicNumber': 57, 'symbol': 'La', 'atomicWeight': 138.91},
  'ce': {'atomicNumber': 58, 'symbol': 'Ce', 'atomicWeight': 140.12},
  'pr': {'atomicNumber': 59, 'symbol': 'Pr', 'atomicWeight': 140.91},
  'nd': {'atomicNumber': 60, 'symbol': 'Nd', 'atomicWeight': 144.24},
  'pm': {'atomicNumber': 61, 'symbol': 'Pm', 'atomicWeight': 145},
  'sm': {'atomicNumber': 62, 'symbol': 'Sm', 'atomicWeight': 150.36},
  'eu': {'atomicNumber': 63, 'symbol': 'Eu', 'atomicWeight': 151.96},
  'gd': {'atomicNumber': 64, 'symbol': 'Gd', 'atomicWeight': 157.25},
  'tb': {'atomicNumber': 65, 'symbol': 'Tb', 'atomicWeight': 158.93},
  'dy': {'atomicNumber': 66, 'symbol': 'Dy', 'atomicWeight': 162.5},
  'ho': {'atomicNumber': 67, 'symbol': 'Ho', 'atomicWeight': 164.93},
  'er': {'atomicNumber': 68, 'symbol': 'Er', 'atomicWeight': 167.26},
  'tm': {'atomicNumber': 69, 'symbol': 'Tm', 'atomicWeight': 168.93},
  'yb': {'atomicNumber': 70, 'symbol': 'Yb', 'atomicWeight': 173.05},
  'lu': {'atomicNumber': 71, 'symbol': 'Lu', 'atomicWeight': 174.97},
  'hf': {'atomicNumber': 72, 'symbol': 'Hf', 'atomicWeight': 178.49},
  'ta': {'atomicNumber': 73, 'symbol': 'Ta', 'atomicWeight': 180.95},
  'w': {'atomicNumber': 74, 'symbol': 'W', 'atomicWeight': 183.84},
  're': {'atomicNumber': 75, 'symbol': 'Re', 'atomicWeight': 186.21},
  'os': {'atomicNumber': 76, 'symbol': 'Os', 'atomicWeight': 190.23},
  'ir': {'atomicNumber': 77, 'symbol': 'Ir', 'atomicWeight': 192.22},
  'pt': {'atomicNumber': 78, 'symbol': 'Pt', 'atomicWeight': 195.08},
  'au': {'atomicNumber': 79, 'symbol': 'Au', 'atomicWeight': 196.97},
  'hg': {'atomicNumber': 80, 'symbol': 'Hg', 'atomicWeight': 200.59},
  'tl': {'atomicNumber': 81, 'symbol': 'Tl', 'atomicWeight': 204.38},
  'pb': {'atomicNumber': 82, 'symbol': 'Pb', 'atomicWeight': 207.2},
  'bi': {'atomicNumber': 83, 'symbol': 'Bi', 'atomicWeight': 208.98},
  'po': {'atomicNumber': 84, 'symbol': 'Po', 'atomicWeight': 209},
  'at': {'atomicNumber': 85, 'symbol': 'At', 'atomicWeight': 210},
  'rn': {'atomicNumber': 86, 'symbol': 'Rn', 'atomicWeight': 222},
  'fr': {'atomicNumber': 87, 'symbol': 'Fr', 'atomicWeight': 223},
  'ra': {'atomicNumber': 88, 'symbol': 'Ra', 'atomicWeight': 226},
  'ac': {'atomicNumber': 89, 'symbol': 'Ac', 'atomicWeight': 227},
  'th': {'atomicNumber': 90, 'symbol': 'Th', 'atomicWeight': 232.04},
  'pa': {'atomicNumber': 91, 'symbol': 'Pa', 'atomicWeight': 231.04},
  'u': {'atomicNumber': 92, 'symbol': 'U', 'atomicWeight': 238.03},
  'np': {'atomicNumber': 93, 'symbol': 'Np', 'atomicWeight': 237},
  'pu': {'atomicNumber': 94, 'symbol': 'Pu', 'atomicWeight': 244},
  'am': {'atomicNumber': 95, 'symbol': 'Am', 'atomicWeight': 243},
  'cm': {'atomicNumber': 96, 'symbol': 'Cm', 'atomicWeight': 247},
  'bk': {'atomicNumber': 97, 'symbol': 'Bk', 'atomicWeight': 247},
  'cf': {'atomicNumber': 98, 'symbol': 'Cf', 'atomicWeight': 251},
  'es': {'atomicNumber': 99, 'symbol': 'Es', 'atomicWeight': 252},
  'fm': {'atomicNumber': 100, 'symbol': 'Fm', 'atomicWeight': 257},
  'md': {'atomicNumber': 101, 'symbol': 'Md', 'atomicWeight': 258},
  'no': {'atomicNumber': 102, 'symbol': 'No', 'atomicWeight': 259},
  'lr': {'atomicNumber': 103, 'symbol': 'Lr', 'atomicWeight': 262},
  'rf': {'atomicNumber': 104, 'symbol': 'Rf', 'atomicWeight': 267},
  'db': {'atomicNumber': 105, 'symbol': 'Db', 'atomicWeight': 270},
  'sg': {'atomicNumber': 106, 'symbol': 'Sg', 'atomicWeight': 269},
  'bh': {'atomicNumber': 107, 'symbol': 'Bh', 'atomicWeight': 270},
  'hs': {'atomicNumber': 108, 'symbol': 'Hs', 'atomicWeight': 277},
  'mt': {'atomicNumber': 109, 'symbol': 'Mt', 'atomicWeight': 278},
  'ds': {'atomicNumber': 110, 'symbol': 'Ds', 'atomicWeight': 281},
  'rg': {'atomicNumber': 111, 'symbol': 'Rg', 'atomicWeight': 282},
  'cn': {'atomicNumber': 112, 'symbol': 'Cn', 'atomicWeight': 285},
  'nh': {'atomicNumber': 113, 'symbol': 'Nh', 'atomicWeight': 286},
  'fl': {'atomicNumber': 114, 'symbol': 'Fl', 'atomicWeight': 289},
  'mc': {'atomicNumber': 115, 'symbol': 'Mc', 'atomicWeight': 290},
  'lv': {'atomicNumber': 116, 'symbol': 'Lv', 'atomicWeight': 293},
  'ts': {'atomicNumber': 117, 'symbol': 'Ts', 'atomicWeight': 294},
  'og': {'atomicNumber': 118, 'symbol': 'Og', 'atomicWeight': 294},
};

