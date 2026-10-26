#import "_utils.typ": _find-key-by-value
#import "colors.typ": colors-rgb, colors-cmyk
#import "deps.typ": decasify, jutils

/// Returns an image of the DTU logo in the specified color in the appropriate color space.
/// -> image
#let get-logo(
  /// Color to use for the logo. Should be retrieved from colors-rgb or colors-cmyk.
  /// If the color is RGB, the RGB logo will be returned. If CMYK, the CMYK logo will be returned.
  ///
  /// Note: Tinted colors are not supported!
  ///
  /// -> color
  c,
  /// Additional arguments to pass to the image function when loading the logo, e.g. width, height, etc.
  /// -> arguments
   ..img-args
) = {
  if type(c) != color {
    panic("logo(c) expects a color as argument")
  }

  if c.space() == cmyk {
    let color-name = _find-key-by-value(colors-cmyk, c)
    let color-type-str = "CMYK"
    let filename = decasify.titlecase-string(color-name, "en", "").replace(" ", "_") + "_" + color-type-str + ".pdf"

    return image("assets/logos/" + filename, ..img-args)

  } else if c.space() == rgb {
    return jutils.recolor-svg(path("assets/dtu_logo.svg"), c)

  } else {
    panic("logo(c) expects a color in RGB or CMYK color space")
  }
}
