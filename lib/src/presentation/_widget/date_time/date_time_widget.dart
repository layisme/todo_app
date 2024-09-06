import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum SelectorType { day, month, year }

enum PickerMode {
  date,
  monthYear,
  monthDay,
}

class DateTimeWidget extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final PickerMode? mode;
  final void Function(DateTime) onSelectedItemChanged;

  const DateTimeWidget(
      {super.key,
      this.selectedDate,
      this.minDate,
      this.maxDate,
      required this.onSelectedItemChanged,
      this.mode});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late DateTime _minDate;
  late DateTime _maxDate;
  late DateTime _selectedDate;
  late int _selectedDayIndex;
  late int _selectedMonthIndex;
  late int _selectedYearIndex;
  late int selectedYear = widget.selectedDate?.year ?? DateTime.now().year;
  late int selectedMonth = widget.selectedDate?.month ?? DateTime.now().month;
  late int selectedDay = widget.selectedDate?.day ?? DateTime.now().day;
  late final FixedExtentScrollController _dayScrollController;
  late final FixedExtentScrollController _monthScrollController;
  late final FixedExtentScrollController _yearScrollController;

  List<DateTime> getMonths(int year) {
    List<DateTime> months = [];
    for (int month = 1; month <= 12; month++) {
      months.add(DateTime(year, month, 1));
    }
    return months;
  }

  List<DateTime> getDaysInMonth(int year, int month) {
    List<DateTime> days = [];
    int lastDay =
        DateTime(year, month + 1, 0).day; // Get the last day of the month
    for (int i = 1; i <= lastDay; i++) {
      days.add(DateTime(year, month, i));
    }
    return days;
  }

  void _initDates() {
    final currentDate = DateTime.now();
    _minDate = widget.minDate ?? DateTime(currentDate.year - 100);
    _maxDate = widget.maxDate ?? DateTime(currentDate.year + 100);
    if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate!;
    } else if (!currentDate.isBefore(_minDate) &&
        !currentDate.isAfter(_maxDate)) {
      _selectedDate = currentDate;
    } else {
      _selectedDate = _minDate;
    }
    selectedYear = widget.selectedDate?.year ?? DateTime.now().year;

    _selectedYearIndex =
        getYears().map((e) => e.year).toList().indexOf(selectedYear);
    _selectedMonthIndex = getMonths(selectedYear)
        .map((e) => e.month)
        .toList()
        .indexOf(selectedMonth);
    _selectedDayIndex = getDaysInMonth(selectedYear, selectedMonth)
        .map((e) => e.day)
        .toList()
        .indexOf(selectedDay);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollList(_dayScrollController, _selectedDayIndex);
      _scrollList(_monthScrollController, _selectedMonthIndex);
      _scrollList(_yearScrollController, _selectedYearIndex);
    });
  }

  void _scrollList(FixedExtentScrollController controller, int index) {
    controller.animateToItem(
      index,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _dayScrollController.dispose();
    _monthScrollController.dispose();
    _yearScrollController.dispose();
    super.dispose();
  }

  bool _isDisabled(int index, SelectorType type) {
    DateTime temp;
    switch (type) {
      case SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
        );
        break;
      case SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
    }
    return temp.isAfter(_maxDate) || temp.isBefore(_minDate);
  }

  Widget _selector(
      {required List<dynamic> values,
      required int selectedValueIndex,
      required bool Function(int) isDisabled,
      required void Function(int) onSelectedItemChanged,
      required FixedExtentScrollController scrollController,
      BorderRadius? radius,
      EdgeInsets? margin}) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: CupertinoPicker.builder(
        childCount: values.length,
        squeeze: 1.45,
        itemExtent: 40,
        scrollController: scrollController,
        onSelectedItemChanged: onSelectedItemChanged,
        selectionOverlay: Container(
          width: double.infinity,
          margin: margin,
          height: 50,
          decoration: BoxDecoration(
              // color: StyleColor.disableColor.withOpacity(0.5),
              borderRadius: radius ?? BorderRadius.zero),
        ),
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
          child: Text(
            '${values[index]}',
            style: GoogleFonts.lato(),
          ),
        ),
      ),
    );
  }

  Widget _daySelector() {
    return _selector(
      values: List.generate(getDaysInMonth(selectedYear, selectedMonth).length,
          (index) => index + 1),
      selectedValueIndex: _selectedDayIndex,
      scrollController: _dayScrollController,
      isDisabled: (index) => _isDisabled(index, SelectorType.day),
      radius: const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      margin: const EdgeInsets.only(right: 10),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        SelectorType.day,
      ),
    );
  }

  void _onSelectedItemChanged(int index, SelectorType type) {
    DateTime temp;
    switch (type) {
      case SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
        );
        break;
      case SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
    }

    // return if selected date is not the min - max date range
    // scroll selector back to the valid point
    if (temp.isBefore(_minDate) || temp.isAfter(_maxDate)) {
      switch (type) {
        case SelectorType.day:
          _dayScrollController.jumpToItem(_selectedDayIndex);
          break;
        case SelectorType.month:
          _monthScrollController.jumpToItem(_selectedMonthIndex);
          break;
        case SelectorType.year:
          _yearScrollController.jumpToItem(_selectedYearIndex);
          break;
      }
      return;
    }
    // update selected date
    _selectedDate = temp;
    // adjust other selectors when one selctor is changed
    // if()
    switch (type) {
      case SelectorType.day:
        selectedDay =
            getDaysInMonth(selectedYear, selectedMonth).elementAt(index).day;
        break;
      case SelectorType.month:
        selectedMonth = getMonths(selectedYear).elementAt(index).month;
        break;
      case SelectorType.year:
        selectedYear = getYears().elementAt(index).year;
        break;
    }
    _selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    setState(() {});
    widget.onSelectedItemChanged(_selectedDate);
  }

  Widget _monthSelector() {
    return _selector(
      values: getMonths(2024).map((e) => DateFormat.MMMM().format(e)).toList(),
      selectedValueIndex: _selectedMonthIndex,
      scrollController: _monthScrollController,
      isDisabled: (index) => _isDisabled(index, SelectorType.month),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        SelectorType.month,
      ),
    );
  }

  Widget _yearSelector() {
    return _selector(
      values: getYears().map((e) => e.year).toList(),
      selectedValueIndex: _selectedYearIndex,
      scrollController: _yearScrollController,
      isDisabled: (index) => _isDisabled(index, SelectorType.year),
      margin: const EdgeInsets.only(left: 10),
      radius: const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        SelectorType.year,
      ),
    );
  }

  List<DateTime> getYears() {
    List<DateTime> years = List.generate(
      _maxDate.year - _minDate.year + 1,
      (index) => DateTime(_minDate.year + index),
    );
    return years;
  }

  @override
  void initState() {
    _dayScrollController = FixedExtentScrollController();
    _monthScrollController = FixedExtentScrollController();
    _yearScrollController = FixedExtentScrollController();
    _initDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: getItems(),
    );
  }

  getItems() {
    switch (widget.mode) {
      case PickerMode.date:
        return [
          SizedBox(
            width: 80,
            child: _yearSelector(),
          ),
          SizedBox(
            width: 140,
            child: _monthSelector(),
          ),
          SizedBox(
            width: 80,
            child: _daySelector(),
          )
        ];
      case PickerMode.monthYear:
        return [
          SizedBox(
            width: 80,
            child: _yearSelector(),
          ),
          SizedBox(
            width: 140,
            child: _monthSelector(),
          ),
        ];
      case PickerMode.monthDay:
        return [
          SizedBox(
            width: 140,
            child: _monthSelector(),
          ),
          SizedBox(
            width: 80,
            child: _daySelector(),
          ),
        ];
      default:
    }
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
