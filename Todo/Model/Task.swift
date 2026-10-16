//
//  Task.swift
//  Todo
//
//  Created by Rahman on 16/10/26.
//

import Foundation

struct Task : Identifiable{
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
