enum PressureUnits {
  hectopascals(1),
  millimetersOfMercury(2),
  inchesOfMercury(3);

  const PressureUnits(this.selection);

  final int selection;

  static PressureUnits pressureUnitsFromInt(int number) => switch (number) {
    1 => PressureUnits.hectopascals,
    2 => PressureUnits.millimetersOfMercury,
    3 => PressureUnits.inchesOfMercury,
    _ => throw ArgumentError('Invalid pressure units $number'),
  };
}
