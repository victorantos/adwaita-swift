//
//  Orientation.swift
//  Adwaita
//
//  Created by desbeers on 03.08.26.
//

import CAdw

/// The orientation of widgets and other objects.
nonisolated
public enum Orientation: String, CaseIterable {

    /// The element is in horizontal orientation.
    case horizontal
    /// The element is in vertical orientation.
    case vertical

    /// The orientation value as GtkOrientation.
    var gtkValue: GtkOrientation {
        switch self {
        case .horizontal:
            .GTK_ORIENTATION_HORIZONTAL
        case .vertical:
            .GTK_ORIENTATION_VERTICAL
        }
    }

}
