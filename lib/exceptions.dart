class CapacityLimitException implements Exception {
  String gender;
  CapacityLimitException(
    this.gender,
  );

  @override
  String toString() {
    return "No more seats for $gender";
  }
}
