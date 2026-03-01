class DetectionService {
  static const List<String> mockNearbyFriends = [
    'Palak',
    'Hemadri',
    'Vivek',
    'Kanishk',
  ];

  static const String detectionLabel =
      'Bluetooth + Audio AI Detection (Simulated)';

  bool isNearbyDetected = false;

  void startDetection() {
    isNearbyDetected = true;
  }

  void stopDetection() {
    isNearbyDetected = false;
  }

  List<String> getNearbyFriends() {
    if (!isNearbyDetected) return [];
    return mockNearbyFriends;
  }
}
