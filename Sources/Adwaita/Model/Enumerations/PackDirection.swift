//
//  PackDirection.swift
//  Adwaita
//
//  Created by desbeers on 07.08.26.
//

import CAdw

/// The child packing behavior in a `AdwWrapLayout`` or `AdwWrapBox``.
public enum PackDirection: String, CaseIterable {

    /// Pack children from left to right for LTR languages, or top to bottom vertically.
    case startToEnd
    /// Pack children from right to left for LTR languages, or bottom to top vertically.
    case endToStart

    /// The PackDirection value as AdwPackDirection.
    var adwValue: AdwPackDirection {
        switch self {
        case .startToEnd:
            .ADW_PACK_START_TO_END
        case .endToStart:
            .ADW_PACK_END_TO_START
        }
    }

}
