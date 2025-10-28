class UnitsSettings<T> {
  // This class was created to pass data to SettingsMenuTile, and then to AppModal, both Widgets need the information contained here.
  UnitsSettings({
    required this.title, //Title of the Unit that will be set, e.g: Temperature, Pressure, Wind Speed.
    required this.unitOptions, // Enum Options for each of the particular ListTile (and CustomModal that will open when tapped.)
    required this.onSelected, //callback that updates the state, once the user selects the option in the CustomModal.
    required this.currentSelection, //current State of the active selection on the modal to synchronize with what the modal is showing as the option selected
    required this.unitsMap, // To facilitate mapping from the enum, to the particular String we want to display in some of the widgets.
  });

  final String title;
  final List<T> unitOptions;
  final Function(T) onSelected;
  final T currentSelection;
  final Map<T, String> unitsMap;
}
