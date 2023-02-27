import 'package:covidapp/countries_screen.dart';
import 'package:covidapp/model/worldstatesmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covidapp/network.dart';
class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this)..repeat();

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Network network = Network();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 243, 27),
        title: const Center(child:  Text('WORLD STATISTICS',style: TextStyle(color: Colors.black,)),
      ),),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ddd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                //SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                FutureBuilder(
                  future: network.getdata(),
                  builder:(context,AsyncSnapshot<Worldstatesmodel> snapshot) {
                    if(!snapshot.hasData){
                      return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                          ));
                    }else{
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Container(
                                            decoration:  BoxDecoration(
                                              color: const Color.fromARGB(183, 12, 161, 141),
                                              border: Border.all(style: BorderStyle.solid,width: 2, color: const Color.fromARGB(255, 18, 219, 35)),
                                              borderRadius : const BorderRadius.all(Radius.circular(30))
                          
                                            ),
                                            
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: PieChart(
                                              dataMap:  {
                                               "Total": double.parse(snapshot.data!.cases.toString()),
                                               "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                               "Deaths": double.parse(snapshot.data!.deaths.toString()),
                                        },
                                        
                                        chartValuesOptions: const ChartValuesOptions(
                                          showChartValuesInPercentage: true,
                                        ),
                                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                                        animationDuration: const Duration(milliseconds: 1200),
                                        chartType: ChartType.ring,
                                        legendOptions: const LegendOptions(
                                              legendPosition: LegendPosition.left
                                        ),
                                        
                                        colorList: const [
                                              Colors.blue,
                                              Colors.green,
                                              Colors.red,
                                        ],
                                        ),
                                            ),
                                          ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Container(
                    decoration:  BoxDecoration(
                      color: const Color.fromARGB(183, 12, 161, 141),
                      border: Border.all(style: BorderStyle.solid, color: const Color.fromARGB(255, 18, 250, 38)),
                    ),
                    child: Column(
                      children: [
                        ReuseableRow(title: "Total", value: snapshot.data!.cases.toString()),
                        const SizedBox(height: 5,),
                        ReuseableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                        const SizedBox(height: 5,),
                        ReuseableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                        const SizedBox(height: 5,),
                        ReuseableRow(title: "Active", value: snapshot.data!.active.toString()),
                        const SizedBox(height: 5,),
                        ReuseableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                        const SizedBox(height: 5,),
                        ReuseableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                        const SizedBox(height: 5,),
                        ReuseableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesScreen()));
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 20, 243, 27),
                      ),
                      child: const Center(
                        child: Text('Track Countries',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ) 
                      ],);
                    }
                }),
            ],),
            )),
    ));
  }
}
class ReuseableRow extends StatelessWidget {
  
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, color: const Color.fromARGB(255, 18, 250, 38)),
                    ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,textAlign: TextAlign.left,style: const TextStyle(color: Colors.white,fontSize: 18),),
                Text(value,textAlign: TextAlign.right,style: const TextStyle(color: Colors.white,fontSize: 18),),
              ],
            ),
            
            //const SizedBox(height: 10,),
            //const SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}