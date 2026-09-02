//
//  ScrollablePolicy.swift
//  Adwaita
//
//  Created by david-swift on 26.07.26.
//

import CAdw

/// Defines the policy to be used in a scrollable widget
/// when updating the scrolled window adjustments in a given orientation.
nonisolated
public enum ScrollablePolicy {

    /// Scrollable adjustments are based on the minimum size.
    case minimum
    /// Scrollable adjustments are based on the natural size.
    case natural

    /// The ScrollablePolicy value as GtkScrollablePolicy.
    var gtkValue: GtkScrollablePolicy {
        switch self {
        case .minimum:
            .GTK_SCROLL_MINIMUM
        case .natural:
            .GTK_SCROLL_NATURAL
        }
    }

}
