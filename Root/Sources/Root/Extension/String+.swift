//
//  File.swift
//
//
//  Created by Yusuke Hosonuma on 2022/03/28.
//

import Foundation

extension String {
    func extractEnglishText() -> String {
        lines
            .map(\.pureText)
            .reduce(into: []) { lines, newLine in
                func isCodeLine() -> Bool {
                    lines.last?.isListLine == false && newLine.starts(with: "    ")
                }

                if newLine.isEmpty {
                    lines.append("\n")
                } else if lines.last == "\n" || newLine.isListLine || isCodeLine() {
                    lines.append(contentsOf: ["\n", newLine]) // Join with new-line
                } else {
                    lines.append(" " + newLine.trimed()) // Join to one-line
                }
            }
            .joined()
            .replacingOccurrences(of: "``", with: "`")
            .trimed()
    }

    // e.g.
    // ```
    // - Parameters:
    //   - start: A valid index of the collection.
    // ```
    private var isListLine: Bool {
        drop { $0 == " " }.first == "-"
    }

    private var pureText: String {
        // Trimming space and documentation comment token.
        drop { $0 == " " }
            .replacingOccurrences(of: "/// ", with: "")
            .replacingOccurrences(of: "///", with: "")
    }

    private var lines: [String] {
        split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
    }

    private func trimed() -> String {
        trimmingCharacters(in: .whitespaces)
    }
}
