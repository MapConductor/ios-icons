# MapConductor Icons

Marker icons and map glyph containers for the MapConductor iOS SDK.

Map glyphs are selected explicitly; the package never substitutes a symbol from
the device locale.

```swift
import MapConductorIcons

let hospital = PinGlyphIcon(
    glyph: CommonMapIcons.hospital,
    fillColor: .systemBlue,
    glyphColor: .white
)
```

Region-specific glyphs are distributed as separate products and repositories,
for example `MapConductorIconsJP` from `ios-icons-jp`. They use the containers
and cache supplied by this common package.
