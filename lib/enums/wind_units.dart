enum WindUnits {
  metersPerSecond(2),
  kilometersPerHour(1),
  feetPerSecond(4),
  milesPerHour(3),
  nauticalMilesPerHour(5);

  const WindUnits(this.selection);

  final int selection;

  static WindUnits windUnitsFromInt(int number) => switch (number) {
    1 => WindUnits.kilometersPerHour,
    2 => WindUnits.metersPerSecond,
    3 => WindUnits.milesPerHour,
    4 => WindUnits.feetPerSecond,
    5 => WindUnits.nauticalMilesPerHour,
    _ => throw ArgumentError('Invalid wind speed units $number'),
  };
}
