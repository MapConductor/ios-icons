import CoreGraphics
import MapConductorCore
import UIKit

/// Displays a `MapIconGlyph` in MapConductor's default pin container.
public final class PinGlyphIcon: MarkerIconProtocol {
    public static let defaultIconSize: CGFloat = Settings.Default.iconSize
    public static let defaultStrokeWidth: CGFloat = Settings.Default.iconStroke
    public static let defaultAnchor = CGPoint(x: 0.5, y: 1.0)
    public static let defaultInfoAnchor = CGPoint(x: 0.5, y: 0.0)

    public let glyph: MapIconGlyph
    public let scale: CGFloat
    public let anchor: CGPoint = defaultAnchor
    public let iconSize: CGFloat
    public let infoAnchor: CGPoint
    public let debug: Bool

    private let fillColor: UIColor
    private let glyphColor: UIColor
    private let strokeColor: UIColor
    private let strokeWidth: CGFloat

    public init(
        glyph: MapIconGlyph,
        fillColor: UIColor = .red,
        glyphColor: UIColor = .white,
        strokeColor: UIColor = .white,
        strokeWidth: CGFloat = defaultStrokeWidth,
        scale: CGFloat = 1.0,
        infoAnchor: CGPoint = defaultInfoAnchor,
        iconSize: CGFloat = defaultIconSize,
        debug: Bool = false
    ) {
        self.glyph = glyph
        self.fillColor = fillColor
        self.glyphColor = glyphColor
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.scale = scale
        self.infoAnchor = infoAnchor
        self.iconSize = iconSize
        self.debug = debug
    }

    public func toBitmapIcon() -> BitmapIcon {
        BitmapIconCache.shared.value(forKey: "pin_glyph_icon_\(hashCode())") {
            makeIcon()
        }
    }

    public func hashCode() -> Int {
        var result = glyph.hashValue
        result = result &* 31 &+ fillColor.hashValue
        result = result &* 31 &+ glyphColor.hashValue
        result = result &* 31 &+ strokeColor.hashValue
        result = result &* 31 &+ strokeWidth.hashValue
        result = result &* 31 &+ scale.hashValue
        result = result &* 31 &+ infoAnchor.x.hashValue
        result = result &* 31 &+ infoAnchor.y.hashValue
        result = result &* 31 &+ iconSize.hashValue
        result = result &* 31 &+ debug.hashValue
        return result
    }

    public func copy(
        glyph: MapIconGlyph? = nil,
        fillColor: UIColor? = nil,
        glyphColor: UIColor? = nil,
        strokeColor: UIColor? = nil,
        strokeWidth: CGFloat? = nil,
        scale: CGFloat? = nil,
        infoAnchor: CGPoint? = nil,
        iconSize: CGFloat? = nil,
        debug: Bool? = nil
    ) -> PinGlyphIcon {
        PinGlyphIcon(
            glyph: glyph ?? self.glyph,
            fillColor: fillColor ?? self.fillColor,
            glyphColor: glyphColor ?? self.glyphColor,
            strokeColor: strokeColor ?? self.strokeColor,
            strokeWidth: strokeWidth ?? self.strokeWidth,
            scale: scale ?? self.scale,
            infoAnchor: infoAnchor ?? self.infoAnchor,
            iconSize: iconSize ?? self.iconSize,
            debug: debug ?? self.debug
        )
    }

    private func makeIcon() -> BitmapIcon {
        let canvasSize = max(1.0, iconSize * scale)
        let size = CGSize(width: canvasSize, height: canvasSize)
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = UIScreen.main.scale
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let image = renderer.image { rendererContext in
            let context = rendererContext.cgContext
            if debug {
                context.setStrokeColor(UIColor.black.cgColor)
                context.setLineWidth(1.0)
                context.stroke(CGRect(origin: .zero, size: size))
            }

            let markerPath = createMarkerPath(canvasSize: canvasSize)
            context.setFillColor(fillColor.cgColor)
            context.addPath(markerPath.cgPath)
            context.fillPath()

            context.setStrokeColor(strokeColor.cgColor)
            context.setLineWidth(strokeWidth * scale)
            context.setLineJoin(.round)
            context.setLineCap(.round)
            context.addPath(markerPath.cgPath)
            context.strokePath()

            let glyphSize = canvasSize * 0.42
            let origin = CGPoint(
                x: (canvasSize - glyphSize) / 2.0,
                y: canvasSize * 0.35 - glyphSize / 2.0
            )
            let glyphScale = glyphSize / glyph.viewBoxSize
            let glyphPath = UIBezierPath()
            for command in glyph.commands {
                switch command {
                case let .moveTo(point):
                    glyphPath.move(to: transform(point, scale: glyphScale, origin: origin))
                case let .lineTo(point):
                    glyphPath.addLine(to: transform(point, scale: glyphScale, origin: origin))
                case let .curveTo(end, control1, control2):
                    glyphPath.addCurve(
                        to: transform(end, scale: glyphScale, origin: origin),
                        controlPoint1: transform(control1, scale: glyphScale, origin: origin),
                        controlPoint2: transform(control2, scale: glyphScale, origin: origin)
                    )
                case .close:
                    glyphPath.close()
                }
            }
            context.setFillColor(glyphColor.cgColor)
            context.addPath(glyphPath.cgPath)
            context.fillPath()
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

    private func transform(_ point: CGPoint, scale: CGFloat, origin: CGPoint) -> CGPoint {
        CGPoint(x: origin.x + point.x * scale, y: origin.y + point.y * scale)
    }

    private func createMarkerPath(canvasSize: CGFloat) -> UIBezierPath {
        let originalSize = CGSize(width: 23.5, height: 25.6)
        let padding = max((strokeWidth * scale / 2.0) - 0.75, 0.0)
        let markerScale = min(
            (canvasSize - padding * 2.0) / originalSize.width,
            (canvasSize - padding) / originalSize.height
        )
        let offsetX = (canvasSize - originalSize.width * markerScale) / 2.0
        let offsetY = (canvasSize - originalSize.height * markerScale + strokeWidth * markerScale) / 2.0
        let path = UIBezierPath()
        var current = CGPoint(x: 12.0 * markerScale + offsetX, y: offsetY)
        path.move(to: current)

        func cubic(_ dx1: CGFloat, _ dy1: CGFloat, _ dx2: CGFloat, _ dy2: CGFloat, _ dx: CGFloat, _ dy: CGFloat) {
            let control1 = CGPoint(x: current.x + dx1 * markerScale, y: current.y + dy1 * markerScale)
            let control2 = CGPoint(x: current.x + dx2 * markerScale, y: current.y + dy2 * markerScale)
            current = CGPoint(x: current.x + dx * markerScale, y: current.y + dy * markerScale)
            path.addCurve(to: current, controlPoint1: control1, controlPoint2: control2)
        }
        func line(_ dx: CGFloat, _ dy: CGFloat) {
            current = CGPoint(x: current.x + dx * markerScale, y: current.y + dy * markerScale)
            path.addLine(to: current)
        }

        cubic(-4.4183, 0, -8, 3.5817, -8, 8)
        cubic(0, 1.421, 0.3816, 2.75, 1.0312, 3.906)
        cubic(0.1079, 0.192, 0.221, 0.381, 0.3438, 0.563)
        line(6.625, 11.531)
        line(6.625, -11.531)
        cubic(0.102, -0.151, 0.19, -0.311, 0.281, -0.469)
        line(0.063, -0.094)
        cubic(0.649, -1.156, 1.031, -2.485, 1.031, -3.906)
        cubic(0, -4.4183, -3.582, -8, -8, -8)
        path.close()
        return path
    }
}
