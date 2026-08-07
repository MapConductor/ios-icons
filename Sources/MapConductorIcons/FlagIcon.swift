import CoreGraphics
import MapConductorCore
import UIKit

/// iOS counterpart of Android's `FlagIcon` / React's `FlagIcon`.
///
/// Draws a pennant flag on a pole, anchored near the base of the pole. The
/// artwork is defined in the original SVG's coordinate space and scaled to fit a
/// square `iconSize * scale` points wide, preserving aspect ratio.
public final class FlagIcon: MarkerIconProtocol {
    /// Mirrors `Settings.Default.iconSize` (MarkerIconSize.Regular).
    public static let defaultIconSize: CGFloat = Settings.Default.iconSize
    /// Mirrors `Settings.Default.iconStroke`.
    public static let defaultStrokeWidth: CGFloat = Settings.Default.iconStroke
    public static let defaultFillColor: UIColor = .red
    public static let defaultStrokeColor: UIColor = .white
    public static let defaultAnchor = CGPoint(x: 0.176, y: 0.91)
    public static let defaultInfoAnchor = CGPoint(x: 0.5, y: 0.0)

    // The flag artwork lives in the SVG box below (origin margin 5.161 removed).
    private static let svgMargin: CGFloat = 5.161
    private static let svgWidth: CGFloat = 45.931 - 5.161
    private static let svgHeight: CGFloat = 51.48 - 5.161

    public let iconSize: CGFloat
    public let scale: CGFloat
    public let anchor: CGPoint
    public let infoAnchor: CGPoint
    public let debug: Bool

    private let fillColor: UIColor
    private let strokeColor: UIColor
    private let strokeWidth: CGFloat
    private let bitmapIcon: BitmapIcon

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
        self.anchor = FlagIcon.defaultAnchor
        self.infoAnchor = FlagIcon.defaultInfoAnchor
        self.bitmapIcon = FlagIcon.makeIcon(
            fillColor: fillColor,
            strokeColor: strokeColor,
            strokeWidth: strokeWidth,
            scale: scale,
            iconSize: iconSize,
            anchor: FlagIcon.defaultAnchor,
            infoAnchor: FlagIcon.defaultInfoAnchor,
            debug: debug
        )
    }

    public func toBitmapIcon() -> BitmapIcon { bitmapIcon }

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
    ) -> FlagIcon {
        FlagIcon(
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
            drawFlag(
                in: cg,
                width: canvasSize,
                height: canvasSize,
                fillColor: fillColor,
                strokeColor: strokeColor,
                strokeWidth: max(0.0, strokeWidth)
            )
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

    private static func drawFlag(
        in cg: CGContext,
        width: CGFloat,
        height: CGFloat,
        fillColor: UIColor,
        strokeColor: UIColor,
        strokeWidth: CGFloat
    ) {
        // Preserve aspect ratio, then center the scaled artwork in the canvas.
        let iconScale = min(width / svgWidth, height / svgHeight)
        let scaledWidth = svgWidth * iconScale
        let scaledHeight = svgHeight * iconScale
        let offsetX = (width - scaledWidth) / 2.0
        let offsetY = (height - scaledHeight) / 2.0

        cg.saveGState()
        cg.translateBy(x: offsetX, y: offsetY)
        cg.scaleBy(x: iconScale, y: iconScale)
        // Drop the original SVG margin so coordinates match the source paths.
        cg.translateBy(x: -svgMargin, y: -svgMargin)
        // The stroke width is set in the un-scaled coordinate space, so it scales
        // with the artwork exactly like Android/React (which stroke inside the
        // scaled group).
        cg.setLineWidth(strokeWidth)
        cg.setLineJoin(.round)

        // Main pennant.
        let flag = CGMutablePath()
        flag.move(to: CGPoint(x: 14.16, y: 7.037))
        flag.addLine(to: CGPoint(x: 41.892, y: 7.037))
        flag.addLine(to: CGPoint(x: 42.815, y: 9.797))
        flag.addCurve(
            to: CGPoint(x: 42.815, y: 12.297),
            control1: CGPoint(x: 43.339, y: 10.554),
            control2: CGPoint(x: 43.34, y: 11.517)
        )
        flag.addLine(to: CGPoint(x: 41.5, y: 12.199))
        flag.addCurve(
            to: CGPoint(x: 41.453, y: 26.646),
            control1: CGPoint(x: 39.579, y: 16.477),
            control2: CGPoint(x: 39.558, y: 22.846)
        )
        flag.addLine(to: CGPoint(x: 42.845, y: 29.2))
        flag.addCurve(
            to: CGPoint(x: 43.28, y: 30.584),
            control1: CGPoint(x: 43.295, y: 29.865),
            control2: CGPoint(x: 43.386, y: 30.384)
        )
        flag.addLine(to: CGPoint(x: 41.891, y: 30.999))
        flag.addLine(to: CGPoint(x: 14.16, y: 30.999))
        flag.closeSubpath()
        fillAndStroke(flag, in: cg, fillColor: fillColor, strokeColor: strokeColor)

        // Pole.
        let pole = CGMutablePath()
        pole.addRect(CGRect(x: 7.161, y: 5.5, width: 4.999, height: 40.48))
        fillAndStroke(pole, in: cg, fillColor: fillColor, strokeColor: strokeColor)

        // Pole cap.
        let cap = CGMutablePath()
        cap.addEllipse(in: CGRect(x: 9.66 - 2.0, y: 5.5 - 2.0, width: 4.0, height: 4.0))
        fillAndStroke(cap, in: cg, fillColor: fillColor, strokeColor: strokeColor)

        cg.restoreGState()
    }

    private static func fillAndStroke(
        _ path: CGPath,
        in cg: CGContext,
        fillColor: UIColor,
        strokeColor: UIColor
    ) {
        cg.setFillColor(fillColor.cgColor)
        cg.addPath(path)
        cg.fillPath()

        cg.setStrokeColor(strokeColor.cgColor)
        cg.addPath(path)
        cg.strokePath()
    }
}
