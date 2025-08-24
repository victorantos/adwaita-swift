import CAdw

/// Wrap modes for `TextView`/`TextEditor`
public enum WrapMode: GtkWrapMode, RawRepresentable {
  case none // GTK_WRAP_NONE
  case char // GTK_WRAP_CHAR
  case word // GTK_WRAP_WORD
  case wordChar // GTK_WRAP_WORD_CHAR

  public var rawValue: GtkWrapMode {
    switch self {
      case .none: GTK_WRAP_NONE
      case .char: GTK_WRAP_CHAR
      case .word: GTK_WRAP_WORD
      case .wordChar: GTK_WRAP_WORD_CHAR
    }
  }

  public init?(rawValue: GtkWrapMode) {
    return nil
  }
}
