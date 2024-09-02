//
//  Outpoint.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

class Outpoint {
    // MARK: Properties

    let txHash: Data
    let vout: UInt32

    // MARK: Lifecycle

    init(txHash: Data, vout: UInt32) {
        self.txHash = txHash
        self.vout = vout
    }

    init(byteStream: ByteStream) {
        txHash = byteStream.read(Data.self, count: 32)
        vout = byteStream.read(UInt32.self)
    }
}
