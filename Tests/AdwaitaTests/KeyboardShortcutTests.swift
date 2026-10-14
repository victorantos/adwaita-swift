//
//  KeyboardShortcutTests.swift
//  Adwaita
//
//  Keyboard shortcuts used as their own ids ("<Ctrl>k") must become valid action names, or GLib refuses the action and
//  no accelerator is bound.
//

import CAdw
import Testing

@testable import Adwaita

@Suite("Keyboard shortcuts")
struct KeyboardShortcutTests {

    @Test("a valid action name is kept as it is")
    func validNameKept() {
        #expect(AdwaitaApp.actionName(for: "record") == "record")
        #expect(AdwaitaApp.actionName(for: "section-1") == "section-1")
    }

    @Test("a shortcut used as its id becomes a valid, stable action name")
    func shortcutBecomesValidName() {
        let name = AdwaitaApp.actionName(for: "<Ctrl>k")
        #expect(name == "shortcut-3c4374726c3e6b")
        #expect(g_action_name_is_valid(name) != 0)
        #expect(AdwaitaApp.actionName(for: "<Ctrl>k") == name)
        #expect(AdwaitaApp.actionName(for: "<Ctrl><Shift>k") != name)
    }

    @Test("an application shortcut binds its accelerator to the action")
    func applicationShortcutBound() throws {
        let app = AdwaitaApp(id: "dev.aparoksha.AdwaitaTests")
        app.addKeyboardShortcut("<Ctrl>k", id: "<Ctrl>k") {}
        let detailed = "app." + AdwaitaApp.actionName(for: "<Ctrl>k")
        let accels = try #require(gtk_application_get_accels_for_action(app.pointer, detailed))
        defer { g_strfreev(accels) }
        let first = try #require(accels[0])
        #expect(String(cString: first) == "<Control>k")
        app.removeKeyboardShortcut(id: "<Ctrl>k")
        #expect(g_action_map_lookup_action(.init(app.pointer), AdwaitaApp.actionName(for: "<Ctrl>k")) == nil)
    }
}
