import 'package:airbnbmc/models/constants.dart';
import 'package:flutter/material.dart';

class CalenderUi extends StatefulWidget {
  final int? monthIndex;
  final List<DateTime>? bookedDates;
  final Function? selectDate;
  final Function? getSelectedDate;

  const CalenderUi({
    super.key,
    this.monthIndex,
    this.bookedDates,
    this.selectDate,
    this.getSelectedDate,
  });

  @override
  State<CalenderUi> createState() => _CalenderUiState();
}

class _CalenderUiState extends State<CalenderUi> {
  List<DateTime> _selectedDates = [];
  List<MonthTileWidget> _monthTiles = [];
  int? _currentMonth;
  int? _currentYear;

  /// Normalize a date to its year, month, and day only (ignoring time).
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Initialize the month tiles with placeholders and dates.
  void _setUpMonthTiles() {
    _monthTiles = [];
    int daysInMonth = Constants.daysInMonth![_currentMonth]!;
    DateTime firstDayOfMonth = DateTime(_currentYear!, _currentMonth!, 1);
    int firstWeekDay = firstDayOfMonth.weekday;

    // Add empty tiles for days before the first weekday.
    if (firstWeekDay != 7) {
      for (int i = 0; i < firstWeekDay; i++) {
        _monthTiles.add(MonthTileWidget(dateTime: null));
      }
    }

    // Add tiles for each day of the month.
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime dateTime = DateTime(_currentYear!, _currentMonth!, i);
      _monthTiles.add(MonthTileWidget(dateTime: dateTime));
    }
  }

  /// Handle date selection or deselection.
  void _selectDate(DateTime dateTime) {
    if (_selectedDates.contains(dateTime)) {
      _selectedDates.remove(dateTime);
    } else {
      _selectedDates.add(dateTime);
    }

    widget.selectDate!(dateTime);
    setState(() {});
  }

  /// Check if a date is booked.
  bool _isBookedDate(DateTime? date) {
    if (date == null || widget.bookedDates == null) return false;
    return widget.bookedDates!
        .map(_normalizeDate)
        .contains(_normalizeDate(date));
  }

  /// Build the calendar tile for a specific date.
  Widget _buildCalendarTile(MonthTileWidget monthTile) {
    if (monthTile.dateTime == null) {
      // Empty tile (before the first day of the month).
      return const MaterialButton(
        onPressed: null,
        child: Text(""),
      );
    }

    final DateTime date = monthTile.dateTime!;
    final bool isBooked = _isBookedDate(date);

    if (isBooked) {
      // Booked date (red background, disabled).
      return MaterialButton(
        onPressed: null,
        color: Colors.red,
        child: monthTile,
      );
    }

    // Selectable date (blue if selected, white otherwise).
    return MaterialButton(
      onPressed: () {
        _selectDate(date);
      },
      color: _selectedDates.contains(date) ? Colors.blue : Colors.white,
      child: monthTile,
    );
  }

  List<DateTime> _generateDatesInRange(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    DateTime currentDate = start;

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dates;
  }

  @override
  void initState() {
    super.initState();

    // Calculate the current month and year based on the month index.
    _currentMonth = (DateTime.now().month + widget.monthIndex!) % 12;
    if (_currentMonth == 0) {
      _currentMonth = 12;
    }
    _currentYear = DateTime.now().year;
    if (_currentMonth! < DateTime.now().month) {
      _currentYear = _currentYear! + 1;
    }

    // Initialize selected dates and month tiles.
    _selectedDates.sort();
    _selectedDates.addAll(widget.getSelectedDate!());
    _setUpMonthTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text("${Constants.monthDict![_currentMonth]} - $_currentYear"),
        ),
        GridView.builder(
          itemCount: _monthTiles.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return _buildCalendarTile(_monthTiles[index]);
          },
        ),
      ],
    );
  }
}

class MonthTileWidget extends StatelessWidget {
  final DateTime? dateTime;

  const MonthTileWidget({
    super.key,
    this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime == null ? '' : dateTime!.day.toString(),
      style: const TextStyle(
        fontSize: 8,
      ),
    );
  }
}
