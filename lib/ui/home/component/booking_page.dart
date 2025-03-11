import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _currentMonth = DateTime(2025, 3);
  DateTime _selectedCheckInDate = DateTime(2025, 3, 13);
  DateTime _selectedCheckOutDate = DateTime(2025, 3, 27);
  int _numberOfGuests = 1;
  TextEditingController _noteController = TextEditingController();

  List<int> _selectedDates = [2, 13, 27]; // Days with circles
  List<int> _highlightedDates = [3, 4, 5, 6, 7, 10, 11]; // Days with red text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text(
          'Book Now SkyVilla',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              _buildCalendar(),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Check in',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(_selectedCheckInDate),
                                style: TextStyle(fontSize: 14),
                              ),
                              Icon(Icons.calendar_today, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Check out',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(_selectedCheckOutDate),
                                style: TextStyle(fontSize: 14),
                              ),
                              Icon(Icons.calendar_today, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Number of Guest',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  const Text(
                    'Allowed Max 30 Guest',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.grey),
                          onPressed: _numberOfGuests > 1
                              ? () {
                            setState(() {
                              _numberOfGuests--;
                            });
                          }
                              : null,
                        ),
                        Text(
                          _numberOfGuests.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.blue),
                          onPressed: _numberOfGuests < 30
                              ? () {
                            setState(() {
                              _numberOfGuests++;
                            });
                          }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Note to Owner (optional)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                        hintText: 'Notes',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _weekDayHeader('S'),
              _weekDayHeader('M'),
              _weekDayHeader('T'),
              _weekDayHeader('W'),
              _weekDayHeader('T'),
              _weekDayHeader('F'),
              _weekDayHeader('S'),
            ],
          ),
          SizedBox(height: 8),
          _buildCalendarDays(),
        ],
      ),
    );
  }

  Widget _weekDayHeader(String day) {
    return SizedBox(
      width: 30,
      child: Text(
        day,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCalendarDays() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    // Get the weekday of the first day (0 = Sunday, 6 = Saturday)
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;

    List<Widget> dayWidgets = [];

    // Add empty spaces for days before the first day of month
    for (int i = 0; i < firstWeekdayOfMonth; i++) {
      dayWidgets.add(SizedBox(width: 30, height: 30));
    }

    // Add day cells for the month
    for (int day = 1; day <= daysInMonth; day++) {
      bool isSelected = _selectedDates.contains(day);
      bool isHighlighted = _highlightedDates.contains(day);

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            // Handle day selection
          },
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: isSelected
                ? BoxDecoration(
              shape: BoxShape.circle,
              color: day == 13 ? Colors.blue : Colors.transparent,
              border: Border.all(
                color: day == 13 ? Colors.blue : Colors.red,
                width: 1,
              ),
            )
                : null,
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isSelected
                    ? (day == 13 ? Colors.white : Colors.red)
                    : (isHighlighted ? Colors.red : Colors.black),
                fontWeight: day == 13 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    }

    // Create rows with 7 days each
    List<Widget> calendarRows = [];
    for (int i = 0; i < dayWidgets.length; i += 7) {
      final endIndex = i + 7 > dayWidgets.length ? dayWidgets.length : i + 7;
      calendarRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayWidgets.sublist(i, endIndex),
        ),
      );
    }

    return Column(
      children: calendarRows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: row,
        );
      }).toList(),
    );
  }
}