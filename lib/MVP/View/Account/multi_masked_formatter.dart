@override

TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue) {
  final newText = newValue.text;
  final oldText = oldValue.text;

  if (newText.length == 0 ||
      newText.length < oldText.length ||
      _masks == null ||
      _separator == null) {
    return newValue;
  }

  final pasted = (newText.length - oldText.length).abs() > 1; // 2자 이상 붙여넣기 하였는지?
  final mask = _masks.firstWhere((value) {
    final maskValue = pasted ? value.replaceAll(_separator, '') : value;  // 여러개 중에 어떤 mask 를 사용할 것인지?
    return newText.length <= maskValue.length;
  }, orElse: () => null);

  if (mask == null) {
    return oldValue;
  }

  final needReset =
  (_prevMask != mask || newText.length - oldText.length > 1); // mask 가 변경 되었거나,
  // 붙여넣기한 글자가 이전 글자보다 많아졌을 때만 다시 포맷팅 하도록.
  _prevMask = mask;

  if (needReset) {
    final text = newText.replaceAll(_separator, '');
    String resetValue = '';
    int sep = 0;

    for (int i = 0; i < text.length; i++) {
      if (mask[i + sep] == _separator) {
        resetValue += _separator;
        ++sep;
      }
      resetValue += text[i];
    }

    return TextEditingValue(
        text: resetValue,
        selection: TextSelection.collapsed(
          offset: resetValue.length,
        ));
  }

  if (newText.length < mask.length &&
      mask[newText.length - 1] == _separator) {
    final text =
        '$oldText$_separator${newText.substring(newText.length - 1)}';
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
  }

  return newValue;
}