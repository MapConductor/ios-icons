import CoreGraphics
import MapConductorCore
import UIKit

/// iOS counterpart of Android's `RoundInfoBubbleIcon` / React's `RoundInfoBubbleIcon`.
///
/// A pill-shaped bubble with a downward pointer, showing a leading image and a
/// trailing label (e.g. a price). Anchored at the tip of the pointer.
///
/// Like iOS `ImageIcon`, the leading artwork is supplied as a `UIImage` (Android
/// uses a `Drawable`, React an image URL — each platform's native image type).
public final class RoundInfoBubbleIcon: MarkerIconProtocol {
    /// Mirrors `MarkerIconSize.Small`.
    public static let defaultIconSize: CGFloat = MarkerIconSize.Small
    public static let defaultFillColor: UIColor = .white
    public static let defaultLabelColor: UIColor = .black
    public static let defaultAnchor = CGPoint(x: 0.5, y: 1.0)
    public static let defaultInfoAnchor = CGPoint(x: 0.5, y: 1.0)

    public let iconSize: CGFloat
    public let scale: CGFloat
    public let anchor: CGPoint
    public let infoAnchor: CGPoint
    public let debug: Bool

    private let image: UIImage
    private let label: String
    private let fillColor: UIColor

    public init(
        image: UIImage,
        label: String,
        fillColor: UIColor = defaultFillColor,
        scale: CGFloat = 1.0,
        iconSize: CGFloat = defaultIconSize,
        debug: Bool = false
    ) {
        self.image = image
        self.label = label
        self.fillColor = fillColor
        self.scale = scale
        self.iconSize = iconSize
        self.debug = debug
        self.anchor = RoundInfoBubbleIcon.defaultAnchor
        self.infoAnchor = RoundInfoBubbleIcon.defaultInfoAnchor
    }

    public func toBitmapIcon() -> BitmapIcon {
        BitmapIconCache.shared.value(forKey: "round_info_bubble_icon_\(hashCode())") {
            RoundInfoBubbleIcon.makeIcon(
                image: image,
                label: label,
                fillColor: fillColor,
                scale: scale,
                iconSize: iconSize,
                anchor: anchor,
                infoAnchor: infoAnchor,
                debug: debug
            )
        }
    }

    public func hashCode() -> Int {
        var result = image.hashValue
        result = result &* 31 &+ label.hashValue
        result = result &* 31 &+ fillColor.hashValue
        result = result &* 31 &+ scale.hashValue
        result = result &* 31 &+ iconSize.hashValue
        result = result &* 31 &+ debug.hashValue
        return result
    }

    public func copy(
        image: UIImage? = nil,
        label: String? = nil,
        fillColor: UIColor? = nil,
        scale: CGFloat? = nil,
        iconSize: CGFloat? = nil,
        debug: Bool? = nil
    ) -> RoundInfoBubbleIcon {
        RoundInfoBubbleIcon(
            image: image ?? self.image,
            label: label ?? self.label,
            fillColor: fillColor ?? self.fillColor,
            scale: scale ?? self.scale,
            iconSize: iconSize ?? self.iconSize,
            debug: debug ?? self.debug
        )
    }

    private static func makeIcon(
        image: UIImage,
        label: String,
        fillColor: UIColor,
        scale: CGFloat,
        iconSize: CGFloat,
        anchor: CGPoint,
        infoAnchor: CGPoint,
        debug: Bool
    ) -> BitmapIcon {
        let drawableSize = max(1.0, iconSize * scale)
        let innerPadding = drawableSize * 0.1

        let labelFont = UIFont.systemFont(ofSize: drawableSize * 0.5)
        let labelSize = InfoBubbleTextRenderer.size(label, font: labelFont)

        let canvasWidth = drawableSize + innerPadding + labelSize.width + innerPadding * 3
        let canvasHeight = max(drawableSize, labelSize.height) + innerPadding * 2
        let pointerHeight = canvasHeight / 8.0
        let totalHeight = canvasHeight + pointerHeight
        let cornerRadius = canvasHeight / 2.0
        let pointerHalfWidth = pointerHeight

        let size = CGSize(width: canvasWidth, height: totalHeight)
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = UIScreen.main.scale
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let rendered = renderer.image { context in
            let cg = context.cgContext
            if debug {
                cg.setStrokeColor(UIColor.black.cgColor)
                cg.setLineWidth(1.0)
                cg.stroke(CGRect(origin: .zero, size: size))
            }

            // Pill body + downward pointer as one filled path.
            let bubble = CGMutablePath()
            bubble.addRoundedRect(
                in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight),
                cornerWidth: cornerRadius,
                cornerHeight: cornerRadius
            )
            bubble.move(to: CGPoint(x: canvasWidth / 2.0 - pointerHalfWidth, y: canvasHeight))
            bubble.addLine(to: CGPoint(x: canvasWidth / 2.0 + pointerHalfWidth, y: canvasHeight))
            bubble.addLine(to: CGPoint(x: canvasWidth / 2.0, y: canvasHeight + pointerHeight))
            bubble.closeSubpath()
            cg.setFillColor(fillColor.cgColor)
            cg.addPath(bubble)
            cg.fillPath()

            image.draw(in: CGRect(x: innerPadding, y: innerPadding, width: drawableSize, height: drawableSize))

            InfoBubbleTextRenderer.drawCentered(
                label,
                x: innerPadding + drawableSize + innerPadding,
                centerY: innerPadding + drawableSize / 2.0,
                font: labelFont,
                color: defaultLabelColor
            )
        }

        return BitmapIcon(
            bitmap: rendered,
            anchor: anchor,
            size: size,
            scale: scale,
            iconSize: iconSize,
            infoAnchor: infoAnchor,
            debug: debug
        )
    }
}
