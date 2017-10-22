//
//  Success.swift
//  Stack Chat
//
//  Created by Aadit Kapoor on 9/28/17.
//  Copyright © 2017 Aadit Kapoor. All rights reserved.
//

import Foundation

/**
 SuccessMessages enum provide certain predefined success messages that may be used in the program execution.
 - note: This was absolutely a personal choice.
 */
enum SuccessMessages: String {
    typealias RawValue = String

    case parsedSuccess = "Parsed Successfully!"
    case fetchedAnswer = "Fetched Answer!"
    case URLFound = "Url is okay!"
}
