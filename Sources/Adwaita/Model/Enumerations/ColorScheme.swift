//
//  ColorScheme.swift
//  Adwaita
//
//  Created by david-swift on 01.02.26.
//

import CAdw

/// The system color scheme.
nonisolated
public enum ColorScheme {

    /// The dark color scheme.
    case dark
    /// The light color scheme.
    case light

    /// The ColorScheme value as GtkInterfaceColorScheme.
    var gtkValue: GtkInterfaceColorScheme {
        switch self {
        case .light:
            .GTK_INTERFACE_COLOR_SCHEME_LIGHT
        case .dark:
            .GTK_INTERFACE_COLOR_SCHEME_DARK
        }
    }

}
