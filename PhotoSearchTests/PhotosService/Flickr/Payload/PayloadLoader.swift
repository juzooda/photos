//
//  PayloadLoader.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation

struct PayloadLoader {
    static func open(payloadName: String, ofType type: String) -> Data {
        let filePath = Bundle(for: URLSessionProtocolMock.self).path(forResource: payloadName, ofType: type)!
        return try! Data(contentsOf: URL(fileURLWithPath: filePath))
    }
}
