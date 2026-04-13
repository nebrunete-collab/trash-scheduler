class TrashType {
  final String id;
  final String name;
  final String color;
  
  TrashType({
    required this.id,
    required this.name,
    required this.color,
  });
}

class TrashDay {
  final DateTime date;
  final TrashType type;
  
  TrashDay({
    required this.date,
    required this.type,
  });
}

final List<TrashType> trashTypes = [
  TrashType(id: '1', name: 'Rušiuojamos (metalas, popierius, plastmasė)', color: '0xFF2196F3'),
  TrashType(id: '2', name: 'Stiklas', color: '0xFF4CAF50'),
  TrashType(id: '3', name: 'Mišrios', color: '0xFF9C27B0'),
];
