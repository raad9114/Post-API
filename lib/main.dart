import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DataModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  late DataModel _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();


  submitData(String name, String job) async{
    var response= await http.post(Uri.https('reqres.in','api/users'),body:
    {"name": name,
      'job':job});
    var data = response.body;
    print (data);

    if(response.statusCode==201){
      String responseString= response.body;
      dataModelFromJson(responseString);
    }
    //else return null;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          title: Text("GET API"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Name"
                  ),
                  controller: nameController  ,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter Job Title"),
                    controller:jobController,
                ),
                ElevatedButton(onPressed:() async {
                  String name= nameController.text;
                  String job= jobController.text;
                  DataModel data= await submitData(name, job);

                  setState(() {
                    _dataModel = data;
                  });
                },
                    child: Text('Submit')),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
