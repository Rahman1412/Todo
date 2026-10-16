//
//  ContentView.swift
//  Todo
//
//  Created by Rahman on 16/10/26.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = TodoViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("My Tasks")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text(
                        "\(viewModel.completedCount) of \(viewModel.tasks.count) completed"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                HStack {
                    TextField("Enter a new task", text: $viewModel.newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    viewModel.errorMessage.isEmpty
                                        ? Color.gray.opacity(0.4)
                                        : Color.red,
                                    lineWidth: 1
                                )
                        }
                        .onSubmit {
                            viewModel.addTask()
                        }
                    Button {
                        viewModel.addTask()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                Spacer(minLength: 15)
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Button {
                                viewModel.toggleTask(task)
                            } label: {
                                Image(
                                    systemName: task.isCompleted
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                )
                                .font(.title2)
                                .foregroundStyle(
                                    task.isCompleted
                                        ? .green
                                        : .secondary
                                )
                            }
                            .buttonStyle(.plain)

                            Text(task.title).strikethrough(
                                task.isCompleted
                            ).foregroundStyle(
                                task.isCompleted
                                    ? .secondary
                                    : .primary
                            )
                            Spacer()
                        }
                    }.onDelete(perform: viewModel.deleteTask)
                }

            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            ).padding()
        }
    }
}

#Preview {
    ContentView()
}
