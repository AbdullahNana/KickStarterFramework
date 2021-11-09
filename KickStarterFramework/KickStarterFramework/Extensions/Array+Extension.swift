//
//  Array+Extension.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/07.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
