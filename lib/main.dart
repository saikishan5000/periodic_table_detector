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
              Text("Atomic Number: ${elementData['atomicNumber']}"),
              Text("Symbol: ${elementData['symbol']}"),
              Text("Atomic Weight: ${elementData['atomicWeight']}"),
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
                      return GestureDetector(
                        onTap: () {
                          _showElementInfo(context, element);
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
  // Add more elements...
};
