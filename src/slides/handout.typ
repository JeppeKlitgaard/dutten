#import "../_utils/lib.typ": as-bool

// If `prioritise-sys-inputs`, `--input handout=true|false` overrides `handout`
#let get-handout-config-common-dict-args(handout, prioritise-sys-inputs) = {
  if prioritise-sys-inputs {
    handout = sys.inputs.at("handout", default: handout)
  }
  if as-bool(handout) {
    (handout: true)
  } else {
    (:)
  }
}
