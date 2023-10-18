import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/homeScreen/widgets/task_item_widget.dart';

import '../../Model/Task_model.dart';
import '../../core/NetworkLayer/FireStore_Utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment(0, 2.8),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              height: 170,
              color: theme.primaryColor,
              child: Text(
                "To Do List",
                style: theme.textTheme.titleLarge,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(days: 365),
                ),
                onDateSelected: (date) {
                  selectedDate = date;
                },
                leftMargin: 20,
                monthColor: Colors.black87,
                dayColor: Colors.black87,
                activeDayColor: theme.primaryColor,
                activeBackgroundDayColor: Colors.white,
                dotsColor: Colors.white,
                selectableDayPredicate: (date) => date.day != 23,
                locale: 'en_ISO',
              ),
            )
          ],
        ),
        const SizedBox(height: 50),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirestoreUtils.getRealTimeDataFromFirestore(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.error.toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      onPressed: () {
                        // call api again
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                );
              }


              var tasksList = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];


              return ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => TaskItemWidget(taskModel: tasksList[index]),
                itemCount: tasksList.length,
              );
            },
          ),
        ),

      ],
    );
  }
}