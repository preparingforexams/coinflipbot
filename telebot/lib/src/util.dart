U? optional<T, U>(T? value, U Function(T) convert) {
  if (value == null) {
    return null;
  } else {
    return convert(value);
  }
}
