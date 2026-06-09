//
//  GameViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import Foundation
import Observation

// MARK: - ViewModel

/// The ViewModel manages the state of the Bulls and Cows game and provides data to the View.
/// It uses the @Observable macro to automatically notify the View when data changes.
@Observable
class GameViewModel {
    
    // MARK: - Stored properties
    
    /// The underlying game logic (Model).
    private var game: BullsAndCowsGame
    
    /// The current guess being typed by the player in the text field.
    var currentGuess: String = ""
    
    /// A list of all previous guesses and their results.
    var guessHistory: [GuessResult] = []
    
    /// Indicates if the player has won the game.
    var isGameOver: Bool = false
    
    /// Feedback message to show to the user (e.g., errors or victory messages).
    var feedbackMessage: String = "Enter a 4-digit number with unique digits."
    
    // MARK: - Initializer
    
    /// Initializes a new ViewModel with a fresh game.
    init() {
        self.game = BullsAndCowsGame()
    }
    
    // MARK: - Functions
    
    /// Resets the game to start over.
    func resetGame() {
        self.game = BullsAndCowsGame()
        self.currentGuess = ""
        self.guessHistory = []
        self.isGameOver = false
        self.feedbackMessage = "New game started! Good luck."
    }
    
    /// Submits the current guess and evaluates it.
    func submitGuess() {
        // Validation: Ensure the guess is exactly 4 digits
        if currentGuess.count != 4 {
            feedbackMessage = "Error: Guess must be exactly 4 digits."
            return
        }
        
        // Validation: Ensure all digits are unique
        if hasDuplicateDigits(currentGuess) {
            feedbackMessage = "Error: Digits must be unique (no repeats)."
            return
        }
        
        // Evaluate the guess using the Model
        let result = game.checkGuess(currentGuess)
        
        // Add the result to the history (at the top)
        guessHistory.insert(result, at: 0)
        
        // Check for victory (4 Bulls means the player won)
        if result.bulls == 4 {
            isGameOver = true
            feedbackMessage = "Congratulations! You found the secret code: \(game.secretCode)"
        } else {
            feedbackMessage = "Keep trying!"
        }
        
        // Clear the input field for the next guess
        currentGuess = ""
    }
    
    /// Helper function to check for duplicate digits in a string.
    private func hasDuplicateDigits(_ input: String) -> Bool {
        let characters = Array(input)
        for i in 0..<characters.count {
            for j in (i + 1)..<characters.count {
                if characters[i] == characters[j] {
                    return true
                }
            }
        }
        return false
    }
}
