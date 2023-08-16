class ReusableFunction {
  String? validateString(String value) {
    if (value.isEmpty) {
      return "Need To Fill This Field";
    }
    return null;
  }

  String? validateNumber(String data) {
    if (data.isEmpty) {
      return "Need To Fill This Field";
    }
    if (int.tryParse(data) == null) {
      return "Please enter a valid integer amount";
    }
    return null;
  }
}
