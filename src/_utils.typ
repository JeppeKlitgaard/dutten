/// Private utilities that should not be used by end user.

#let _find-key-by-value(
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

/// Resolves 4 sides into (top, bottom, left, right)
#let _resolve-4-sides(
  /// The input to be resolved
  /// Can be:
  /// - A single length: The same margin on all sides.
  /// - A dictionary: With a dictionary, the margins can be set individually. The dictionary can contain the following keys in order of precedence:
  ///   - top: The top margin.
  ///   - right: The right margin.
  ///   - bottom: The bottom margin.
  ///   - left: The left margin.
  ///   - x: The horizontal margins.
  ///   - y: The vertical margins.
  ///   - rest: The margins on all sides except those for which the dictionary explicitly sets a size.
  /// -> length | dictionary
  input,
) = {
  if type(input) == length {
    return (top: input, bottom: input, left: input, right: input)
  } else if type(input) == dictionary {
    let rest = input.at("rest", default: 0mm)
    let x = input.at("x", default: rest)
    let y = input.at("y", default: rest)

    let top = input.at("top", default: y)
    let bottom = input.at("bottom", default: y)
    let left = input.at("left", default: x)
    let right = input.at("right", default: x)

    return (top: top, bottom: bottom, left: left, right: right)
  } else {
    error("Invalid input type for _resolve-4-sides: " + repr(type(input)))
  }
}
