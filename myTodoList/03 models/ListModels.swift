//
//  ListModels.swift
//  myTodoList
//
//  Created by Freeborn Ehirhere on 08/09/2026.
//

import SwiftUI


struct ListModel: Codable, Identifiable {
    let id: UUID
    let title: String
    var isCompleted: Bool
}
