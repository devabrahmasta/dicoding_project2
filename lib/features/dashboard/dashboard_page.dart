import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // User Profile
              ListTile(
                leading: CircleAvatar(),
                title: Text('Welcome Dicoding'),
                subtitle: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    Text('Sleman, Yogyakarta'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.notifications, color: Colors.blue),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFEAEFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // side: BorderSide(width: 0),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 10),
              Text('Category'),


              const SizedBox(height: 10),
              Text('Category'),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 250,
                      width: 100,
                      child: Text('main poster'),
                    );
                  },
                ),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}
