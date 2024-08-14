import 'package:flutter/material.dart';

void main() {
  runApp(ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScheduleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDateIndex = 1; // Index of the currently selected date (default is 5th April)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'April',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DateCard(day: "4", weekday: "Sat", isSelected: _selectedDateIndex == 0, onTap: () {
                  setState(() {
                    _selectedDateIndex = 0;
                  });
                }),
                DateCard(day: "5", weekday: "Sun", isSelected: _selectedDateIndex == 1, onTap: () {
                  setState(() {
                    _selectedDateIndex = 1;
                  });
                }),
                DateCard(day: "6", weekday: "Mon", isSelected: _selectedDateIndex == 2, onTap: () {
                  setState(() {
                    _selectedDateIndex = 2;
                  });
                }),
                DateCard(day: "7", weekday: "Tue", isSelected: _selectedDateIndex == 3, onTap: () {
                  setState(() {
                    _selectedDateIndex = 3;
                  });
                }),
                DateCard(day: "8", weekday: "Wed", isSelected: _selectedDateIndex == 4, onTap: () {
                  setState(() {
                    _selectedDateIndex = 4;
                  });
                }),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  TimeSlot(
                    color: Colors.orange,
                    subject: "Math",
                    time: "9:00 AM - 10:00 AM",
                    teachers: "Saber & Oro",
                  ),
                  TimeSlot(
                    color: Colors.green,
                    subject: "English",
                    time: "11:00 AM - 12:00 PM",
                    teachers: "Saber & Mike",
                  ),
                  TimeSlot(
                    color: Colors.purple,
                    subject: "History",
                    time: "1:00 PM - 2:00 PM",
                    teachers: "Saber & Fahim",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  final String day;
  final String weekday;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCard({
    required this.day,
    required this.weekday,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.teal.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
              ),
          ],
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              weekday,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSlot extends StatelessWidget {
  final Color color;
  final String subject;
  final String time;
  final String teachers;

  const TimeSlot({
    required this.color,
    required this.subject,
    required this.time,
    required this.teachers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(Icons.person, color: color),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                teachers,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
