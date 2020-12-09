//
//  GameResult+CoreDataProperties.swift
//  JU Quiz
//
//  Created by Victor Svanqvist on 2020-12-09.
//
//

import Foundation
import CoreData


extension GameResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameResult> {
        return NSFetchRequest<GameResult>(entityName: "GameResult")
    }

    @NSManaged public var date: Date?
    @NSManaged public var numberOfQuestions: Int32
    @NSManaged public var rightAnswers: Int32
    @NSManaged public var difficulty: String?

}

extension GameResult : Identifiable {

}
