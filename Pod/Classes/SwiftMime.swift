//
//  SwiftMime.swift
//  SwiftMime
//
//  Created by di wu on 1/12/15.
//
//  License
//  Copyright (c) 2015 Di Wu
//  Released under an MIT license: http://opensource.org/licenses/MIT

import Foundation

public class SwiftMime {

    public static let sharedManager = SwiftMime()

    private var typeForExtension = [String: String]()
    private var extensionForType = [String: String]()

    private init() {
        loadTypesFile("mime")
        loadTypesFile("node")
    }

    public func define(extensionsForType: [String: [String]]) {
        for (type, extensions) in extensionsForType {
            for ext in extensions {
                typeForExtension[ext] = type
            }
            extensionForType[type] = extensions[0]
        }
    }

    private func loadTypesFile(filePath: String) {
        let path =  NSBundle(forClass: object_getClass(self)).pathForResource(filePath, ofType: "types")
        guard let content = try? NSString(contentsOfFile:path!, encoding: NSUTF8StringEncoding) else { return }

        var extensionsForType = [String: [String]]()
        let lines = content.componentsSeparatedByString("\n")
        for line in lines {
            if line.hasPrefix("#") {
                continue
            }
            let fields = line.stringByReplacingOccurrencesOfString("\\s+", withString: " ", options: .RegularExpressionSearch).componentsSeparatedByString(" ")
            if let type = fields.first where !type.isEmpty && fields.count > 1 {
                extensionsForType[type] = Array(fields[1 ..< fields.count])
            }
        }
        define(extensionsForType)
    }

    public func lookupType(path: String) -> String? {
        let newPath = path.stringByReplacingOccurrencesOfString(".*[\\.\\/\\\\]", withString: "", options: .RegularExpressionSearch)
        let ext = newPath.lowercaseString
        return typeForExtension[ext]
    }

    public func lookupExtension(mimeType: String) -> String? {
        return extensionForType[mimeType]
    }
}
