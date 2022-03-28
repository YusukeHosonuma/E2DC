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

    public var body: some View {
        VStack(alignment: .leading) {
            //
            // Source
            //
            Text("Source:")
            TextEdit("Please paste source code.", text: $sourceText, font: editorFont)
                .padding(.bottom)

            //
            // Destination
            //
            HStack {
                Text("Destination:")
                Spacer()
                Button {
                    // TODO:
                } label: {
                    Label("Copy to Clipboard", symbol: "􀉄")
                }
            }
            TextEdit(text: $destinationText, font: editorFont)
        }
        .padding()
    }

    private var editorFont: Font {
        .custom("SF Mono", size: 16)
    }
}
