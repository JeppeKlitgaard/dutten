#import "../_utils/lib.typ": as-bool

// If `prioritise-sys-inputs`, `--input pympress=true|false` overrides `pympress`
#let get-pympress-config-common-dict-args(pympress, prioritise-sys-inputs) = {
  if prioritise-sys-inputs {
    pympress = sys.inputs.at("pympress", default: pympress)
  }
  if as-bool(pympress) {
    (show-notes-on-second-screen: right)
  } else {
    (:)
  }
}
