//
//  ObjCInterfaceFileGenerator.swift
//  PINModel
//
//  Created by Rahul Malik on 7/29/15.
//  Copyright © 2015 Rahul Malik. All rights reserved.
//

import Foundation


class ObjectiveCInterfaceFileDescriptor : FileGenerator {
    let objectDescriptor : ObjectSchemaObjectProperty
    let className : String
    let builderClassName : String
    let generationParameters : GenerationParameters

    required init(descriptor: ObjectSchemaObjectProperty, generatorParameters : GenerationParameters) {
        self.objectDescriptor = descriptor
        if let classPrefix = generatorParameters[GenerationParameterType.ClassPrefix] as String? {
            self.className = String(format: "%@%@", arguments: [
                classPrefix,
                self.objectDescriptor.name.snakeCaseToCamelCase()
                ])
        } else {
            self.className = self.objectDescriptor.name.snakeCaseToCamelCase()
        }
        self.builderClassName = "\(self.className)Builder"
        self.generationParameters = generatorParameters
    }

    func fileName() -> String {
        return "\(self.className).h"
    }


    func renderBuilderInterface() -> String {
        let propertyLines = self.objectDescriptor.properties.map { (property : ObjectSchemaProperty) -> String in
            return ObjectiveCProperty(descriptor: property).renderImplementationDeclaration()
        }

        let lines = [
            "@interface \(self.builderClassName) : NSObject",
            propertyLines.joinWithSeparator("\n"),
            "- (instancetype)initWith\(self.className):(\(self.className) *)modelObject;",
            "- (\(self.className) *)build;", // - (Model *)build;
            "@end"
        ]

        return lines.joinWithSeparator("\n\n")
    }

    func renderBuilderBlockType() -> String {
        return "typedef void (^\(self.builderClassName)Block)(\(self.builderClassName) *builder);"
    }

    func renderInterface() -> String {
        let propertyLines : [String] = self.objectDescriptor.properties.map { (property : ObjectSchemaProperty) -> String in
            return ObjectiveCProperty(descriptor: property).renderInterfaceDeclaration()
        }

        let implementedProtocols = ["NSCopying", "NSSecureCoding"].joinWithSeparator(", ")
        let lines = [
            "@interface \(self.className) : NSObject<\(implementedProtocols)>",
            propertyLines.joinWithSeparator("\n"),
            "+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;",
            "- (instancetype)initWithDictionary:(NSDictionary *)modelDictionary NS_DESIGNATED_INITIALIZER;",
            "- (instancetype)initWithBuilder:(\(self.builderClassName) *)builder NS_DESIGNATED_INITIALIZER;",
            "- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;",
            "- (instancetype)copyWithBlock:(\(self.builderClassName)Block)block;",
            "@end",
        ]

        return lines.joinWithSeparator("\n\n")
    }

    func renderForwardDeclarations() -> String {
        let referencedForwardDeclarations : [String] = self.objectDescriptor.referencedClasses.flatMap ({ (prop: ObjectSchemaPointerProperty) -> String? in
            if prop.objectiveCStringForJSONType() == self.className {
                return nil
            }
            return "@class \(prop.objectiveCStringForJSONType());"
        })
        var forwardDeclarations = ["@class \(self.builderClassName);"]
        forwardDeclarations.appendContentsOf(referencedForwardDeclarations)
        return forwardDeclarations.sort().joinWithSeparator("\n")
    }

    func renderFile() -> String {
        let lines = [
            self.renderCommentHeader(),
            "@import Foundation;",
            "#import \"CBLDefines.h\"", // HACK: Allow generics support with XCode 6/7 compatability
            self.renderForwardDeclarations(),
            "NS_ASSUME_NONNULL_BEGIN",
            self.renderBuilderBlockType(),
            self.renderInterface(),
            self.renderBuilderInterface(),
            "NS_ASSUME_NONNULL_END",
            "" // Newline at the end of file.
        ]
        return lines.joinWithSeparator("\n\n")
    }
}
