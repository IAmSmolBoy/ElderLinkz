class Patient {
  final String name;
  final int room;
  final double oxygen, heartRate, gsr, humidity, temperature;

  const Patient({
    required this.name,
    required this.room,
    required this.oxygen,
    required this.heartRate,
    required this.gsr,
    required this.humidity,
    required this.temperature
  });
}