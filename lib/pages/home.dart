import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rs_availibility/pages/detail.dart';

class Home extends StatefulWidget {
  // const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 List _get = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Future _getData() async {
  try {
      final response = await http.get(Uri.parse(
          "https://rs-bed-availibility.vercel.app/api/bed-detail/3404015"));
      // return jsonDecode(response.body);

      // untuk cek data
      if (response.statusCode == 200) {
        //print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _get = data['availibility'];
        
        });
      }
    } catch (e) {
      print(e);
    }
  }

 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.red,Colors.white])
        ),
        width: 10,
        margin: const EdgeInsets.all(8),
      ),
      title: const Text(
        'RS Dr. Sardjito',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      // title: const Center(
      //     child: Text('RS Dr. Sardjito', style: TextStyle(color: Colors.black)
      //     )
      // ),
      // backgroundColor: Colors.white,
    ),
    body: ListView.builder(
      itemCount: _get.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            color: Colors.grey[200],
            height: 100,
            width: 100,
            child: Image.asset(
                    'rs.jpg',
                    width: 100,
                    fit: BoxFit.cover,
                  ),
          ),
          title: Text(
            '${_get[index]['room_name']}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'Kuota : ${_get[index]['quota']} - Kosong : ${_get[index]['available']}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => DetailPage(
                    room_name: _get[index]['room_name'],
                    available: _get[index]['available'],
                    quota: _get[index]['quota'],
                    queue: _get[index]['queue'],
                    updated_at: _get[index]['updated_at'],
                  ),
                ),
              );
          },
        );
      },
    ),
  );
}
}