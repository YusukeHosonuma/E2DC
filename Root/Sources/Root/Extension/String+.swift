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
            .map {
                $0.drop { $0 == " " }
                    .replacingOccurrences(of: "/// ", with: "")
                    .replacingOccurrences(of: "///", with: "")
            }
            .reduce([String]()) {
                if $1.isEmpty {
                    return $0 + ["\n\n"]
                } else if $0.last == "\n\n" {
                    return $0 + [$1]
                } else if $1.isListLine {
                    return $0 + ["\n" + $1]
                } else {
                    return $0 + [" " + $1.trimed()]
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
    
    private func trimed() -> String {
        trimmingCharacters(in: .whitespaces)
    }
}
