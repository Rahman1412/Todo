//
//  TodoViewModel.swift
//  Todo
//
//  Created by Rahman on 16/10/26.
//

import Combine
import Foundation
import SwiftUI

class TodoViewModel: ObservableObject {

    @Published var tasks: [Task] = [
        Task(title: "Learn Swift UI")
    ]

    @Published var newTaskTitle: String = ""
    @Published var errorMessage: String = ""

    func addTask() {
        let title = newTaskTitle.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !title.isEmpty else {
            errorMessage = "Task title is required"
            return
        }

        tasks.append(Task(title: title))

        newTaskTitle = ""
        errorMessage = ""
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleTask(_ task: Task) {
        guard
            let index = tasks.firstIndex(
                where: { $0.id == task.id }
            )
        else {
            return
        }

        print("Index =========== \(index)")

        tasks[index].isCompleted.toggle()
    }

    var completedCount: Int {
        tasks.filter { $0.isCompleted }.count
    }
}
