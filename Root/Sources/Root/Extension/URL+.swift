//
//  File.swift
//
//
//  Created by Yusuke Hosonuma on 2022/03/30.
//

import Foundation

extension URL {
    var displayString: String {
        (host ?? "") + path
    }
}
