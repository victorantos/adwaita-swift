//
//  WrapPolicy.swift
//  Adwaita
//
//  Created by desbeers on 07.08.26.
//

import CAdw

/// The line wrapping behavior in a `AdwWrapLayout`` or `AdwWrapBox``.
public enum WrapPolicy: String, CaseIterable {

    /// Fit as many children into each line as possible,
    /// shrinking them down to their minimum size before wrapping to the next line.
    case minimumSize
    /// Wrap to the next line as soon as the previous line cannot fit
    /// any more children without shrinking them past their natural size.
    case naturalSize

    /// The WrapPolicy value as AdwWrapPolicy.
    var adwValue: AdwWrapPolicy {
        switch self {
        case .minimumSize:
            .ADW_WRAP_MINIMUM
        case .naturalSize:
            .ADW_WRAP_NATURAL
        }
    }

}
