//
//  ContentView.swift
//  Shared
//
//  Created by Yusuke Hosonuma on 2022/03/28.
//

import Combine
import SFReadableSymbols
import SwiftUI

public struct RootView: View {
    #if os(macOS)
    @AppStorage("isAutomaticallyLaunchDeepL") private var isAutomaticallyLaunchDeepL = false
    #endif

    @State private var sourceText: String = ""
    @State private var isPresentActivitySheet = false

    public init() {}

    private let editorFont: Font = .custom("SF Mono", size: 16)

    // ☑️ Note: pure `.primary` is too bright.
    private let editorFontColor: Color = .primary.opacity(0.7)

    private var convertedText: String {
        sourceText.extractEnglishText()
    }

    public var body: some View {
        VStack(alignment: .leading) {
            //
            // Source
            //
            HStack {
                Text(NSLocalizedString("Source", bundle: .module, comment: ""))
                Spacer()
                Button(NSLocalizedString("Clear", bundle: .module, comment: ""), action: onTapClear)
            }
            TextEdit(NSLocalizedString("Please paste documentation comment.", bundle: .module, comment: ""), text: $sourceText, font: editorFont)
                .foregroundColor(editorFontColor)
                .padding(.bottom)

            //
            // Destination
            //
            HStack {
                Text(NSLocalizedString("Destination", bundle: .module, comment: ""))
                Spacer()
                #if os(macOS)
                Button(action: onTapCopyToClipboard) {
                    Label(NSLocalizedString("Copy to Clipboard", bundle: .module, comment: ""), symbol: "􀉄")
                }
                Button(action: onTapCopyToDeepL) {
                    Label(NSLocalizedString("Copy to DeepL", bundle: .module, comment: ""), symbol: "􀈼")
                }
                #else
                Button {
                    isPresentActivitySheet = true
                } label: {
                    Image(symbol: "􀈂")
                }
                #endif
            }
            TextEdit(text: .constant(convertedText), font: editorFont)
                .foregroundColor(editorFontColor)

            //
            // ☑️ Option
            //
            #if os(macOS)
            Toggle(NSLocalizedString("Automatically launch DeepL at pasted", bundle: .module, comment: ""), isOn: $isAutomaticallyLaunchDeepL)
                .toggleStyle(.checkbox)
            #endif
        }
        .padding()
        #if os(macOS)
            // ⚠️ It works. (in currently implementation)
            .onReceive(Just(sourceText)) { text in
                if text.isEmpty == false, isAutomaticallyLaunchDeepL {
                    connectToDeelP(convertedText)
                }
            }
        #else
            .sheet(isPresented: $isPresentActivitySheet) {
                ActivityView(activityItems: [convertedText])
            }
        #endif
    }

    // MARK: Action

    private func onTapClear() {
        sourceText = ""
    }

    #if os(macOS)
    private func onTapCopyToClipboard() {
        copyToPasteBoard(convertedText)
    }

    private func onTapCopyToDeepL() {
        connectToDeelP(convertedText)
    }
    #endif

    // MARK: Private

    #if os(macOS)
    private func connectToDeelP(_ text: String) {
        Task {
            // 💡 Deceive DeepL.
            copyToPasteBoard(text)
            try! await Task.sleep(milliseconds: 100)
            copyToPasteBoard(text)
        }
    }

    private func copyToPasteBoard(_ text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
    #endif
}
