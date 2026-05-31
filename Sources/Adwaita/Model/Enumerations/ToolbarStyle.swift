//
//  ToolbarStyle.swift
//  Adwaita
//
//  Created by david-swift on 15.04.25.
//

import CAdw

/// The top and bottom bar styles.
public enum ToolbarStyle {

    /// No background, shadow only for scrolled content.
    case flat
    /// Opaque background with a persistent shadow.
    case raised
    /// Opaque background with a persistent border.
    case raisedBorder

    /// The ToolbarStyle value as an AdwToolbarStyle value.
    var gtkValue: AdwToolbarStyle {
        switch self {
        case .flat:
            .ADW_TOOLBAR_FLAT
        case .raised:
            .ADW_TOOLBAR_RAISED
        case .raisedBorder:
            .ADW_TOOLBAR_RAISED_BORDER
        }
    }

}
