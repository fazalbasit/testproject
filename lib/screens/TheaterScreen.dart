import 'package:flutter/material.dart';
import 'package:testproject/components/CustomBlueButton.dart';
import 'package:intl/intl.dart';
import 'package:testproject/components/theaterCard.dart';
import 'package:testproject/screens/SeatSelectionScreen.dart';
import 'package:testproject/utils/globals.dart';

class TheaterScreen extends StatefulWidget {
  TheaterScreen({Key? key, required this.movieId}) : super(key: key);

  final String movieId;

  @override
  _TheaterScreenState createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen> {
  late List<DateTime> remainingDates;
  int selectedIndex = -1;

  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    remainingDates = _getRemainingDatesInMonth();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(children: [
          Text(
            "The King’s Man",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            "In theaters december 22, 2021",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff61C3F2)),
          ),
        ]),
      ),
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.grey.shade100,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              Text(
                                '  Date',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                              width: double.maxFinite,
                              height: 45, // Adjust the height as needed
                              color: Colors.grey.shade100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: remainingDates.map((date) {
                                  String formattedDate =
                                      DateFormat('d EEEE').format(date);
                                  bool isSelected = selectedDate != null &&
                                      date == selectedDate;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = isSelected ? null : date;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: isSelected
                                            ? Colors.blue
                                            : Color(0xff6A6A6A)
                                                .withOpacity(0.1),
                                      ),
                                      child: Text(
                                        formattedDate,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                          const SizedBox(
                            height: 60,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length,
                              itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => setState(() {
                                        selectedIndex = index;
                                      }),
                                  child: theaterCard(
                                    selectedIndex: selectedIndex,
                                    currentIndex: index,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomBlueButton(() async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeatSelectionScreen()));
                        }, "Get Tickets "))
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  List<DateTime> _getRemainingDatesInMonth() {
    List<DateTime> dates = [];
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    for (DateTime date = now;
        date.isBefore(lastDayOfMonth);
        date = date.add(Duration(days: 1))) {
      dates.add(date);
    }
    return dates;
  }
}
