import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iskcon/Screens/dashboard/tagSearchResult_page.dart';
import 'package:iskcon/Utils/custColors.dart';

import '../../controller/filter_controller.dart';

class TagSearch extends StatefulWidget {
  @override
  _TagSearchState createState() => new _TagSearchState();
}

class _TagSearchState extends State<TagSearch> {
  final filterController = Get.put(FilterController());
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Tags'),
          backgroundColor: primaryColor,
          elevation: 0.0,
        ),
        body: GetBuilder<FilterController>(
          builder: (filter) => Column(
            children: <Widget>[
              new Container(
                color: primaryColor,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        autofocus: true,
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                          onSearchTextChanged('');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              new Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? new ListView.builder(
                        itemCount: _searchResult.length,
                        itemBuilder: (context, i) {
                          return new Card(
                            child: new ListTile(
                              title: new Text(_searchResult[i]),
                              onTap: () {
                                Get.to(() => TagSearchResultPage(),
                                    arguments: _searchResult[i]);
                              },
                            ),
                            margin: const EdgeInsets.all(0.0),
                          );
                        },
                      )
                    : new ListView.separated(
                        itemCount: filter.tagList.length,
                        itemBuilder: (context, index) {
                          return new Card(
                            child: new ListTile(
                              title: new Text(filter.tagList[index]),
                              onTap: () {
                                Get.to(() => TagSearchResultPage(),
                                    arguments: filter.tagList[index]);
                              },
                            ),
                            margin: const EdgeInsets.all(0.0),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 0.5,
                          );
                        },
                      ),
              ),
            ],
          ),
        ));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    filterController.tagList.forEach((list) {
      if (list.contains(text)) _searchResult.add(list);
    });

    setState(() {});
  }
}

List<String> _searchResult = [];

List<String> _userDetails = [];
