import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: PeriodicTableApp(),
  ));
}

class PeriodicTableApp extends StatefulWidget {
  const PeriodicTableApp({super.key});

  @override
  PeriodicTableAppState createState() => PeriodicTableAppState();
}

class PeriodicTableAppState extends State<PeriodicTableApp> {
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
        _result = "Oops! We cannot spell it with elements of periodic table.";
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
          title: Center(child: Column(
            children: [
              Text(elementData?['name']),
              const Divider(color: Colors.grey),

            ],
          )),

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
              child: const Text('Close',style: TextStyle(color: Colors.orangeAccent),),
            ),
          ],
        );
      },
    );
  }

  final List<Color> _boxColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
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
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.science,
          size: 24.0,
          color: Colors.pinkAccent,
        ),
        title: const Text(
          'Periodic Table Element Checker',
          style:
              TextStyle(fontFamily: 'Noto Sans', fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () {
              launchUrl(
                Uri.parse('https://github.com/saikishan5000'),
                mode: LaunchMode.externalApplication,
              );
            },
            icon: const Icon(
              Icons.language,
              size: 24.0,
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xF4FF4500),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("lib/assets/bg.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color(0xFFFF4500).withOpacity(0.1),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _sentenceController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Enter a sentence',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20), // Adjust padding as needed
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: const Color(0x5E000000).withOpacity(0.3),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: const Color(0x5E000000).withOpacity(0.3),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_sentenceController.text.isNotEmpty) {
                      checkPeriodicTable();
                      FocusScope.of(context).unfocus();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Center(child: Text('Please enter a sentence.')),
                      ));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        side: const BorderSide(
                          color: Colors.blueAccent,
                          width: 1,
                        ),
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shadowColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Check',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                if (_showResult)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!_result.contains("Oops"))
                        const Text(
                          'Congratulations! Your comment can be spelled using the elements of the periodic table:',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      const SizedBox(height: 10.0),
                      if (!_result.contains("Oops"))
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: _result.split(' ').map((element) {
                            final index = periodicTableElements.keys
                                    .toList()
                                    .indexOf(element.toLowerCase()) +
                                1;
                            final color = _boxColors[index %
                                _boxColors
                                    .length]; // Assign color based on atomic number

                            return GestureDetector(
                              onTap: () {
                                _showElementInfo(context, element);
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                margin: const EdgeInsets.all(4.0),
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
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      element,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      if (_result.contains("Oops"))
                        Text(
                          _result,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  launchUrl(
                    Uri.parse('https://www.linkedin.com/in/saikishan5000'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Website built by ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Noto Sans',
                                fontWeight: FontWeight.w500,
                                height: 0.06,
                              ),
                            ),
                            TextSpan(
                              text: 'Sai Kishan',
                              style: TextStyle(
                                color: Color(0xFFFF4500),
                                fontSize: 16,
                                fontFamily: 'Noto Sans',
                                fontWeight: FontWeight.w500,
                                height: 0.06,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )),
        ],
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
  'h': {'name': 'Hydrogen', 'atomicNumber': 1, 'symbol': 'H', 'atomicWeight': 1.008},
  'he': {'name': 'Helium', 'atomicNumber': 2, 'symbol': 'He', 'atomicWeight': 4.0026},
  'li': {'name': 'Lithium', 'atomicNumber': 3, 'symbol': 'Li', 'atomicWeight': 6.94},
  'be': {'name': 'Beryllium', 'atomicNumber': 4, 'symbol': 'Be', 'atomicWeight': 9.0122},
  'b': {'name': 'Boron', 'atomicNumber': 5, 'symbol': 'B', 'atomicWeight': 10.81},
  'c': {'name': 'Carbon', 'atomicNumber': 6, 'symbol': 'C', 'atomicWeight': 12.011},
  'n': {'name': 'Nitrogen', 'atomicNumber': 7, 'symbol': 'N', 'atomicWeight': 14.007},
  'o': {'name': 'Oxygen', 'atomicNumber': 8, 'symbol': 'O', 'atomicWeight': 15.999},
  'f': {'name': 'Fluorine', 'atomicNumber': 9, 'symbol': 'F', 'atomicWeight': 18.998},
  'ne': {'name': 'Neon', 'atomicNumber': 10, 'symbol': 'Ne', 'atomicWeight': 20.180},
  'na': {'name': 'Sodium', 'atomicNumber': 11, 'symbol': 'Na', 'atomicWeight': 22.990},
  'mg': {'name': 'Magnesium', 'atomicNumber': 12, 'symbol': 'Mg', 'atomicWeight': 24.305},
  'al': {'name': 'Aluminum', 'atomicNumber': 13, 'symbol': 'Al', 'atomicWeight': 26.982},
  'si': {'name': 'Silicon', 'atomicNumber': 14, 'symbol': 'Si', 'atomicWeight': 28.085},
  'p': {'name': 'Phosphorus', 'atomicNumber': 15, 'symbol': 'P', 'atomicWeight': 30.974},
  's': {'name': 'Sulfur', 'atomicNumber': 16, 'symbol': 'S', 'atomicWeight': 32.06},
  'cl': {'name': 'Chlorine', 'atomicNumber': 17, 'symbol': 'Cl', 'atomicWeight': 35.45},
  'ar': {'name': 'Argon', 'atomicNumber': 18, 'symbol': 'Ar', 'atomicWeight': 39.948},
  'k': {'name': 'Potassium', 'atomicNumber': 19, 'symbol': 'K', 'atomicWeight': 39.098},
  'ca': {'name': 'Calcium', 'atomicNumber': 20, 'symbol': 'Ca', 'atomicWeight': 40.078},
  'sc': {'name': 'Scandium', 'atomicNumber': 21, 'symbol': 'Sc', 'atomicWeight': 44.956},
  'ti': {'name': 'Titanium', 'atomicNumber': 22, 'symbol': 'Ti', 'atomicWeight': 47.867},
  'v': {'name': 'Vanadium', 'atomicNumber': 23, 'symbol': 'V', 'atomicWeight': 50.942},
  'cr': {'name': 'Chromium', 'atomicNumber': 24, 'symbol': 'Cr', 'atomicWeight': 51.996},
  'mn': {'name': 'Manganese', 'atomicNumber': 25, 'symbol': 'Mn', 'atomicWeight': 54.938},
  'fe': {'name': 'Iron', 'atomicNumber': 26, 'symbol': 'Fe', 'atomicWeight': 55.845},
  'co': {'name': 'Cobalt', 'atomicNumber': 27, 'symbol': 'Co', 'atomicWeight': 58.933},
  'ni': {'name': 'Nickel', 'atomicNumber': 28, 'symbol': 'Ni', 'atomicWeight': 58.693},
  'cu': {'name': 'Copper', 'atomicNumber': 29, 'symbol': 'Cu', 'atomicWeight': 63.546},
  'zn': {'name': 'Zinc', 'atomicNumber': 30, 'symbol': 'Zn', 'atomicWeight': 65.38},
  'ga': {'name': 'Gallium', 'atomicNumber': 31, 'symbol': 'Ga', 'atomicWeight': 69.723},
  'ge': {'name': 'Germanium', 'atomicNumber': 32, 'symbol': 'Ge', 'atomicWeight': 72.63},
  'as': {'name': 'Arsenic', 'atomicNumber': 33, 'symbol': 'As', 'atomicWeight': 74.922},
  'se': {'name': 'Selenium', 'atomicNumber': 34, 'symbol': 'Se', 'atomicWeight': 78.971},
  'br': {'name': 'Bromine', 'atomicNumber': 35, 'symbol': 'Br', 'atomicWeight': 79.904},
  'kr': {'name': 'Krypton', 'atomicNumber': 36, 'symbol': 'Kr', 'atomicWeight': 83.798},
  'rb': {'name': 'Rubidium', 'atomicNumber': 37, 'symbol': 'Rb', 'atomicWeight': 85.468},
  'sr': {'name': 'Strontium', 'atomicNumber': 38, 'symbol': 'Sr', 'atomicWeight': 87.62},
  'y': {'name': 'Yttrium', 'atomicNumber': 39, 'symbol': 'Y', 'atomicWeight': 88.906},
  'zr': {'name': 'Zirconium', 'atomicNumber': 40, 'symbol': 'Zr', 'atomicWeight': 91.224},
  'nb': {'name': 'Niobium', 'atomicNumber': 41, 'symbol': 'Nb', 'atomicWeight': 92.906},
  'mo': {'name': 'Molybdenum', 'atomicNumber': 42, 'symbol': 'Mo', 'atomicWeight': 95.95},
  'tc': {'name': 'Technetium', 'atomicNumber': 43, 'symbol': 'Tc', 'atomicWeight': 98},
  'ru': {'name': 'Ruthenium', 'atomicNumber': 44, 'symbol': 'Ru', 'atomicWeight': 101.07},
  'rh': {'name': 'Rhodium', 'atomicNumber': 45, 'symbol': 'Rh', 'atomicWeight': 102.91},
  'pd': {'name': 'Palladium', 'atomicNumber': 46, 'symbol': 'Pd', 'atomicWeight': 106.42},
  'ag': {'name': 'Silver', 'atomicNumber': 47, 'symbol': 'Ag', 'atomicWeight': 107.87},
  'cd': {'name': 'Cadmium', 'atomicNumber': 48, 'symbol': 'Cd', 'atomicWeight': 112.41},
  'in': {'name': 'Indium', 'atomicNumber': 49, 'symbol': 'In', 'atomicWeight': 114.82},
  'sn': {'name': 'Tin', 'atomicNumber': 50, 'symbol': 'Sn', 'atomicWeight': 118.71},
  'sb': {'name': 'Antimony', 'atomicNumber': 51, 'symbol': 'Sb', 'atomicWeight': 121.76},
  'te': {'name': 'Tellurium', 'atomicNumber': 52, 'symbol': 'Te', 'atomicWeight': 127.6},
  'i': {'name': 'Iodine', 'atomicNumber': 53, 'symbol': 'I', 'atomicWeight': 126.9},
  'xe': {'name': 'Xenon', 'atomicNumber': 54, 'symbol': 'Xe', 'atomicWeight': 131.29},
  'cs': {'name': 'Cesium', 'atomicNumber': 55, 'symbol': 'Cs', 'atomicWeight': 132.91},
  'ba': {'name': 'Barium', 'atomicNumber': 56, 'symbol': 'Ba', 'atomicWeight': 137.33},
  'la': {'name': 'Lanthanum', 'atomicNumber': 57, 'symbol': 'La', 'atomicWeight': 138.91},
  'ce': {'name': 'Cerium', 'atomicNumber': 58, 'symbol': 'Ce', 'atomicWeight': 140.12},
  'pr': {'name': 'Praseodymium', 'atomicNumber': 59, 'symbol': 'Pr', 'atomicWeight': 140.91},
  'nd': {'name': 'Neodymium', 'atomicNumber': 60, 'symbol': 'Nd', 'atomicWeight': 144.24},
  'pm': {'name': 'Promethium', 'atomicNumber': 61, 'symbol': 'Pm', 'atomicWeight': 145},
  'sm': {'name': 'Samarium', 'atomicNumber': 62, 'symbol': 'Sm', 'atomicWeight': 150.36},
  'eu': {'name': 'Europium', 'atomicNumber': 63, 'symbol': 'Eu', 'atomicWeight': 151.96},
  'gd': {'name': 'Gadolinium', 'atomicNumber': 64, 'symbol': 'Gd', 'atomicWeight': 157.25},
  'tb': {'name': 'Terbium', 'atomicNumber': 65, 'symbol': 'Tb', 'atomicWeight': 158.93},
  'dy': {'name': 'Dysprosium', 'atomicNumber': 66, 'symbol': 'Dy', 'atomicWeight': 162.5},
  'ho': {'name': 'Holmium', 'atomicNumber': 67, 'symbol': 'Ho', 'atomicWeight': 164.93},
  'er': {'name': 'Erbium', 'atomicNumber': 68, 'symbol': 'Er', 'atomicWeight': 167.26},
  'tm': {'name': 'Thulium', 'atomicNumber': 69, 'symbol': 'Tm', 'atomicWeight': 168.93},
  'yb': {'name': 'Ytterbium', 'atomicNumber': 70, 'symbol': 'Yb', 'atomicWeight': 173.05},
  'lu': {'name': 'Lutetium', 'atomicNumber': 71, 'symbol': 'Lu', 'atomicWeight': 174.97},
  'hf': {'name': 'Hafnium', 'atomicNumber': 72, 'symbol': 'Hf', 'atomicWeight': 178.49},
  'ta': {'name': 'Tantalum', 'atomicNumber': 73, 'symbol': 'Ta', 'atomicWeight': 180.95},
  'w': {'name': 'Tungsten', 'atomicNumber': 74, 'symbol': 'W', 'atomicWeight': 183.84},
  're': {'name': 'Rhenium', 'atomicNumber': 75, 'symbol': 'Re', 'atomicWeight': 186.21},
  'os': {'name': 'Osmium', 'atomicNumber': 76, 'symbol': 'Os', 'atomicWeight': 190.23},
  'ir': {'name': 'Iridium', 'atomicNumber': 77, 'symbol': 'Ir', 'atomicWeight': 192.22},
  'pt': {'name': 'Platinum', 'atomicNumber': 78, 'symbol': 'Pt', 'atomicWeight': 195.08},
  'au': {'name': 'Gold', 'atomicNumber': 79, 'symbol': 'Au', 'atomicWeight': 196.97},
  'hg': {'name': 'Mercury', 'atomicNumber': 80, 'symbol': 'Hg', 'atomicWeight': 200.59},
  'tl': {'name': 'Thallium', 'atomicNumber': 81, 'symbol': 'Tl', 'atomicWeight': 204.38},
  'pb': {'name': 'Lead', 'atomicNumber': 82, 'symbol': 'Pb', 'atomicWeight': 207.2},
  'bi': {'name': 'Bismuth', 'atomicNumber': 83, 'symbol': 'Bi', 'atomicWeight': 208.98},
  'po': {'name': 'Polonium', 'atomicNumber': 84, 'symbol': 'Po', 'atomicWeight': 209},
  'at': {'name': 'Astatine', 'atomicNumber': 85, 'symbol': 'At', 'atomicWeight': 210},
  'rn': {'name': 'Radon', 'atomicNumber': 86, 'symbol': 'Rn', 'atomicWeight': 222},
  'fr': {'name': 'Francium', 'atomicNumber': 87, 'symbol': 'Fr', 'atomicWeight': 223},
  'ra': {'name': 'Radium', 'atomicNumber': 88, 'symbol': 'Ra', 'atomicWeight': 226},
  'ac': {'name': 'Actinium', 'atomicNumber': 89, 'symbol': 'Ac', 'atomicWeight': 227},
  'th': {'name': 'Thorium', 'atomicNumber': 90, 'symbol': 'Th', 'atomicWeight': 232.04},
  'pa': {'name': 'Protactinium', 'atomicNumber': 91, 'symbol': 'Pa', 'atomicWeight': 231.04},
  'u': {'name': 'Uranium', 'atomicNumber': 92, 'symbol': 'U', 'atomicWeight': 238.03},
  'np': {'name': 'Neptunium', 'atomicNumber': 93, 'symbol': 'Np', 'atomicWeight': 237},
  'pu': {'name': 'Plutonium', 'atomicNumber': 94, 'symbol': 'Pu', 'atomicWeight': 244},
  'am': {'name': 'Americium', 'atomicNumber': 95, 'symbol': 'Am', 'atomicWeight': 243},
  'cm': {'name': 'Curium', 'atomicNumber': 96, 'symbol': 'Cm', 'atomicWeight': 247},
  'bk': {'name': 'Berkelium', 'atomicNumber': 97, 'symbol': 'Bk', 'atomicWeight': 247},
  'cf': {'name': 'Californium', 'atomicNumber': 98, 'symbol': 'Cf', 'atomicWeight': 251},
  'es': {'name': 'Einsteinium', 'atomicNumber': 99, 'symbol': 'Es', 'atomicWeight': 252},
  'fm': {'name': 'Fermium', 'atomicNumber': 100, 'symbol': 'Fm', 'atomicWeight': 257},
  'md': {'name': 'Mendelevium', 'atomicNumber': 101, 'symbol': 'Md', 'atomicWeight': 258},
  'no': {'name': 'Nobelium', 'atomicNumber': 102, 'symbol': 'No', 'atomicWeight': 259},
  'lr': {'name': 'Lawrencium', 'atomicNumber': 103, 'symbol': 'Lr', 'atomicWeight': 262},
  'rf': {'name': 'Rutherfordium', 'atomicNumber': 104, 'symbol': 'Rf', 'atomicWeight': 267},
  'db': {'name': 'Dubnium', 'atomicNumber': 105, 'symbol': 'Db', 'atomicWeight': 270},
  'sg': {'name': 'Seaborgium', 'atomicNumber': 106, 'symbol': 'Sg', 'atomicWeight': 269},
  'bh': {'name': 'Bohrium', 'atomicNumber': 107, 'symbol': 'Bh', 'atomicWeight': 270},
  'hs': {'name': 'Hassium', 'atomicNumber': 108, 'symbol': 'Hs', 'atomicWeight': 277},
  'mt': {'name': 'Meitnerium', 'atomicNumber': 109, 'symbol': 'Mt', 'atomicWeight': 278},
  'ds': {'name': 'Darmstadtium', 'atomicNumber': 110, 'symbol': 'Ds', 'atomicWeight': 281},
  'rg': {'name': 'Roentgenium', 'atomicNumber': 111, 'symbol': 'Rg', 'atomicWeight': 282},
  'cn': {'name': 'Copernicium', 'atomicNumber': 112, 'symbol': 'Cn', 'atomicWeight': 285},
  'nh': {'name': 'Nihonium', 'atomicNumber': 113, 'symbol': 'Nh', 'atomicWeight': 286},
  'fl': {'name': 'Flerovium', 'atomicNumber': 114, 'symbol': 'Fl', 'atomicWeight': 289},
  'mc': {'name': 'Moscovium', 'atomicNumber': 115, 'symbol': 'Mc', 'atomicWeight': 290},
  'lv': {'name': 'Livermorium', 'atomicNumber': 116, 'symbol': 'Lv', 'atomicWeight': 293},
  'ts': {'name': 'Tennessine', 'atomicNumber': 117, 'symbol': 'Ts', 'atomicWeight': 294},
  'og': {'name': 'Oganesson', 'atomicNumber': 118, 'symbol': 'Og', 'atomicWeight': 294},
};
