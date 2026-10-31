#let find-key-by-value(
  /// Map to search in.
  /// -> map
  m,

  /// Value to search for.
  /// -> any
  v,
) = {
  for k in m.keys() {
    if m.at(k) == v {
      return k
    }
  }

  none
}
