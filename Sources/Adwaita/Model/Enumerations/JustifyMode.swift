//
//  JustifyMode.swift
//  Adwaita
//
//  Created by desbeers on 07.08.26.
//

import CAdw

/// The line justify behavior in an `AdwWrapLayout` or `AdwWrapBox`.
public enum JustifyMode: String, CaseIterable {

    // swiftlint:disable discouraged_none_name
    /// Don’t justify children within a line.
    case none
    // swiftlint:enable discouraged_none_name
    /// Stretch each child within the line, keeping consistent spacing, so that the line fills the entire length.
    case fill
    /// Increase spacing between children, moving the children so that the first and last child
    /// are aligned with the beginning and end of the line.
    /// If the line only contains a single widget, it will be stretched regardless.
    case spread

    /// The JustifyMode value as AdwJustifyMode.
    var adwValue: AdwJustifyMode {
        switch self {
        case .none:
            .ADW_JUSTIFY_NONE
        case .fill:
            .ADW_JUSTIFY_FILL
        case .spread:
            .ADW_JUSTIFY_SPREAD
        }
    }

}
