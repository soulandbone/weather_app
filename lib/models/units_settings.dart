class UnitsSettings<T> {
  UnitsSettings({
    required this.title,
    required this.unitOptions,
    required this.onSelected,
    required this.currentSelection,
    required this.unitsMap,
  });

  final String title;
  final List<T> unitOptions;
  final Function(T) onSelected;
  final T currentSelection;
  final Map<T, String> unitsMap;
}
