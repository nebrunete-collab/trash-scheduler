import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/trash_schedule.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  final Map<DateTime, List<TrashDay>> _events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Šiukšlių Vėžimas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2027, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildEventsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTrashDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventsList() {
    final events = _events[_selectedDay] ?? [];
    
    if (events.isEmpty) {
      return Center(
        child: Text('Šioje dienoje nėra šiukšlių rinkimo'),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(events[index].type.name),
            trailing: Icon(Icons.notifications_active),
          ),
        );
      },
    );
  }

  void _showAddTrashDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pridėti šiukšlių rinkimą'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...trashTypes.map((type) {
                return ListTile(
                  title: Text(type.name),
                  onTap: () {
                    setState(() {
                      _events.putIfAbsent(_selectedDay, () => []);
                      _events[_selectedDay]!.add(
                        TrashDay(date: _selectedDay, type: type),
                      );
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}