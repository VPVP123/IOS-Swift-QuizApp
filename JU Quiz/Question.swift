//
//  Question.swift
//  JU Quiz
//
//  Created by Victor Svanqvist on 2020-12-05.
//

import Foundation

struct Question {
    
    enum QuestionType: String {
        case multiple
    }
    
    enum Difficulty: String {
        case easy, medium, hard
    }
    
    let category: String
    let type: QuestionType
    let difficulty: Difficulty
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    
}