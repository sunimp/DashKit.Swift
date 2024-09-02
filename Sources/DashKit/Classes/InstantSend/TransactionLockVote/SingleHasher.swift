//
//  SingleHasher.swift
//
//  Created by Sun on 2019/4/12.
//

import Foundation

import BitcoinCore
import WWCryptoKit

class SingleHasher: IDashHasher {
    func hash(data: Data) -> Data {
        Crypto.sha256(data)
    }
}
