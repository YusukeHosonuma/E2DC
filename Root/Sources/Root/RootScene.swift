//
//  File.swift
//
//
//  Created by Yusuke Hosonuma on 2022/03/30.
//

import SwiftUI

public struct RootScene: Scene {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif

    public init() {}

    public var body: some Scene {
        #if os(macOS)
        Settings {
            EmptyView()
        }
        // TODO: move to icon on app view.
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button(L10n.about) {
                    appDelegate.showAboutPanel()
                }
            }
        }
        #else
        WindowGroup {
            RootView()
        }
        #endif
    }
}

// 🔍 ref:
//
// About box window.
// https://stackoverflow.com/questions/64624261/swiftui-change-about-view-in-macos-app
//
// Status bar app:
// https://medium.com/@acwrightdesign/creating-a-macos-menu-bar-application-using-swiftui-54572a5d5f87
// https://stackoverflow.com/questions/25818967/application-is-agent-doesnt-work-in-swift
//
#if os(macOS)
private class AppDelegate: NSObject, NSApplicationDelegate {
    private var popover: NSPopover!
    private var statusBarItem: NSStatusItem!
    private var aboutBoxWindowController: NSWindowController?

    func showAboutPanel() {
        if aboutBoxWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable, /* .resizable,*/ .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = ""
            window.contentView = NSHostingView(rootView: AboutView())
            window.center()
            aboutBoxWindowController = NSWindowController(window: window)
        }

        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }

    // MARK: Status bar app

    func applicationDidFinishLaunching(_: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = RootView(showAboutPanelHandler: showAboutPanel)

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 440, height: 360)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover

        // Create the status item
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        if let button = statusBarItem.button {
            button.image = Bundle.module.image(forResource: "status-bar-icon")
            button.action = #selector(togglePopover(_:))
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
#endif
