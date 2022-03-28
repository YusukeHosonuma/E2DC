//
//  File.swift
//
//
//  Created by Yusuke Hosonuma on 2022/03/28.
//

import Foundation

extension String {
    func extractEnglishText() -> String {
        split(separator: "\n")
            .map { $0.drop { $0 == " " } }
            .joined(separator: "\n")
            .components(separatedBy: "///\n")
            .map {
                $0.split(separator: "\n").map {
                    $0.replacingOccurrences(of: "/// ", with: "")
                }
                .joined(separator: " ")
            }
            .joined(separator: "\n\n")
            .replacingOccurrences(of: "``", with: "`")
    }
}
