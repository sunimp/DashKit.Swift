//
//  SingleHasher.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore
import WWCryptoKit

class SingleHasher: IDashHasher {
    func hash(data: Data) -> Data {
        Crypto.sha256(data)
    }
}
