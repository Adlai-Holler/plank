//
//  FileGenerator.swift
//  PINModel
//
//  Created by Rahul Malik on 7/23/15.
//  Copyright © 2015 Rahul Malik. All rights reserved.
//

import Foundation

typealias GenerationParameters = [GenerationParameterType:String]

let formatter = NSDateFormatter()
let date = NSDate()

public enum GenerationParameterType {
    case ClassPrefix
}

protocol FileGeneratorManager {
    init(descriptor: ObjectSchemaObjectProperty, generatorParameters: GenerationParameters, schemaLoader: SchemaLoader)
    func filesToGenerate() -> Array<FileGenerator>
}

protocol FileGenerator {
    init(descriptor: ObjectSchemaObjectProperty,
         generatorParameters: GenerationParameters,
         parentDescriptor: ObjectSchemaObjectProperty?,
         schemaLoader: SchemaLoader)
    func fileName() -> String
    func renderFile() -> String
}


extension FileGenerator {

    func renderCommentHeader() -> String {
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        formatter.timeZone = NSTimeZone(name: "UTC")
        formatter.dateFormat = "MM-dd-yyyy 'at' HH:mm:ss"

        let calendar = NSCalendar.currentCalendar()
        let year: Int = calendar.components(NSCalendarUnit.Year, fromDate: date).year

        let header = [
            "//",
            "//  \(self.fileName())",
            "//  Pinterest",
            "//",
            "//  DO NOT EDIT - EDITS WILL BE OVERWRITTEN",
            "//  Copyright (c) \(year) Pinterest, Inc. All rights reserved.",
            "//  @generated",
            "//"
        ]
        return header.joinWithSeparator("\n")
    }
}
