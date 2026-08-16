import CoreGraphics
import MapConductorCore
import UIKit

/// iOS counterpart of Android's `CircleIcon` / React's `CircleIcon`.
///
/// Draws a filled dot with a stroke, anchored at its left-center so it can sit at
/// the tip of a route/segment. The whole circle is `iconSize * scale` points wide.
public final class CircleIcon: MarkerIconProtocol {
    /// Mirrors `Settings.Default.iconSize` (MarkerIconSize.Regular).
    public static let defaultIconSize: CGFloat = Settings.Default.iconSize
    /// Mirrors `Settings.Default.iconStroke`.
    public static let defaultStrokeWidth: CGFloat = Settings.Default.iconStroke
    public static let defaultFillColor: UIColor = .red
    public static let defaultStrokeColor: UIColor = .white
    public static let defaultAnchor = CGPoint(x: 0.0, y: 0.5)
    public static let defaultInfoAnchor = CGPoint(x: 0.5, y: 0.5)

    public let iconSize: CGFloat
    public let scale: CGFloat
    public let anchor: CGPoint
    public let infoAnchor: CGPoint
    public let debug: Bool

    private let fillColor: UIColor
    private let strokeColor: UIColor
    private let strokeWidth: CGFloat

    public init(
        fillColor: UIColor = defaultFillColor,
        strokeColor: UIColor = defaultStrokeColor,
        strokeWidth: CGFloat = defaultStrokeWidth,
        scale: CGFloat = 1.0,
        iconSize: CGFloat = defaultIconSize,
        debug: Bool = false
    ) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.scale = scale
        self.iconSize = iconSize
        self.debug = debug
        self.anchor = CircleIcon.defaultAnchor
        self.infoAnchor = CircleIcon.defaultInfoAnchor
    }

    public func toBitmapIcon() -> BitmapIcon {
        BitmapIconCache.shared.value(forKey: "circle_icon_\(hashCode())") {
            CircleIcon.makeIcon(
                fillColor: fillColor,
                strokeColor: strokeColor,
                strokeWidth: strokeWidth,
                scale: scale,
                iconSize: iconSize,
                anchor: anchor,
                infoAnchor: infoAnchor,
                debug: debug
            )
        }
    }

    public func hashCode() -> Int {
        var result = fillColor.hashValue
        result = result &* 31 &+ strokeColor.hashValue
        result = result &* 31 &+ strokeWidth.hashValue
        result = result &* 31 &+ scale.hashValue
        result = result &* 31 &+ iconSize.hashValue
        result = result &* 31 &+ debug.hashValue
        return result
    }

    public func copy(
        fillColor: UIColor? = nil,
        strokeColor: UIColor? = nil,
        strokeWidth: CGFloat? = nil,
        scale: CGFloat? = nil,
        iconSize: CGFloat? = nil,
        debug: Bool? = nil
    ) -> CircleIcon {
        CircleIcon(
            fillColor: fillColor ?? self.fillColor,
            strokeColor: strokeColor ?? self.strokeColor,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            scale: scale ?? self.scale,
            iconSize: iconSize ?? self.iconSize,
            debug: debug ?? self.debug
        )
    }

    private static func makeIcon(
        fillColor: UIColor,
        strokeColor: UIColor,
        strokeWidth: CGFloat,
        scale: CGFloat,
        iconSize: CGFloat,
        anchor: CGPoint,
        infoAnchor: CGPoint,
        debug: Bool
    ) -> BitmapIcon {
        let canvasSize = max(1.0, iconSize * scale)
        let size = CGSize(width: canvasSize, height: canvasSize)
        let stroke = max(0.0, strokeWidth)
        let radius = max(0.0, canvasSize / 2.0 - stroke)
        let center = CGPoint(x: canvasSize / 2.0, y: canvasSize / 2.0)

        let format = UIGraphicsImageRendererFormat.default()
        format.scale = UIScreen.main.scale
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let image = renderer.image { context in
            let cg = context.cgContext
            if debug {
                cg.setStrokeColor(UIColor.black.cgColor)
                cg.setLineWidth(1.0)
                cg.stroke(CGRect(origin: .zero, size: size))
            }

            let circle = UIBezierPath(
                arcCenter: center,
                radius: radius,
                startAngle: 0,
                endAngle: 2.0 * .pi,
                clockwise: true
            )

            cg.setFillColor(fillColor.cgColor)
            cg.addPath(circle.cgPath)
            cg.fillPath()

            if stroke > 0 {
                cg.setStrokeColor(strokeColor.cgColor)
                cg.setLineWidth(stroke)
                cg.addPath(circle.cgPath)
                cg.strokePath()
            }
        }

        return BitmapIcon(
            bitmap: image,
            anchor: anchor,
            size: size,
            scale: scale,
            iconSize: iconSize,
            infoAnchor: infoAnchor,
            debug: debug
        )
    }
}
