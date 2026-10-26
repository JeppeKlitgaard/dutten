// Colours: https://designguide.dtu.dk/colours
#let colors-rgb = (
  // Primary colors
  "corporate red": color.rgb(153, 0, 0),
  "white": color.rgb(255, 255, 255),
  "black": color.rgb(0, 0, 0),
  // Secondary colors
  "blue": color.rgb(47, 62, 234),
  "bright green": color.rgb(31, 208, 130),
  "navy blue": color.rgb(3, 15, 79),
  "yellow": color.rgb(246, 208, 77),
  "orange": color.rgb(252, 118, 52),
  "pink": color.rgb(247, 187, 177),
  "grey": color.rgb(218, 218, 218),
  "red": color.rgb(232, 63, 72),
  "green": color.rgb(0, 136, 53),
  "purple": color.rgb(121, 35, 142),
)

#let colors-cmyk = (
  // Primary colors
  "corporate red": color.cmyk(0%, 91%, 72%, 23%),
  "white": color.cmyk(0%, 0%, 0%, 0%),
  "black": color.cmyk(20%, 20%, 0%, 100%),
  // Secondary colors
  "blue": color.cmyk(100%, 64%, 0%, 0%),
  "bright green": color.cmyk(69%, 0%, 66%, 0%),
  "navy blue": color.cmyk(100%, 90%, 0%, 60%),
  "yellow": color.cmyk(0%, 19%, 84%, 0%),
  "orange": color.cmyk(0%, 65%, 86%, 0%),
  "pink": color.cmyk(0%, 35%, 26%, 0%),
  "grey": color.cmyk(0%, 0%, 0%, 20%),
  "red": color.cmyk(0%, 86%, 65%, 0%),
  "green": color.cmyk(89%, 5%, 100%, 17%),
  "purple": color.cmyk(67%, 96%, 0%, 0%),
)

/// Tints a colour to the specified level.
///
/// Allowed levels are those of the DTU Design Guide: 100%, 80%, 70%, 60%, 50%
///
/// -> color
#let tint(
  /// Color to tint. Should be retrieved from colors-rgb or colors-cmyk.
  /// -> color
  c,
  /// Tint level. One of: 100%, 80%, 70%, 60%, 50%
  /// -> ratio
  level,
) = {
  if type(c) != color {
    panic("tint(c, level) expects a color as first argument")
  }

  if type(level) != ratio {
    panic("tint(c, level) expects a ratio as second argument")
  }

  if level not in (100%, 80%, 70%, 60%, 50%) {
    panic("tint(c, level) expects level to be one of: 100%, 80%, 70%, 60%, 50%")
  }

  c.lighten(100% - level)
}
