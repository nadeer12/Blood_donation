import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  // Reference to the 'donor' collection in Firestore
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');
  void deleteDonor(docId){
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.blue,
        // leading: IconButton(onPressed: (){
        //   Scaffold.of(context).openDrawer();
        // },icon: Icon(Icons.menu),),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/add');
          }, icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        // Stream to listen for changes in the 'donor' collection
        stream: donor.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // Checking the connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Checking if data is available
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No donors available.'),
            );
          }

          // Displaying the list of donors
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot donorSnap = snapshot.data!.docs[index];
              // final donorName = donorSnap['name'].toString();

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20),
                    color:Colors.blue[50],
                    boxShadow: [BoxShadow(
                      color: const Color.fromARGB(127, 255, 255, 255),
                      blurRadius: 10,
                      spreadRadius: 15
                    )] 
                  ),
              
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30,
                            child: Text(
                              donorSnap['group'],
                              style:TextStyle(fontSize: 18,color: Colors.white),
                            
                            ),
                            
                            
                            )
                         
                        ),
                      ),
              
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            donorSnap['name'],
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey
                            ) ,
                          ),
                          Text(
                            donorSnap['phone'].toString(),
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey
                            ),
                          )
                          
                          
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/update',
                              arguments:{
                                'name':donorSnap['name'],
                                'phone':donorSnap['phone'].toString(),
                                'group':donorSnap['group'],
                                'id':donorSnap.id,
                              } );
                            },
                            icon: Icon(Icons.edit),
                            iconSize: 30,
                            color: Colors.green,
                          ),
                          IconButton(onPressed: (){

                            deleteDonor(donorSnap.id);
                          },
                           icon: Icon(Icons.delete),
                           iconSize: 30,
                           color: Colors.red,
                          )
                        ],
                      )
              
                    ],
                  ),
                ),
              );
                // Add more details or customize the ListTile as needed
              
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/voice');
        },
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.keyboard_voice, size: 26),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: Drawer(
        
        child: ListView(
          children: [
          
            ListTile(
              
              title:Text('item1'),
              onTap: (){},

            ),
            ListTile(
              title: Text("Item2"),
              onTap: (){},
            ),

          ],
          
        ),
        
      ),
    );
  }
}
