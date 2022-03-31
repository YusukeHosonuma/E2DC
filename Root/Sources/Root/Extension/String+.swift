//
//  File.swift
//
//
//  Created by Yusuke Hosonuma on 2022/03/28.
//

import Foundation

extension String {
    func extractEnglishText() -> String {
        return components(separatedBy: "\n")
            .map(\.pureText)
            .reduce(into: []) {
                if $1.isEmpty {
                    $0.append("\n")
                } else if $0.last == "\n" || $1.isListLine {
                    $0.append("\n" + $1) // Join with new-line
                } else {
                    $0.append(" " + $1.trimed()) // Join to one-line
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
    
    private func trimed() -> String {
        trimmingCharacters(in: .whitespaces)
    }
}
