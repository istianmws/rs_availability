import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final room_name,quota,available,queue,updated_at;

  DetailPage({
    this.room_name="",
    this.quota,
    this.updated_at,
    this.queue,
    this.available});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      appBar: AppBar( backgroundColor: Colors.white,
        title: const Center(child:Text("Detail Kamar", style: TextStyle(color: Colors.black),),),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          //Image.asset('rs.jpg',width: 200,),
          Container(
            margin: EdgeInsets.all(20),
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: Colors.grey,
              image: const DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  'assets/gbr.jpg'
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$room_name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'diperbarui pada : $updated_at',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Kamar Tersedia : $available' ' kamar'),
                Divider(),
                Text('Total Kamar : $quota' ' kamar'),
                Text('Antrian : $queue' ' kamar'),
              ],
            ),
          )
        ],
      ),
      //Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}