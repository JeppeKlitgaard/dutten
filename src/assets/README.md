# DTU Logos

Retrieved using `wget -r --no-parent https://media.adm.dtu.dk/designguide/DTU_Design_Guide_Pro_User/DTU_Design_Guide_Logo/`

The naming conventions used by the Design Guide are, of course, not consistent.

- Coral Red -> Red
- Corp Red -> Corporate Red

## Steps

1. Download with wget
2. Move appropriate
3. Rename appropriately
4. Flatten with `for f in *.pdf; do echo "Processing $f"; pdftocairo -pdf "$f" "$f"; done`
5. Crop with `pdfcrop`: `for f in *.pdf; do echo "Processing $f"; pdfcrop "$f" "$f"; done`

For the SVG that is used for RGB images, I did:
1. Use one of the RGB PDFs in and online PDF to SVG converter
2. Paste the SVG into [this viewer](https://www.svgviewer.dev/) and compressed
3. Manually change fill color to `#000`
4. Saved as `dtu_logo.svg`