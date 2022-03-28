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
    @State private var sourceText: String = ""
    @State private var destinationText: String = ""
    @AppStorage("isAutomaticallyLaunchDeepL") private var isAutomaticallyLaunchDeepL = false

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
                Text("Source:")
                Spacer()
                Button(action: onTapClear) {
                    Label("Clear", symbol: "􀆄")
                }
            }
            TextEdit("Please paste source code.", text: $sourceText, font: editorFont)
                .foregroundColor(editorFontColor)
                .padding(.bottom)

            //
            // Destination
            //
            HStack {
                Text("Destination:")
                Spacer()
                Button(action: onTapCopyToClipboard) {
                    Label("Copy to Clipboard", symbol: "􀉄")
                }
                Button(action: onTapCopyToDeepL) {
                    Label("Copy to DeepL", symbol: "􀈼")
                }
            }
            TextEdit(text: .constant(convertedText), font: editorFont)
                .foregroundColor(editorFontColor)

            Toggle("Automatically launch DeepL when pasted.", isOn: $isAutomaticallyLaunchDeepL)
                .toggleStyle(.checkbox)
        }
        .padding()
        // ⚠️ It works. (in currently implementation)
        .onReceive(Just(sourceText)) { text in
            if text.isEmpty == false, isAutomaticallyLaunchDeepL {
                connectToDeelP(convertedText)
            }
        }
    }

    // MARK: Action

    private func onTapClear() {
        sourceText = ""
    }

    private func onTapCopyToClipboard() {
        copyToPasteBoard(convertedText)
    }

    private func onTapCopyToDeepL() {
        connectToDeelP(convertedText)
    }

    // MARK: Private

    private func connectToDeelP(_ text: String) {
        Task {
            copyToPasteBoard(text)
            try! await Task.sleep(milliseconds: 100) // 💡 Deceive DeepL.
            copyToPasteBoard(text)
        }
    }

    private func copyToPasteBoard(_ text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
}
