//
//  GameView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import SwiftUI

// MARK: - View

/// The main user interface for the Bulls and Cows game.
struct GameView: View {
    
    // MARK: - Stored properties
    
    /// The ViewModel that provides data and logic for this view.
    @State private var viewModel = GameViewModel()
    
    // MARK: - Computed properties
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Instructions and Feedback
                Text(viewModel.feedbackMessage)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(10)
                
                // Input Section
                HStack {
                    TextField("Enter 4 digits", text: $viewModel.currentGuess)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .disabled(viewModel.isGameOver)
                    
                    Button("Guess") {
                        viewModel.submitGuess()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.currentGuess.count != 4 || viewModel.isGameOver)
                }
                .padding(.horizontal)
                
                // History List
                List {
                    Section("Guess History") {
                        if viewModel.guessHistory.isEmpty {
                            ContentUnavailableView("No Guesses Yet", systemImage: "number.square", description: Text("Start guessing to see your results here."))
                        } else {
                            ForEach(viewModel.guessHistory) { result in
                                HistoryRowView(result: result)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Bulls and Cows")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("New Game") {
                        viewModel.resetGame()
                    }
                }
            }
        }
    }
}

// MARK: - Custom Subview

/// A reusable view that displays a single row in the guess history.
struct HistoryRowView: View {
    let result: GuessResult
    
    var body: some View {
        HStack {
            Text(result.guess)
                .font(.headline)
                .monospaced()
            
            Spacer()
            
            HStack(spacing: 15) {
                Label("\(result.bulls)", systemImage: "target")
                    .foregroundStyle(.green)
                
                Label("\(result.cows)", systemImage: "shield.fill")
                    .foregroundStyle(.orange)
            }
        }
    }
}

#Preview {
    GameView()
}
