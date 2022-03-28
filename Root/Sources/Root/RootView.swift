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
    @AppStorage("isAutomaticallyLaunchDeepL") private var isAutomaticallyLaunchDeepL = false
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
                Text("Source:")
                Spacer()
                Button("Clear", action: onTapClear)
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
                #if os(macOS)
                Button(action: onTapCopyToClipboard) {
                    Label("Copy to Clipboard", symbol: "􀉄")
                }
                Button(action: onTapCopyToDeepL) {
                    Label("Copy to DeepL", symbol: "􀈼")
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

            #if os(macOS)
            Toggle("Automatically launch DeepL when pasted.", isOn: $isAutomaticallyLaunchDeepL)
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
