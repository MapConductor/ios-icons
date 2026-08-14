import CoreGraphics
import MapConductorCore
import UIKit

/// iOS counterpart of Android's `RightTailInfoBubbleIcon` / React's `RightTailInfoBubbleIcon`.
///
/// A rectangular bubble with a pointer near its right edge, showing a leading
/// image, a trailing label (e.g. a duration) and a snippet line below (e.g. a
/// distance). Anchored at the tip of the pointer.
///
/// Like iOS `ImageIcon`, the leading artwork is supplied as a `UIImage` (Android
/// uses a `Drawable`, React an image URL — each platform's native image type).
public final class RightTailInfoBubbleIcon: MarkerIconProtocol {
    /// Mirrors `MarkerIconSize.Small`.
    public static let defaultIconSize: CGFloat = MarkerIconSize.Small
    /// Mirrors React's `#d3d3d3` default (light gray bubble).
    public static let defaultFillColor = UIColor(white: 211.0 / 255.0, alpha: 1.0)
    /// Mirrors React's `#ffff00` default (yellow label).
    public static let defaultLabelTextColor: UIColor = .yellow
    /// Mirrors the `#808080` snippet color.
    public static let defaultSnippetColor = UIColor(white: 128.0 / 255.0, alpha: 1.0)
    public static let defaultAnchor = CGPoint(x: 0.5, y: 1.0)
    public static let defaultInfoAnchor = CGPoint(x: 0.5, y: 1.0)

    public let iconSize: CGFloat
    public let scale: CGFloat
    public let anchor: CGPoint
    public let infoAnchor: CGPoint
    public let debug: Bool

    private let image: UIImage
    private let label: String
    private let snippet: String
    private let fillColor: UIColor
    private let labelTextColor: UIColor

    public init(
        image: UIImage,
        label: String,
        snippet: String,
        fillColor: UIColor = defaultFillColor,
        labelTextColor: UIColor = defaultLabelTextColor,
        scale: CGFloat = 1.0,
        iconSize: CGFloat = defaultIconSize,
        debug: Bool = false
    ) {
        self.image = image
        self.label = label
        self.snippet = snippet
        self.fillColor = fillColor
        self.labelTextColor = labelTextColor
        self.scale = scale
        self.iconSize = iconSize
        self.debug = debug
        self.anchor = RightTailInfoBubbleIcon.defaultAnchor
        self.infoAnchor = RightTailInfoBubbleIcon.defaultInfoAnchor
    }

    public func toBitmapIcon() -> BitmapIcon {
        BitmapIconCache.shared.value(forKey: "right_tail_info_bubble_icon_\(hashCode())") {
            RightTailInfoBubbleIcon.makeIcon(
                image: image,
                label: label,
                snippet: snippet,
                fillColor: fillColor,
                labelTextColor: labelTextColor,
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
        result = result &* 31 &+ snippet.hashValue
        result = result &* 31 &+ fillColor.hashValue
        result = result &* 31 &+ labelTextColor.hashValue
        result = result &* 31 &+ scale.hashValue
        result = result &* 31 &+ iconSize.hashValue
        result = result &* 31 &+ debug.hashValue
        return result
    }

    public func copy(
        image: UIImage? = nil,
        label: String? = nil,
        snippet: String? = nil,
        fillColor: UIColor? = nil,
        labelTextColor: UIColor? = nil,
        scale: CGFloat? = nil,
        iconSize: CGFloat? = nil,
        debug: Bool? = nil
    ) -> RightTailInfoBubbleIcon {
        RightTailInfoBubbleIcon(
            image: image ?? self.image,
            label: label ?? self.label,
            snippet: snippet ?? self.snippet,
            fillColor: fillColor ?? self.fillColor,
            labelTextColor: labelTextColor ?? self.labelTextColor,
            scale: scale ?? self.scale,
            iconSize: iconSize ?? self.iconSize,
            debug: debug ?? self.debug
        )
    }

    private static func makeIcon(
        image: UIImage,
        label: String,
        snippet: String,
        fillColor: UIColor,
        labelTextColor: UIColor,
        scale: CGFloat,
        iconSize: CGFloat,
        anchor: CGPoint,
        infoAnchor: CGPoint,
        debug: Bool
    ) -> BitmapIcon {
        let drawableSize = max(1.0, iconSize * scale)
        let drawableInnerPadding = drawableSize * 0.1
        let contentMargin = drawableSize * 0.2

        let labelFont = UIFont.systemFont(ofSize: drawableSize * 0.7)
        let labelSize = InfoBubbleTextRenderer.size(label, font: labelFont)
        let snippetFont = UIFont.systemFont(ofSize: drawableSize * 0.4)
        let snippetSize = InfoBubbleTextRenderer.size(snippet, font: snippetFont)

        let canvasWidth = drawableSize + drawableInnerPadding + labelSize.width + contentMargin * 2
        let canvasHeight = max(drawableSize, labelSize.height)
            + drawableInnerPadding + snippetSize.height + drawableInnerPadding * 2
        let pointerWidth = canvasWidth / 9.0
        let pointerHeight = canvasHeight / 8.0
        let totalHeight = canvasHeight + pointerHeight

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

            // Rectangular body + right-of-center pointer as one filled path.
            let bubble = CGMutablePath()
            bubble.addRect(CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))
            bubble.move(to: CGPoint(x: canvasWidth - pointerWidth * 2.0, y: canvasHeight))
            bubble.addLine(to: CGPoint(x: canvasWidth - pointerWidth, y: canvasHeight))
            bubble.addLine(to: CGPoint(x: canvasWidth - pointerWidth * 1.5, y: canvasHeight + pointerHeight))
            bubble.closeSubpath()
            cg.setFillColor(fillColor.cgColor)
            cg.addPath(bubble)
            cg.fillPath()

            let imageSide = (drawableInnerPadding + drawableSize) - contentMargin
            image.draw(in: CGRect(x: contentMargin, y: contentMargin, width: imageSide, height: imageSide))

            InfoBubbleTextRenderer.drawCentered(
                label,
                x: contentMargin + drawableSize + drawableInnerPadding,
                centerY: contentMargin + drawableSize / 2.0,
                font: labelFont,
                color: labelTextColor
            )

            InfoBubbleTextRenderer.drawBaseline(
                snippet,
                x: contentMargin,
                baselineY: canvasHeight - contentMargin,
                font: snippetFont,
                color: defaultSnippetColor
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
