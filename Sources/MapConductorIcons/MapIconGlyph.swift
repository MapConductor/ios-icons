import CoreGraphics

/// A drawing command in a normalized, single-color map glyph.
public enum MapIconPathCommand: Hashable, Sendable {
    case moveTo(CGPoint)
    case lineTo(CGPoint)
    case curveTo(end: CGPoint, control1: CGPoint, control2: CGPoint)
    case close
}

/// A region-neutral or region-specific symbol which can be placed in a marker container.
public struct MapIconGlyph: Hashable, Sendable {
    public let id: String
    public let commands: [MapIconPathCommand]
    public let viewBoxSize: CGFloat

    public init(id: String, commands: [MapIconPathCommand], viewBoxSize: CGFloat = 24.0) {
        precondition(!id.isEmpty, "Map icon glyph ID must not be empty")
        precondition(!commands.isEmpty, "Map icon glyph commands must not be empty")
        precondition(viewBoxSize > 0, "Map icon glyph viewBoxSize must be positive")
        self.id = id
        self.commands = commands
        self.viewBoxSize = viewBoxSize
    }
}
