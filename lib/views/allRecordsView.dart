
import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/categoryModel.dart';
import 'package:expensestracker/models/usersModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'editRecord.dart';
class allRecords extends StatefulWidget {
  final UserModel currentUsers;
  const allRecords(this.currentUsers);
  @override
  State<StatefulWidget> createState() => _allRecordsState();
}
class _allRecordsState extends State<allRecords> {
  int present, perPage;
  RecordsModel recordData, searchResults, paginationRecord, searchpaginationRecord;
  CategoryModel categoryModel;
  bool _hasData, _hasMore, _loadingMore, _searchLoadingMore;
  bool activeSearch;
  bool _searchHasData, _searchHasMore;
  Future _initialLoad;
  String nextUrl;
  TextEditingController _searchText = TextEditingController();
  Color textColor = Colors.green;
  static const API = 'http://expenses.koda.ws/';
  Future _loadMoreItems(String next) async {
    await Future.delayed(Duration(seconds: 3), () async{
      paginationRecord = await dataProvider().loadMore(widget.currentUsers, next);
      setState(() {
        nextUrl = paginationRecord.pagination.nextUrl;
        recordData.records.addAll(paginationRecord.records);
        _hasMore = recordData.records.length < recordData.pagination.count;
        print("New Total "+ recordData.records.length.toString());
        print("Current page "+ paginationRecord.pagination.current.toString());
        print("has more? "+ _hasMore.toString());
      });

    });
  }
  Future _loadMoreSearchedItems(String next) async {
    await Future.delayed(Duration(seconds: 3), () async{
      searchpaginationRecord = await dataProvider().loadMoreSearchResults(widget.currentUsers, next);
      setState(() {
        nextUrl = searchpaginationRecord.pagination.nextUrl;
        searchResults.records.addAll(searchpaginationRecord.records);
        _searchHasMore = searchResults.records.length < searchResults.pagination.count;
        print("New Total "+ searchResults.records.length.toString());
        print("Current page "+ searchpaginationRecord.pagination.current.toString());
        print("has more? "+ _searchHasMore.toString());
      });

    });
  }
  void _search(String value) async{
    print("Search this "+value);
    final searchResponse = await dataProvider().searchRecord(widget.currentUsers, value);

    if(searchResponse.records.length>0){
      setState(() {
        searchResults = searchResponse;
        _searchHasData = true;
        _searchHasMore = false;
      });
    }
    else
      {
        setState(() {
          _searchHasData = false;
          _searchHasMore = false;
        });
      }
  }
  @override
  void initState() {
    super.initState();
    activeSearch = false;
    _searchHasData = false;
    _hasData = false;
    _initialLoad = Future.delayed(Duration(seconds: 3),() async{
      RecordsModel recordResponse = await dataProvider().fetchRecords(widget.currentUsers);
      final categoryResponse = await dataProvider().fetchCategory();
      print("Response "+ recordResponse.records.length.toString());
      print("Category "+ categoryResponse.categories.length.toString());
      recordData = recordResponse;
      categoryModel = categoryResponse;
      if(recordData.records.length>0)
        {
          _hasData = true;
        }
      _hasMore = false;
    });
  }
  void _refreshHome() async{    setState(() {
      _initialLoad = Future.delayed(Duration(seconds: 1),() async{
        RecordsModel recordResponse = await dataProvider().fetchRecords(widget.currentUsers);
        final categoryResponse = await dataProvider().fetchCategory();
        print("Reloaded "+ recordResponse.records.length.toString());
        print("Reloaded "+ categoryResponse.categories.length.toString());
        recordData = recordResponse;
        categoryModel = categoryResponse;
        _hasMore = false;
        _searchText.text = "";
        activeSearch = false;
        _searchHasData = false;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  PreferredSizeWidget _appBar() {
    if (activeSearch) {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context,true),
        ),
        title:  TextField(
          controller: _searchText,
          onChanged: _search,
          autofocus: false,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
          decoration: new InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'Nunito-Regular'),
              hintText: "Search...",
              prefixIcon: new Icon(Icons.search,color: Colors.white,)),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                activeSearch = false;
                _searchHasData = false;
                _searchText.text = "";
              });
            },
          )
        ],
      );
    } else {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context,true),
        ),
        title: Text("Records",
          style: TextStyle(
              fontFamily: 'Nunito-Regular'
          ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearch = true),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: (_searchHasData)?
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo){
            if(scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
              //_hasMore = recordData.records.length < recordData.pagination.count;
              setState(() {
                _searchHasMore = searchResults.records.length < searchResults.pagination.count;
                nextUrl = searchResults.pagination.nextUrl;
              });
            }
          },
          child: IncrementallyLoadingListView(
            hasMore: () => _searchHasMore,
            itemCount: () => searchResults.records.length,
            loadMore: () async {
              await _loadMoreSearchedItems(nextUrl);
            },
            onLoadMore: () {
              setState(() {
                _searchLoadingMore = true;
              });
            },
            onLoadMoreFinished: () {
              setState(() {
                _searchLoadingMore = false;
              });
            },
            loadMoreOffsetFromBottom: 0,
            itemBuilder: (context, index){
              final record = searchResults.records[index];

              String month = "";
              switch(searchResults.records[index].date.month) {
                case 1: {
                  month = "Jan";
                  print(month);
                }
                break;

                case 2: {
                  month = "Feb";
                  print(month);
                }
                break;
                case 3: {
                  month = "Mar";
                  print(month);
                }
                break;
                case 4: {
                  month = "Apr";
                  print(month);
                }
                break;
                case 5: {
                  month = "May";
                  print(month);
                }
                break;
                case 6: {
                  month = "Jun";
                  print(month);
                }
                break;
                case 7: {
                  month = "July";
                  print(month);
                }
                break;
                case 8: {
                  month = "Aug";
                  print(month);
                }
                break;
                case 9: {
                  month = "Sep";
                  print(month);
                }
                break;
                case 10: {
                  month = "Oct";
                  print(month);
                }
                break;
                case 11: {
                  month = "Nov";
                  print(month);
                }
                break;

                default: {
                  month = "Dec";
                  print(month);
                }
                break;
              }
              if(searchResults.records[index].recordType==1)
              {
                textColor = Colors.red;
              }
              else
              {
                textColor = Colors.green;
              }
              if((_searchLoadingMore ?? false) && index == searchResults.records.length - 1){
                print("loadMore "+ searchResults.records.length.toString());
                if(_searchLoadingMore)
                {
                  return Center(child: SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.center),);
                }
                else{
                  return ListTile(
                    //contentPadding: EdgeInsets.all(0.0),
                    title: Text("₱ "+record.amount.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: textColor,
                      ),),
                    subtitle: Text(record.category.name.toString()+"  ---"+ record.notes.toString(),
                      style: TextStyle(
                          fontSize: 15.0
                      ),),
                    leading: Image.network(API+
                        categoryModel.categories[record.category.id-1].icon,
                        fit: BoxFit.fill),
                    trailing: Text(month+" "+record.date.day.toString()+" , "+record.date.year.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                      ),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => editRecord(widget.currentUsers, searchResults, index)))
                          .then((value) => value?_refreshHome():null);
                    },
                  );
                }

              }
              return ListTile(
                //contentPadding: EdgeInsets.all(0.0),
                title: Text("₱ "+record.amount.toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: textColor,
                  ),),
                subtitle: Text(record.category.name.toString()+"  ---"+ record.notes.toString(),
                  style: TextStyle(
                      fontSize: 15.0
                  ),),
                leading: Image.network(API+
                    categoryModel.categories[record.category.id-1].icon,
                    fit: BoxFit.fill),
                trailing: Text(month+" "+record.date.day.toString()+" , "+record.date.year.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                  ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => editRecord(widget.currentUsers, searchResults, index)))
                      .then((value) => value?_refreshHome():null);
                },
              );
            },
          ),
        )
        :FutureBuilder(
          future: _initialLoad,
          builder: (context, snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.center),);
              case ConnectionState.done:
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo){
                    if(scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
                      //_hasMore = recordData.records.length < recordData.pagination.count;
                      setState(() {
                        _hasMore = recordData.records.length < recordData.pagination.count;
                        nextUrl = recordData.pagination.nextUrl;
                      });
                    }
                  },
                  child: IncrementallyLoadingListView(
                    hasMore: () => _hasMore,
                    itemCount: () => recordData.records.length,
                    loadMore: () async {
                      await _loadMoreItems(nextUrl);
                    },
                    onLoadMore: () {
                      setState(() {
                        _loadingMore = true;
                      });
                    },
                    onLoadMoreFinished: () {
                      setState(() {
                        _loadingMore = false;
                      });
                    },
                    loadMoreOffsetFromBottom: 0,
                    itemBuilder: (context, index){
                      final record = recordData.records[index];

                      String month = "";
                      switch(recordData.records[index].date.month) {
                        case 1: {
                          month = "Jan";
                          print(month);
                        }
                        break;

                        case 2: {
                          month = "Feb";
                          print(month);
                        }
                        break;
                        case 3: {
                          month = "Mar";
                          print(month);
                        }
                        break;
                        case 4: {
                          month = "Apr";
                          print(month);
                        }
                        break;
                        case 5: {
                          month = "May";
                          print(month);
                        }
                        break;
                        case 6: {
                          month = "Jun";
                          print(month);
                        }
                        break;
                        case 7: {
                          month = "July";
                          print(month);
                        }
                        break;
                        case 8: {
                          month = "Aug";
                          print(month);
                        }
                        break;
                        case 9: {
                          month = "Sep";
                          print(month);
                        }
                        break;
                        case 10: {
                          month = "Oct";
                          print(month);
                        }
                        break;
                        case 11: {
                          month = "Nov";
                          print(month);
                        }
                        break;

                        default: {
                          month = "Dec";
                          print(month);
                        }
                        break;
                      }
                      if(recordData.records[index].recordType==1)
                      {
                        textColor = Colors.red;
                      }
                      else
                      {
                        textColor = Colors.green;
                      }
                      if((_loadingMore ?? false) && index == recordData.records.length - 1){
                        print("loadMore "+ recordData.records.length.toString());
                        if(_loadingMore)
                          {
                            return Center(child: SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.center),);
                          }
                        else{
                          return ListTile(
                            //contentPadding: EdgeInsets.all(0.0),
                            title: Text("₱ "+record.amount.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: textColor,
                              ),),
                            subtitle: Text(record.category.name.toString()+"  ---"+ record.notes.toString(),
                              style: TextStyle(
                                  fontSize: 15.0
                              ),),
                            leading: Image.network(API+
                                categoryModel.categories[record.category.id-1].icon,
                                fit: BoxFit.fill),
                            trailing: Text(month+" "+record.date.day.toString()+" , "+record.date.year.toString(),
                              style: TextStyle(
                                fontSize: 10.0,
                              ),),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => editRecord(widget.currentUsers, recordData, index)))
                                  .then((value) => value?_refreshHome():null);
                            },
                          );
                        }

                      }
                      return ListTile(
                        //contentPadding: EdgeInsets.all(0.0),
                        title: Text("₱ "+record.amount.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: textColor,
                          ),),
                        subtitle: Text(record.category.name.toString()+"  ---"+ record.notes.toString(),
                          style: TextStyle(
                              fontSize: 15.0
                          ),),
                        leading: Image.network(API+
                            categoryModel.categories[record.category.id-1].icon,
                            fit: BoxFit.fill),
                        trailing: Text(month+" "+record.date.day.toString()+" , "+record.date.year.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                          ),),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => editRecord(widget.currentUsers, recordData, index)))
                              .then((value) => value?_refreshHome():null);
                        },
                      );
                    },
                  ),
                );
              default:
                return Text("Something went wrong");
            }
          },
        )
    );
  }

}



