//
//  File.swift
//
//
//  Created by Yusuke Hosonuma on 2022/03/30.
//

import SwiftUI

public struct RootScene: Scene {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    public init() {}

    public var body: some Scene {
        WindowGroup {
            RootView()
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button(L10n.about) {
                    appDelegate.showAboutPanel()
                }
            }
        }
    }
}

// ref: https://stackoverflow.com/questions/64624261/swiftui-change-about-view-in-macos-app

private class AppDelegate: NSObject, NSApplicationDelegate {
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
}
