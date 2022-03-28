//
//  ContentView.swift
//  Shared
//
//  Created by Yusuke Hosonuma on 2022/03/28.
//

import SFReadableSymbols
import SwiftUI

public struct RootView: View {
    @State var sourceText: String = ""
    @State var destinationText: String = ""

    public init() {}

    private let editorFont: Font = .custom("SF Mono", size: 16)
    
    // ☑️ Note: pure `.white` is too bright.
    private let editorFontColor: Color = .white.opacity(0.7)

    private var convertedText: String {
        sourceText.extractEnglishText()
    }

    public var body: some View {
        VStack(alignment: .leading) {
            //
            // Source
            //
            Text("Source:")
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
        }
        .padding()
    }

    // MARK: Private

    private func onTapCopyToClipboard() {
        let text = convertedText
        copyToPasteBoard(text)
    }

    private func onTapCopyToDeepL() {
        let text = convertedText
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
