import 'package:eazimeddz/utils/global.colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookADoctor extends StatefulWidget {
  const BookADoctor({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<BookADoctor> {

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Abdominal aortic aneurysm", "Location": 29},
    {"id": 2, "name": "Bipolar disorder", "Location": 40},
    {"id": 3, "name": "Cervical cancer", "Location": 5},
    {"id": 4, "name": "Deep vein thrombosis", "Location": 35},
    {"id": 5, "name": "Earache", "Location": 21},
    {"id": 6, "name": "Fever in children", "Location": 55},
    {"id": 7, "name": "Gallstones", "Location": 30},
    {"id": 8, "name": "Headaches", "Location": 14},
    {"id": 9, "name": "Idiopathic pulmonary fibrosis", "age": 100},
    {"id": 10, "name": "Kidney stones", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {

    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["condition"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Text('Select Medical Condition '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Text(
                      _foundUsers[index]["id"].toString(),
                      style: const TextStyle(fontSize: 24, color:Colors.white),
                    ),
                    title: Text(_foundUsers[index]['name'], style:TextStyle(
                        color:Colors.black
                    )),
                    subtitle: Text(
                        '${_foundUsers[index]["age"].toString()} ',style:TextStyle(
                        color:Colors.black
                    )),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}