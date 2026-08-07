import CoreGraphics
import UIKit

/// Shared text measuring/drawing helpers for the info-bubble icons.
///
/// UIKit's `NSString.draw(at:)` positions text by the top-left of its bounding
/// box, whereas the Android/React reference icons position by the text baseline.
/// These helpers convert between the two so the ports render identically.
enum InfoBubbleTextRenderer {
    static func size(_ text: String, font: UIFont) -> CGSize {
        (text as NSString).size(withAttributes: [.font: font])
    }

    /// Draws `text` with its vertical center at `centerY` and its left edge at `x`.
    static func drawCentered(
        _ text: String,
        x: CGFloat,
        centerY: CGFloat,
        font: UIFont,
        color: UIColor
    ) {
        let measured = size(text, font: font)
        (text as NSString).draw(
            at: CGPoint(x: x, y: centerY - measured.height / 2.0),
            withAttributes: [.font: font, .foregroundColor: color]
        )
    }

    /// Draws `text` so its baseline sits at `baselineY` and its left edge at `x`
    /// — mirrors Android's `Canvas.drawText(text, x, baselineY, paint)`.
    static func drawBaseline(
        _ text: String,
        x: CGFloat,
        baselineY: CGFloat,
        font: UIFont,
        color: UIColor
    ) {
        (text as NSString).draw(
            at: CGPoint(x: x, y: baselineY - font.ascender),
            withAttributes: [.font: font, .foregroundColor: color]
        )
    }
}
