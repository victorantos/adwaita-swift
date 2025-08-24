import CAdw

/// Add ExpressibleByIntegerLiteral conformance to make GtkWrapMode usable as
// a RawValue in an enum.
extension GtkWrapMode: @retroactive ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self.init(UInt32(value))
  }
}
