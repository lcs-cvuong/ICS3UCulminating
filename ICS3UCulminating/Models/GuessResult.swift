//
//  GuessResult.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026-06-02.
//

import Foundation

// MARK: - Model

/// Represents the result of a single guess in the Bulls and Cows game.
struct GuessResult: Identifiable {
    
    // MARK: - Stored properties
    
    /// Unique identifier for each guess result, used by SwiftUI to efficiently update lists.
    let id = UUID()
    
    /// The 4-digit number that the player guessed.
    let guess: String
    
    /// The number of "Bulls" (correct digit in the correct position).
    let bulls: Int
    
    /// The number of "Cows" (correct digit in the wrong position).
    let cows: Int
}
