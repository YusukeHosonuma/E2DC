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
        // ☑️ moved to icon on app view.
        // .commands {
        //     CommandGroup(replacing: CommandGroupPlacement.appInfo) {
        //         Button(L10n.about) {
        //             appDelegate.showAboutPanel()
        //         }
        //     }
        // }
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
    private var aboutBoxWindowController: NSWindowController?
    private var statusBar: StatusBarController<RootView>?

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
        statusBar = .init(
            RootView(showAboutPanelHandler: showAboutPanel),
            width: 440,
            height: 360,
            image: Bundle.module.image(forResource: "status-bar-icon")!
        )
    }
}

private final class StatusBarController<Content: View> {
    private var mainMenu: NSMenu!
    private var popover: NSPopover!
    private var statusBarItem: NSStatusItem!

    init(_ contentView: Content, width: Int, height: Int, image: NSImage) {
        // 💡 Important: This is need to handle any key events on popover like `Cmd + V` and others.
        //
        // Problem and solution:
        // https://stackoverflow.com/questions/49637675/cut-copy-paste-keyboard-shortcuts-not-working-in-nspopover
        //
        // Load nib:
        // http://cocoadays.blogspot.com/2010/11/mac-nib.html
        //
        let nib = NSNib(nibNamed: "MainMenu", bundle: Bundle.main)!
        var topLevelArray: NSArray?
        nib.instantiate(withOwner: nil, topLevelObjects: &topLevelArray)
        let results = topLevelArray as! [Any]
        let item = results.last { $0 is NSMenu }
        mainMenu = item as? NSMenu

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: width, height: height)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover

        // Create the status item
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        if let button = statusBarItem.button {
            button.image = image
            button.action = #selector(togglePopover(_:))
            button.target = self
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
