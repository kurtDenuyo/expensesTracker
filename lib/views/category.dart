
import 'dart:convert';
import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/categoryModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _categoryState();
}
class _categoryState extends State<category> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Select Category",
        style: TextStyle(
          fontFamily: 'Nunito-Regular'
        ),),
      ),
      body: createBody(),
    );
  }
}
class createBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _createBodyState();
}
class _createBodyState extends State<createBody> {
  static const API = 'http://expenses.koda.ws/';
  Future<CategoryModel> loadCategory() async{
    final categoryResponse = await dataProvider().fetchCategory();
    return categoryResponse;
}

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        FutureBuilder(
          future: loadCategory(),
          builder: (context,AsyncSnapshot<CategoryModel> snapshot){
            if(snapshot.connectionState == ConnectionState.done)
              {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.categories.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1)
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(snapshot.data.categories[index].name),
                        leading: SizedBox(
                          width: 100,
                          child: Image.network(API+
                              snapshot.data.categories[index].icon,
                              fit: BoxFit.fill),
                        ),
                        onTap: () {
                          //print([snapshot.data.categories[index].name, snapshot.data.categories[index].id]);
                          Navigator.pop(context, [snapshot.data.categories[index].name, snapshot.data.categories[index].id]);
                        },
                      ),
                    );
                  },
                );
              }
            return Center(
              child: SpinKitWave(color: Colors.green, type: SpinKitWaveType.start),
            );
          },
        )
      ],
    );
  }

}