//
//  License.swift
//  Adwaita
//
//  Created by desbeers on 16.08.26.
//

import CAdw

/// The type of license for an application.
public enum License {
    /// No license specified.
    case unknown
    /// A custom license.
    case custom
    /// The GNU General Public License, version 2.0 or later.
    case gpl2
    /// The GNU General Public License, version 3.0 or later.
    case gpl3
    /// The GNU Lesser General Public License, version 2.1 or later.
    case lgpl21
    /// The GNU Lesser General Public License, version 3.0 or later.
    case lgpl3
    /// The BSD standard license.
    case bsd
    /// The MIT/X11 standard license.
    case mitX11
    /// The Artistic License, version 2.0.
    case artistic
    /// The GNU General Public License, version 2.0 only.
    case gpl2Only
    /// The GNU General Public License, version 3.0 only.
    case gpl3Only
    /// The GNU Lesser General Public License, version 2.1 only.
    case lgpl21Only
    /// The GNU Lesser General Public License, version 3.0 only.
    case lgpl3Only
    /// The GNU Affero General Public License, version 3.0 or later.
    case agpl3
    /// The GNU Affero General Public License, version 3.0 only.
    case agpl3Only
    /// The 3-clause BSD license.
    case bsd3
    /// The Apache License, version 2.0.
    case apache2
    /// The Mozilla Public License, version 2.0.
    case mpl2
    /// Zero-Clause BSD license.
    case bsd0

    /// The License value as GtkLicense.
    var gtkValue: GtkLicense {
        switch self {
        case .unknown:
            .GTK_LICENSE_UNKNOWN
        case .custom:
            .GTK_LICENSE_CUSTOM
        case .gpl2:
            .GTK_LICENSE_GPL_2_0
        case .gpl3:
            .GTK_LICENSE_GPL_3_0
        case .lgpl21:
            .GTK_LICENSE_LGPL_2_1
        case .lgpl3:
            .GTK_LICENSE_LGPL_3_0
        case .bsd:
            .GTK_LICENSE_BSD
        case .mitX11:
            .GTK_LICENSE_MIT_X11
        case .artistic:
            .GTK_LICENSE_ARTISTIC
        case .gpl2Only:
            .GTK_LICENSE_GPL_2_0_ONLY
        case .gpl3Only:
            .GTK_LICENSE_GPL_3_0_ONLY
        case .lgpl21Only:
            .GTK_LICENSE_LGPL_2_1_ONLY
        case .lgpl3Only:
            .GTK_LICENSE_LGPL_3_0_ONLY
        case .agpl3:
            .GTK_LICENSE_AGPL_3_0
        case .agpl3Only:
            .GTK_LICENSE_AGPL_3_0_ONLY
        case .bsd3:
            .GTK_LICENSE_BSD_3
        case .apache2:
            .GTK_LICENSE_APACHE_2_0
        case .mpl2:
            .GTK_LICENSE_MPL_2_0
        case .bsd0:
            .GTK_LICENSE_0BSD
        }
    }
}
