class CapacityLimitException implements Exception {
  String gender;
  CapacityLimitException(
    this.gender,
  );

  @override
  String toString() {
    return "Seats for $gender are full";
  }
}
