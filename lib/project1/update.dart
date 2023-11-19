import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {

  final  bloodGroups = ['A+ve','A-ve','B+ve','B-ve','O+ve','O-ve','AB+ve','AB-ve',];
  String? selectedGroup;
  final CollectionReference donor = 
  FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  void UpdateDonor(docId){
    final data ={
      'name':donorName.text,
      'phone':donorPhone.text,
      'group':selectedGroup
    };
    donor.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text =args['phone'];
    selectedGroup=args['group'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/');
          }, icon: Icon(Icons.home))
        ],
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Name")
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Phone Number"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                value: selectedGroup,
                
                decoration: InputDecoration(
                  label: Text("Select Blood Group")
                ),
                items: bloodGroups.map((e) => DropdownMenuItem(
                child: Text(e),
                value: e,
                )).toList(),
                 onChanged: (val){
                  selectedGroup = val as String?;
                }),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: (){
                  UpdateDonor(docId);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                
                ),
                child: Text(
                  "Update",style: TextStyle(
                    fontSize: 20
                  ) ,
                )
              ),
              
              
            ),
            TextButton(
              
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 20
                  )
                ),
                foregroundColor: MaterialStateProperty.all(Colors.blueGrey)), 
              onPressed: (){
                Navigator.pushNamed(context, '/add');
              },
              child: Text("click to create new donor"),
            ),
          ],
        ),
      ),
    );
  }
}