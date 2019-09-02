//
//  SwiftNameIdentifier.swift
//  HorizontalImageViewer
//
//  Created by tskim on 03/09/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

protocol SwiftNameIdentifier {
    static var swiftIdentifier: String { get }
}
extension SwiftNameIdentifier {
    static var swiftIdentifier: String {
        return String(describing: Self.self)
    }
}
