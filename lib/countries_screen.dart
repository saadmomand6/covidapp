import 'package:covidapp/detailscreen.dart';
import 'package:covidapp/network.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  Network network = Network();
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 243, 27),
        title: const Center(child: Text('COUNTRIES',style: TextStyle(color: Colors.black,)),
      ),),
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
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchcontroller,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    
                    hintText: "Search Country",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide( color: Color.fromARGB(255, 20, 243, 27)),
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: network.getcountriesdata(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index){
                          return Shimmer.fromColors(
                             
                            baseColor: Colors.grey.shade700, 
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                        children: [
                          ListTile(
                            title: Container(height: 10,width: 89,color: Colors.white,),
                            subtitle: Container(height: 10,width: 89,color: Colors.white,),
                            leading: Container(height: 50,width: 50,color: Colors.white,),
                          )

                        ],
                      ),
                            );
                        });
                      
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];

                          if(searchcontroller.text.isEmpty){
                           return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> DetailScreen(
                                  name: snapshot.data![index]['country'], 
                                  image: snapshot.data![index]['countryInfo']['flag'], 
                                  totalCases: snapshot.data![index]['cases'], 
                                  totalDeaths: snapshot.data![index]['deaths'], 
                                  todayRecovered: snapshot.data![index]['recovered'], 
                                  active: snapshot.data![index]['active'], 
                                  critical: snapshot.data![index]['critical'], 
                                  totalRecovered: snapshot.data![index]['todayRecovered'], 
                                  test: snapshot.data![index]['tests'])));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]["country"], style: const TextStyle(color: Colors.white),),
                              subtitle: Text(snapshot.data![index]['cases'].toString(), style: const TextStyle(color: Colors.white),),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                            ),
                          )

                        ],
                      );
                          }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                             return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> DetailScreen(
                                  name: snapshot.data![index]['country'], 
                                  image: snapshot.data![index]['countryInfo']['flag'], 
                                  totalCases: snapshot.data![index]['cases'], 
                                  totalDeaths: snapshot.data![index]['deaths'], 
                                  todayRecovered: snapshot.data![index]['recovered'], 
                                  active: snapshot.data![index]['active'], 
                                  critical: snapshot.data![index]['critical'], 
                                  totalRecovered: snapshot.data![index]['todayRecovered'], 
                                  test: snapshot.data![index]['tests'])));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]["country"], style: const TextStyle(color: Colors.white),),
                              subtitle: Text(snapshot.data![index]['cases'].toString(), style: const TextStyle(color: Colors.white),),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                            ),
                          )

                        ],
                      );
                          }else{
                            return Container();
                          }
                     
                    });
                    }
                    
                  }),)
            ],
          )),
      ),
    );
  }
}