import 'package:covidapp/worldstats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name,image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;  

   DetailScreen({super.key,required this.name, required this.image, required this.totalCases, 
  required this.totalDeaths, required this.todayRecovered, required this.active,required this.critical, 
  required this.totalRecovered, required this.test
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 243, 27),
        title: Text(widget.name,style: TextStyle(color: Colors.black,)),
        centerTitle: true,
      ),
      body: Container(
         decoration:  BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/ddd.jpg'),
            opacity: 0.8,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8),
                BlendMode.darken
               ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Container(
                      decoration:  BoxDecoration(
                        color: const Color.fromARGB(183, 12, 161, 141),
                        border: Border.all(style: BorderStyle.solid, color: const Color.fromARGB(255, 18, 250, 38)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .06,),
                          ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                          ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                          ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered .toString()),
                          ReuseableRow(title: 'Actice', value: widget.active.toString()),
                          ReuseableRow(title: 'Critical', value: widget.critical .toString()),
                          ReuseableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                          ReuseableRow(title: 'Tests', value: widget.test.toString()),

                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}