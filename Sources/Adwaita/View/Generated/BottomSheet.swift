//
//  BottomSheet.swift
//  Adwaita
//
//  Created by auto-generation on 19.08.26.
//

import CAdw
import LevenshteinTransformations

/// A bottom sheet with an optional bottom bar.
/// 
/// 
/// 
/// `AdwBottomSheet` has three child widgets. ``content(_:)`` is
/// shown persistently. ``sheet(_:)`` is displayed above it when
/// it's open, and ``bottomBar(_:)`` is displayed when it's not.
/// 
/// Bottom sheet and bottom bar are attached to the bottom edge of the widget.
/// They take the full width by default, but can only take a portion of it if
/// ``fullWidth(_:)`` is set to `false`. In this case,
/// ``align(_:)`` determines where along the bottom edge they are
/// placed.
/// 
/// Bottom bar can be hidden using the ``revealBottomBar(_:)``
/// property.
/// 
/// `AdwBottomSheet` can be useful for applications such as music players, that
/// want to have a persistent bottom bar that expands into a bottom sheet when
/// clicked. It's meant for cases where a bottom sheet is tightly integrated into
/// the UI. For more transient bottom sheets, see `Dialog`.
/// 
/// To open or close the bottom sheet, use the ``open(_:)``
/// property.
/// 
/// By default, the bottom sheet has an overlaid drag handle. It can be disabled
/// by setting ``showDragHandle(_:)`` to `false`. Note that the
/// handle also controls whether the sheet can be dragged using a pointer.
/// 
/// Bottom sheets are modal by default, meaning that the content is dimmed and
/// cannot be accessed while the sheet is open. Set ``modal(_:)``
/// to `false` if this behavior is unwanted.
/// 
/// To disable user interactions for opening or closing the bottom sheet (such as
/// swipes or clicking the bottom bar or close button), set
/// ``canOpen(_:)`` or ``canClose(_:)`` to
/// `false`.
/// 
/// In some cases, particularly when using a full-width bottom bar, it may be
/// necessary to shift ``content(_:)`` upwards. Use the
/// ``bottomBarHeight(_:)`` and
/// ``sheetHeight(_:)`` for that.
/// 
/// `AdwBottomSheet` is not adaptive, and for larger window sizes applications
/// may want to replace it with another UI, such as a sidebar. This can be done
/// using `MultiLayoutView`.
/// 
/// 
public struct BottomSheet: AdwaitaWidget {

    #if exposeGeneratedAppearUpdateFunctions
    /// Additional update functions for type extensions.
    public var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    public var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []
    #else
    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []
    #endif

    /// Horizontal alignment of the bottom sheet.
    /// 
    /// 0 means the bottom sheet is flush with the start edge, 1 means it's flush
    /// with the end edge. 0.5 means it's centered.
    /// 
    /// Only used when ``fullWidth(_:)`` is set to `false`.
    var align: Float?
    /// The bottom bar widget.
    /// 
    /// Shown when ``open(_:)`` is `false`. When open, morphs into
    /// the ``sheet(_:)``.
    /// 
    /// Bottom bar can be temporarily hidden using the
    /// ``revealBottomBar(_:)`` property.
    var bottomBar: Body?
    /// The current bottom bar height.
    /// 
    /// It can be used to shift the content upwards permanently to accommodate for
    /// the bottom bar.
    var bottomBarHeight: Int?
    /// Whether the bottom sheet can be closed by user.
    /// 
    /// It can be closed via the close button, swiping down, pressing
    /// <kbd>Escape</kbd> or clicking the content dimming (when modal).
    /// 
    /// Bottom sheet can still be closed using ``open(_:)``.
    var canClose: Bool?
    /// Whether the bottom sheet can be opened by user.
    /// 
    /// It can be opened via clicking or swiping up from the bottom bar.
    /// 
    /// Does nothing if ``bottomBar(_:)`` is not set.
    /// 
    /// Bottom sheet can still be opened using ``open(_:)``.
    var canOpen: Bool?
    /// The content widget.
    /// 
    /// It's always shown, and the bottom sheet is overlaid over it.
    var content: Body?
    /// Whether the bottom sheet takes the full width.
    /// 
    /// When full width, ``align(_:)`` is ignored.
    var fullWidth: Bool?
    /// Whether the bottom sheet is modal.
    /// 
    /// When modal, ``content(_:)`` will be dimmed when the bottom
    /// sheet is open, and clicking it will close the bottom sheet. It also cannot
    /// be focused with keyboard.
    /// 
    /// Otherwise, the content is accessible even when the bottom sheet is open.
    var modal: Bool?
    /// Whether the bottom sheet is open.
    var open: Binding<Bool>?
    /// Whether to reveal the bottom bar.
    /// 
    /// The transition will be animated.
    /// 
    /// See ``bottomBar(_:)`` and
    /// ``bottomBarHeight(_:)``.
    var revealBottomBar: Bool?
    /// The bottom sheet widget.
    /// 
    /// Only shown when ``open(_:)`` is `true`.
    var sheet: Body?
    /// The current bottom sheet height.
    /// 
    /// It can be used to shift the content upwards when the bottom sheet is open.
    var sheetHeight: Int?
    /// Whether to overlay a drag handle in the bottom sheet.
    /// 
    /// The handle will be overlaid over ``sheet(_:)``.
    /// 
    /// When the handle is shown, `HeaderBar` will hide its default title,
    /// and `ToolbarView` will reserve space if there are no top bars.
    /// 
    /// Showing drag handle also allows to swipe the bottom sheet down (and to
    /// swipe the bottom bar up) with a pointer, instead of just touchscreen.
    var showDragHandle: Bool?
    /// Emitted when the close button or shortcut is used while
    /// ``canClose(_:)`` is set to `false`.
    var closeAttempt: (() -> Void)?

    /// Initialize `BottomSheet`.
    init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_bottom_sheet_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        if let bottomBarStorage = bottomBar?.storage(data: data, type: type) {
            storage.content["bottomBar"] = [bottomBarStorage]
            adw_bottom_sheet_set_bottom_bar(storage.opaquePointer, bottomBarStorage.opaquePointer?.cast())
        }
        if let contentStorage = content?.storage(data: data, type: type) {
            storage.content["content"] = [contentStorage]
            adw_bottom_sheet_set_content(storage.opaquePointer, contentStorage.opaquePointer?.cast())
        }
        if let sheetStorage = sheet?.storage(data: data, type: type) {
            storage.content["sheet"] = [sheetStorage]
            adw_bottom_sheet_set_sheet(storage.opaquePointer, sheetStorage.opaquePointer?.cast())
        }

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        if let closeAttempt {
            storage.connectSignal(name: "close-attempt", type: .noArgs) {
                closeAttempt()
            }
        }
        storage.modify { widget in

        storage.notify(name: "open") {
            let newValue = adw_bottom_sheet_get_open(storage.opaquePointer) != 0
if let open, newValue != open.wrappedValue {
    open.wrappedValue = newValue
}
        }
            if let align, updateProperties, (storage.previousState as? Self)?.align != align {
                adw_bottom_sheet_set_align(widget, align)
            }
            if let widget = storage.content["bottomBar"]?.first {
                bottomBar?.updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let canClose, updateProperties, (storage.previousState as? Self)?.canClose != canClose {
                adw_bottom_sheet_set_can_close(widget, canClose.cBool)
            }
            if let canOpen, updateProperties, (storage.previousState as? Self)?.canOpen != canOpen {
                adw_bottom_sheet_set_can_open(widget, canOpen.cBool)
            }
            if let widget = storage.content["content"]?.first {
                content?.updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let fullWidth, updateProperties, (storage.previousState as? Self)?.fullWidth != fullWidth {
                adw_bottom_sheet_set_full_width(widget, fullWidth.cBool)
            }
            if let modal, updateProperties, (storage.previousState as? Self)?.modal != modal {
                adw_bottom_sheet_set_modal(widget, modal.cBool)
            }
            if let open, updateProperties, (adw_bottom_sheet_get_open(storage.opaquePointer) != 0) != open.wrappedValue {
                adw_bottom_sheet_set_open(storage.opaquePointer, open.wrappedValue.cBool)
            }
            if let revealBottomBar, updateProperties, (storage.previousState as? Self)?.revealBottomBar != revealBottomBar {
                adw_bottom_sheet_set_reveal_bottom_bar(widget, revealBottomBar.cBool)
            }
            if let widget = storage.content["sheet"]?.first {
                sheet?.updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let showDragHandle, updateProperties, (storage.previousState as? Self)?.showDragHandle != showDragHandle {
                adw_bottom_sheet_set_show_drag_handle(widget, showDragHandle.cBool)
            }



        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// Horizontal alignment of the bottom sheet.
    /// 
    /// 0 means the bottom sheet is flush with the start edge, 1 means it's flush
    /// with the end edge. 0.5 means it's centered.
    /// 
    /// Only used when ``fullWidth(_:)`` is set to `false`.
    public func align(_ align: Float?) -> Self {
        modify { $0.align = align }
    }

    /// The bottom bar widget.
    /// 
    /// Shown when ``open(_:)`` is `false`. When open, morphs into
    /// the ``sheet(_:)``.
    /// 
    /// Bottom bar can be temporarily hidden using the
    /// ``revealBottomBar(_:)`` property.
    public func bottomBar(@ViewBuilder _ bottomBar: () -> Body) -> Self {
        modify { $0.bottomBar = bottomBar() }
    }

    /// The current bottom bar height.
    /// 
    /// It can be used to shift the content upwards permanently to accommodate for
    /// the bottom bar.
    public func bottomBarHeight(_ bottomBarHeight: Int?) -> Self {
        modify { $0.bottomBarHeight = bottomBarHeight }
    }

    /// Whether the bottom sheet can be closed by user.
    /// 
    /// It can be closed via the close button, swiping down, pressing
    /// <kbd>Escape</kbd> or clicking the content dimming (when modal).
    /// 
    /// Bottom sheet can still be closed using ``open(_:)``.
    public func canClose(_ canClose: Bool? = true) -> Self {
        modify { $0.canClose = canClose }
    }

    /// Whether the bottom sheet can be opened by user.
    /// 
    /// It can be opened via clicking or swiping up from the bottom bar.
    /// 
    /// Does nothing if ``bottomBar(_:)`` is not set.
    /// 
    /// Bottom sheet can still be opened using ``open(_:)``.
    public func canOpen(_ canOpen: Bool? = true) -> Self {
        modify { $0.canOpen = canOpen }
    }

    /// The content widget.
    /// 
    /// It's always shown, and the bottom sheet is overlaid over it.
    public func content(@ViewBuilder _ content: () -> Body) -> Self {
        modify { $0.content = content() }
    }

    /// Whether the bottom sheet takes the full width.
    /// 
    /// When full width, ``align(_:)`` is ignored.
    public func fullWidth(_ fullWidth: Bool? = true) -> Self {
        modify { $0.fullWidth = fullWidth }
    }

    /// Whether the bottom sheet is modal.
    /// 
    /// When modal, ``content(_:)`` will be dimmed when the bottom
    /// sheet is open, and clicking it will close the bottom sheet. It also cannot
    /// be focused with keyboard.
    /// 
    /// Otherwise, the content is accessible even when the bottom sheet is open.
    public func modal(_ modal: Bool? = true) -> Self {
        modify { $0.modal = modal }
    }

    /// Whether the bottom sheet is open.
    public func open(_ open: Binding<Bool>?) -> Self {
        modify { $0.open = open }
    }

    /// Whether to reveal the bottom bar.
    /// 
    /// The transition will be animated.
    /// 
    /// See ``bottomBar(_:)`` and
    /// ``bottomBarHeight(_:)``.
    public func revealBottomBar(_ revealBottomBar: Bool? = true) -> Self {
        modify { $0.revealBottomBar = revealBottomBar }
    }

    /// The bottom sheet widget.
    /// 
    /// Only shown when ``open(_:)`` is `true`.
    public func sheet(@ViewBuilder _ sheet: () -> Body) -> Self {
        modify { $0.sheet = sheet() }
    }

    /// The current bottom sheet height.
    /// 
    /// It can be used to shift the content upwards when the bottom sheet is open.
    public func sheetHeight(_ sheetHeight: Int?) -> Self {
        modify { $0.sheetHeight = sheetHeight }
    }

    /// Whether to overlay a drag handle in the bottom sheet.
    /// 
    /// The handle will be overlaid over ``sheet(_:)``.
    /// 
    /// When the handle is shown, `HeaderBar` will hide its default title,
    /// and `ToolbarView` will reserve space if there are no top bars.
    /// 
    /// Showing drag handle also allows to swipe the bottom sheet down (and to
    /// swipe the bottom bar up) with a pointer, instead of just touchscreen.
    public func showDragHandle(_ showDragHandle: Bool? = true) -> Self {
        modify { $0.showDragHandle = showDragHandle }
    }

    /// Emitted when the close button or shortcut is used while
    /// ``canClose(_:)`` is set to `false`.
    public func closeAttempt(_ closeAttempt: @escaping () -> Void) -> Self {
        modify { $0.closeAttempt = closeAttempt }
    }

}
