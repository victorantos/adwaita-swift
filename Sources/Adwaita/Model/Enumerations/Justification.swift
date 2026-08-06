//
//  Justification.swift
//  Adwaita
//
//  Created by desbeers on 03.08.26.
//

import CAdw

/// Justifying the text inside a GtkLabel widget.
public enum Justification: String, CaseIterable {

    /// The text is placed at the left edge of the label.
    case left
    /// The text is placed at the right edge of the label.
    case right
    /// The text is placed in the center of the label.
    case center
    /// The text is distributed across the label.
    case fill

    /// The Justification value as GtkJustification.
    var gtkValue: GtkJustification {
        switch self {
        case .left:
            .GTK_JUSTIFY_LEFT
        case .right:
            .GTK_JUSTIFY_RIGHT
        case .center:
            .GTK_JUSTIFY_CENTER
        case .fill:
            .GTK_JUSTIFY_FILL
        }
    }

}
