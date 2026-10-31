#let as-bool(s) = {
  if type(s) == str {
    if s == "true" {
      return true
    } else if s == "false" {
      return false
    } else {
      panic("Invalid string for as-bool: " + repr(s))
    }
  } else if type(s) == bool {
    return s
  } else {
    panic("Invalid type for as-bool: " + repr(type(s)))
  }
}
