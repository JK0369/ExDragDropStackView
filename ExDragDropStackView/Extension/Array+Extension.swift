//
//  Array+Extension.swift
//  ExDragDropStackView
//
//  Created by 김종권 on 2023/07/12.
//

import Foundation
extension Array {
    subscript (safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
