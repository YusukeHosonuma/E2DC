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
        #if os(macOS)
        content()
            // ⚠️ It works. (in currently implementation)
            .onReceive(Just(sourceText)) { text in
                if text.isEmpty == false, isAutomaticallyLaunchDeepL {
                    connectToDeelP(convertedText)
                }
            }
        #else
        NavigationView {
            content()
                .navigationTitle("E2DC")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isPresentActivitySheet) {
                    ActivityView(activityItems: [convertedText])
                }
        }
        .navigationViewStyle(.stack)
        #endif
    }

    private func content() -> some View {
        VStack(alignment: .leading) {
            //
            // Source
            //
            HStack {
                Text(L10n.source)
                Spacer()
                Button(L10n.clear, action: onTapClear)
            }
            TextEdit(L10n.pleasePasteDocumentationComment, text: $sourceText, font: editorFont)
                .foregroundColor(editorFontColor)
                .padding(.bottom)

            //
            // Destination
            //
            HStack {
                Text(L10n.destination)
                Spacer()
                #if os(macOS)
                Button(action: onTapCopyToClipboard) {
                    Label(L10n.copyToClipboard, symbol: "􀉄")
                }
                Button(action: onTapCopyToDeepL) {
                    Label(L10n.copyToDeepl, symbol: "􀈼")
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
            Toggle(L10n.automaticallyLaunchDeeplAtPasted, isOn: $isAutomaticallyLaunchDeepL)
                .toggleStyle(.checkbox)
            #endif
        }
        .padding()
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
