//
//  WishEventModel.swift
//  adhamovPW2
//
//  Created by Alibek Adhamov on 09/02/24.
//

import UIKit

class WishEventModel{
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date

    init(title: String, description: String, startDate: Date, endDate: Date) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
