//
//  LengthUnit.swift
//  Adwaita
//
//  Created by desbeers on 07.08.26.
//

import CAdw

/// length units.
nonisolated
public enum LengthUnit: String, CaseIterable {

    /// Pixels.
    case pixels
    /// Points, changes with text scale factor.
    case points
    /// Scale independent pixels, changes with text scale factor.
    case scaleIndependentPixels

    /// The LengthUnit value as AdwLengthUnit.
    var adwValue: AdwLengthUnit {
        switch self {
        case .pixels:
            .ADW_LENGTH_UNIT_PX
        case .points:
            .ADW_LENGTH_UNIT_PT
        case .scaleIndependentPixels:
            .ADW_LENGTH_UNIT_SP
        }
    }

}
