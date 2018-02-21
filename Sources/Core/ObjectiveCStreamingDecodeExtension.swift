//
//  ObjectiveCStreamingDecodeExtension.swift
//  Core
//
//  Created by Adlai on 2/20/18.
//

import Foundation

extension ObjCModelRenderer {

    public func renderInitWithStreamingDecoder() -> ObjCIR.Method {
        func renderPropertyInit2(
            _ propertyToAssign: String,
            schema: Schema,
            firstName: String
            ) -> [String] {
            switch schema {
            case .string(format: .some(.uri)):
                return ["\(propertyToAssign) = [NSURL URLWithString:[decoder decodeObjectOfClass:[NSString class]]];"]
            case .string(format: .some(.dateTime)):
                return ["\(propertyToAssign) = [[NSValueTransformer valueTransformerForName:\(dateValueTransformerKey)] transformedValue:[decoder decodeObjectOfClass:[NSString class]]];"]
            case .string(format: .none):
                return ["\(propertyToAssign) = [decoder decodeObjectOfClass:[NSString class]];"]
            case .integer, .enumT(.integer):
                return [ "\(propertyToAssign) = [decoder decodeInteger];" ]
            case .boolean:
                return [ "\(propertyToAssign) = [decoder decodeBOOL];" ]
            case .float:
                return [ "\(propertyToAssign) = [unpackder decodeDouble];" ]
            case let .map(valueType: valueType):
                return [ "\(propertyToAssign) = [decoder decodeDictionaryWithKeyClass:[NSString class] objectClass:\(valueType?.objcClassInstance(with: params) ?? "Nil")];" ]
            case let .array(itemType: itemType):
                return [ "\(propertyToAssign) = [decoder decodeArrayOfClass:\(itemType?.objcClassInstance(with: params) ?? "Nil")];" ]
            case let .set(itemType: itemType):
                return [ "\(propertyToAssign) = [decoder decodeSetOfClass:\(itemType?.objcClassInstance(with: params) ?? "Nil")];" ]
            case let .object(objectRoot):
                return [ "\(propertyToAssign) = [decoder decodeObjectOfClass:[\(objectRoot.className(with: params)) class]];" ]
            case .enumT(.string):
                return ["\(propertyToAssign) = \(enumFromStringMethodName(propertyName: firstName, className: className))([decoder decodeObjectOfClass:[NSString class]]);"]
            case let .reference(with: ref):
                return ref.force().map {
                    renderPropertyInit2(propertyToAssign, schema: $0, firstName: firstName)
                    } ?? {
                        assert(false, "TODO: Forward optional across methods")
                        return []
                    }()
            default:
                return ["Unhandled: \(schema.debugDescription)"]
            }
        }

        return ObjCIR.method("- (nullable instancetype)initWithStreamingDecoder:(id<PINStreamingDecoder>)decoder") {
            return [
                "NSParameterAssert(decoder != nil);",
                ObjCIR.ifStmt("!decoder") { ["return nil;"] },
                self.isBaseClass ? ObjCIR.ifStmt("!(self = [super init])") { ["return self;"] } :
                "if (!(self = [super initWithStreamingDecoder:decoder])) { return self; }",
                "[decoder enumerateKeysInMapWithBlock:^(const char *key, NSUInteger keyLen) {",
                    -->[ObjCIR.switchStmt("keyLen") { () -> [ObjCIR.SwitchCase] in
                        let keysByLen: [Int: [(Parameter, SchemaObjectProperty)]] = self.properties.reduce([:]) { resultArg, pair in
                            var result = resultArg
                            let len = pair.0.count
                            let oldArray = result[len] ?? []
                            result[len] = oldArray + [pair]
                            return result
                        }
                        return keysByLen.map { (arg) -> ObjCIR.SwitchCase in
                            let (len, props) = arg
                            return .caseStmt(condition: String(len)) { () -> [String] in
                                props.enumerated().map { arg -> String in
                                    let (i, (name, property)) = arg
                                    let cond = "!strncmp(key, \"\(name)\", keyLen)"
                                    let body: () -> [String] = {
                                        renderPropertyInit2("_\(name.snakeCaseToPropertyName())", schema: property.schema, firstName: name) + [
                                            "_\(self.dirtyPropertiesIVarName).\(dirtyPropertyOption(propertyName: name, className: self.className)) = 1;"
                                        ]
                                    }
                                    if i == 0 {
                                        return ObjCIR.ifStmt(cond, body: body)
                                    } else {
                                        return ObjCIR.elseIfStmt(cond, body)
                                    }
                                }
                            }
                            } +
                            [ ObjCIR.SwitchCase.caseStmt(condition: "0") {[
                                "self = nil; return nil;"
                                ]}
                        ]
                    }
                        ],
                    "}];",
                "return self;"
            ]
        }
    }
}
