import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import '../UI/common.dart';

class ChangePP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangePerPage();
  }
}

class ChangePerPage extends StatefulWidget {
  @override
  State<ChangePerPage> createState() => _ChangePerPage();
}

class _ChangePerPage extends State<ChangePerPage> {
  Map<String, TextEditingController> _controllerMap = Map();
  Map<String, TextEditingController> _controllerMapSize = Map();
  List<String> _dataGrade = [
    "FE500",
    "FE500D",
    "FE550",
    "FE550D",
    "FE600",
  ];
  List<String> _percGrade = [
    "1",
    "2",
    "4",
    "8",
    "8",
  ];
  List<String> _dataSize = [
    "8MM",
    "10MM",
    "20MM",
    "30MM",
    "40MM",
  ];
  List<String> _percSize = [
    "1",
    "2",
    "4",
    "8",
    "8",
  ];

  Future<List<String>> _retrieveData() {
    return Future.value(_dataGrade);
  }

  Future<List<String>> _retrieveDataSize() {
    return Future.value(_dataSize);
  }

  @override
  void dispose() {
    _controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Change Price", () {
        Navigator.pop(context);
      }),
      body: ChangePriceBody(),
    );
  }

  Widget ChangePriceBody() {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2.0)]),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // height: MediaQuery.of(context).size.height / 1.2,

              // padding: EdgeInsets.only(top: 5),
              child: ContainedTabBarView(
                tabBarProperties: TabBarProperties(
                    background: Container(
                  width: MediaQuery.of(context).size.width / 2,
                )),
                tabs: [
                  Container(
                    child: Text('Grade', style: TextStyle(color: Colors.black)),
                    height: 50,
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: Text('Size', style: TextStyle(color: Colors.black)),
                    height: 50,
                    alignment: Alignment.center,
                  ),
                ],
                views: [
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Expanded(child: _futureBuilder()),
                          _cancelOkButton(),
                        ],
                      )),

                  //--------------------------Sizes-------------------------------//
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Expanded(child: _futureBuilderSize()),
                          _cancelOkButtonSize(),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _futureBuilder() {
    return FutureBuilder(
      future: _retrieveData(),
      builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
        if (!snapshot.hasData) {
          return Align(
            alignment: Alignment.topCenter,
            child: Text("No item"),
          );
        }

        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            final controller = _getControllerOf(_dataGrade[index]);

            final text = Row(
              children: [
                Container(
                  child:
                      Text(_dataGrade[index], style: TextStyle(fontSize: 18)),
                  width: 100,
                ),
                Container(
                  child: Text(":", style: TextStyle(fontSize: 18)),
                  width: 50,
                ),
                Container(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(suffixText: "%"),
                    textAlign: TextAlign.center,
                  ),
                  width: 80,
                  height: 25,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            );

            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                text,
              ],
            );
          },
        );
      },
    );
  }

  Widget _futureBuilderSize() {
    return FutureBuilder(
      future: _retrieveDataSize(),
      builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
        if (!snapshot.hasData) {
          return Align(
            alignment: Alignment.topCenter,
            child: Text("No item"),
          );
        }

        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            final controller = _getSizeControllerOf(_dataSize[index]);

            final text = Row(
              children: [
                Container(
                  child: Text(_dataSize[index], style: TextStyle(fontSize: 18)),
                  width: 100,
                ),
                Container(
                  child: Text(":", style: TextStyle(fontSize: 18)),
                  width: 50,
                ),
                Container(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(suffixText: "%"),
                    textAlign: TextAlign.center,
                  ),
                  width: 80,
                  height: 25,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            );

            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                text,
              ],
            );
          },
        );
      },
    );
  }

  Widget _cancelOkButton() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _cancelButton(),
          _okButton(),
        ],
      ),
    );
  }

  Widget _cancelOkButtonSize() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _cancelButtonSize(),
          _okButtonSize(),
        ],
      ),
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _controllerMap.forEach((key, controller) {
            controller.text = key;
          });
        });
      },
      child: Text("Cancel"),
    );
  }

  Widget _cancelButtonSize() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _controllerMapSize.forEach((key, controller) {
            controller.text = key;
          });
        });
      },
      child: Text("Cancel"),
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllerMap.values
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");

        setState(() {
          _controllerMap.forEach((key, controller) {
            // get the index of original text
            int index = _controllerMap.keys.toList().indexOf(key);
            key = controller.text;
            _percGrade[index] = controller.text;
          });
        });
        print(_percGrade);
      },
      child: Text("OK"),
    );
  }

  Widget _okButtonSize() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllerMapSize.values
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");

        setState(() {
          _controllerMapSize.forEach((key, controller) {
            // get the index of original text
            int index = _controllerMapSize.keys.toList().indexOf(key);
            key = controller.text;
            _percSize[index] = controller.text;
          });
        });
        print(_percSize);
      },
      child: Text("OK"),
    );
  }

  TextEditingController _getControllerOf(String name) {
    var controller = _controllerMap[name];
    if (controller == null) {
      controller = TextEditingController(text: "0");
      _controllerMap[name] = controller;
    }

    return controller;
  }

  TextEditingController _getSizeControllerOf(String name) {
    var controller = _controllerMapSize[name];
    if (controller == null) {
      controller = TextEditingController(text: "0");
      _controllerMapSize[name] = controller;
    }

    return controller;
  }
}
