//
//  CalendarManaging.swift
//  adhamovPW2
//
//  Created by Alibek Adhamov on 09/02/24.
//

import EventKit

protocol CalendarManaging {
 func create(eventModel: CalendarEventModel) -> Bool
}
