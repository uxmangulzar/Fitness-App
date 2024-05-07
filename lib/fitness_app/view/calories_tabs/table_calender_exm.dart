import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class TabaleCalendarExm extends StatefulWidget {
  @override
  _TabaleCalendarExmState createState() => _TabaleCalendarExmState();
}

class _TabaleCalendarExmState extends State<TabaleCalendarExm> {
  DateTime currentDate = DateTime.now();
  DateTime? _selectedDate=DateTime.now();
  bool showTooltip = false;
  TimeOfDay? pickedTime;
  TimeOfDay? updatePikedTime;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  Map<String, List>   mySelectedEvents = {
    "2023-09-05": [
      {"eventDescp": "11", "eventTitle": "111", "time": "5:00 AM"},
      {"eventDescp": "22", "eventTitle": "22", "time": "6:00 AM"}
    ],
    "2022-09-30": [
      {"eventDescp": "22", "eventTitle": "22", "time": "8:00 AM"}
    ],
    "2022-09-20": [
      {"eventTitle": "ss", "eventDescp": "ss", "time": "10:00 PM"}
    ]
  };

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Day View'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Navigate to the previous day
                      currentDate = currentDate.subtract(const Duration(days: 1));
                      formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
                      setState(() {});
                    },
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Navigate to the next day
                      currentDate = currentDate.add(const Duration(days: 1));
                      formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
                      setState(() {});

                      // Navigate to the DateScreen with the next date

                    },
                  ),
                ],
              ),
            ),

            TableCalendar(
              // holidayPredicate: true,
              headerVisible: true,
              // rangeSelectionMode: RangeSelectionMode.toggledOn,
              headerStyle: HeaderStyle(
                headerMargin: const EdgeInsets.only(bottom: 10),
                titleTextStyle: const TextStyle(color: Colors.white),
                decoration: const BoxDecoration(color: Colors.orange),
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: const TextStyle(color: Colors.black),
                formatButtonShowsNext: false,
              ),
              calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.orange),
                  selectedDecoration: BoxDecoration(color: Colors.black),
                  markerDecoration: BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle)),

              firstDay: DateTime(2022),
              lastDay: DateTime(2025),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,

              // calendarStyle: CalendarStyle(),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDate, selectedDay)) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              eventLoader: _listOfDayEvents,
            ),
            Column(
                children: [
              SingleChildScrollView(
                child:  Column(
                  children:
                  [
                    // ..._listOfDayEvents(_selectedDate!).map(
                    ..._listOfDayEvents(_selectedDate!).map(
                          (myEvents) => Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.done,
                              color: Colors.purple,
                            ),
                            title: Padding(
                              padding:
                              const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '${myEvents['eventTitle']}',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Text('${myEvents['eventDescp']}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                )),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(myEvents['time'].toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
            const Text("data")

          ],
        ),
      ),
    );
  }
  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }
}

