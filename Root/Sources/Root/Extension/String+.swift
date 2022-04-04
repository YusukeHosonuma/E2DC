//
//  File.swift
//
//
//  Created by Yusuke Hosonuma on 2022/03/28.
//

import Foundation

extension String {
    func extractEnglishText() -> String {
        if isEmpty {
            return self
        }

        return lines
            .compactMap(\.removeCommentToken)
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
        if let firstToken = removeIndent().first {
            return ["-", "@"].contains(firstToken)
        } else {
            return false
        }
    }

    // Trimming space and documentation comment token.
    private var removeCommentToken: String? {
        let line = removeIndent()

        if line.hasPrefix("/**") || line.hasPrefix("*/") {
            return nil
        } else {
            return ["/// ", "///", "* ", "*"].reduce(line) {
                $0.replacingOccurrences(of: $1, with: "")
            }
        }
    }

    private var lines: [String] {
        split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
    }

    private func trimed() -> String {
        trimmingCharacters(in: .whitespaces)
    }

    private func removeIndent() -> String {
        String(drop { $0 == " " })
    }
}
