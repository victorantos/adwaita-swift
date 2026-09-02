//
//  Transition.swift
//  Adwaita
//
//  Created by david-swift on 21.01.24.
//

import CAdw

/// A transition for a stack.
nonisolated
public enum Transition: Int {

    // swiftlint:disable missing_docs discouraged_none_name
    case none
    case crossfade
    case slideRight, slideLeft, slideUp, slideDown, slideLeftRight, slideUpDown
    case coverUp, coverDown, coverLeft, coverRight
    case uncoverUp, uncoverDown, uncoverLeft, uncoverRight
    case coverUpDown, coverDownUp, coverLeftRight, coverRightLeft
    case rotateLeft, rotateRight, rotateLeftRight
    // swiftlint:enable missing_docs discouraged_none_name

    /// Get the GtkStackTransitionType transition.
    public var cTransition: GtkStackTransitionType {
        switch self {
        case .none:
            .GTK_STACK_TRANSITION_TYPE_NONE
        case .crossfade:
            .GTK_STACK_TRANSITION_TYPE_CROSSFADE
        case .slideRight:
            .GTK_STACK_TRANSITION_TYPE_SLIDE_RIGHT
        case .slideLeft:
            .GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT
        case .slideUp:
            .GTK_STACK_TRANSITION_TYPE_SLIDE_UP
        case .slideDown:
            .GTK_STACK_TRANSITION_TYPE_SLIDE_DOWN
        case .slideLeftRight:
            .GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT
        case .slideUpDown:
            .GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN
        case .coverUp:
            .GTK_STACK_TRANSITION_TYPE_OVER_UP
        case .coverDown:
            .GTK_STACK_TRANSITION_TYPE_OVER_DOWN
        case .coverLeft:
            .GTK_STACK_TRANSITION_TYPE_OVER_LEFT
        case .coverRight:
            .GTK_STACK_TRANSITION_TYPE_OVER_RIGHT
        case .uncoverUp:
            .GTK_STACK_TRANSITION_TYPE_UNDER_UP
        case .uncoverDown:
            .GTK_STACK_TRANSITION_TYPE_UNDER_DOWN
        case .uncoverLeft:
            .GTK_STACK_TRANSITION_TYPE_UNDER_LEFT
        case .uncoverRight:
            .GTK_STACK_TRANSITION_TYPE_UNDER_RIGHT
        case .coverUpDown:
            .GTK_STACK_TRANSITION_TYPE_OVER_UP_DOWN
        case .coverDownUp:
            .GTK_STACK_TRANSITION_TYPE_OVER_DOWN_UP
        case .coverLeftRight:
            .GTK_STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT
        case .coverRightLeft:
            .GTK_STACK_TRANSITION_TYPE_OVER_RIGHT_LEFT
        case .rotateLeft:
            .GTK_STACK_TRANSITION_TYPE_ROTATE_LEFT
        case .rotateRight:
            .GTK_STACK_TRANSITION_TYPE_ROTATE_RIGHT
        case .rotateLeftRight:
            .GTK_STACK_TRANSITION_TYPE_ROTATE_LEFT_RIGHT
        }
    }

}
