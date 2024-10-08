//
//  MasternodeParser.swift
//
//  Created by Sun on 2019/4/12.
//

import Foundation

import BitcoinCore

class MasternodeParser: IMasternodeParser {
    // MARK: Properties

    let hasher: IDashHasher

    // MARK: Lifecycle

    init(hasher: IDashHasher) {
        self.hasher = hasher
    }

    // MARK: Functions

    func parse(byteStream: ByteStream) -> Masternode {
        let nVersion = byteStream.read(UInt16.self)
        let proRegTxHash = byteStream.read(Data.self, count: 32)
        let confirmedHash = byteStream.read(Data.self, count: 32)
        let ipAddress = byteStream.read(Data.self, count: 16)
        let port = byteStream.read(UInt16.self)
        let pubKeyOperator = byteStream.read(Data.self, count: 48)
        let keyIDVoting = byteStream.read(Data.self, count: 20)
        let isValid = byteStream.read(UInt8.self) != 0
        var type: UInt16?
        var platformHTTPPort: UInt16?
        var platformNodeID: Data?
        if nVersion >= 2 {
            let typeInt = byteStream.read(UInt16.self)
            type = typeInt
            if typeInt == 1 {
                platformHTTPPort = byteStream.read(UInt16.self)
                platformNodeID = byteStream.read(Data.self, count: 20)
            }
        }

        let confirmedHashWithProRegTxHash = hasher.hash(data: proRegTxHash + confirmedHash)

        return Masternode(
            nVersion: nVersion,
            proRegTxHash: proRegTxHash,
            confirmedHash: confirmedHash,
            confirmedHashWithProRegTxHash: confirmedHashWithProRegTxHash,
            ipAddress: ipAddress,
            port: port,
            pubKeyOperator: pubKeyOperator,
            keyIDVoting: keyIDVoting,
            isValid: isValid,
            type: type,
            platformHTTPPort: platformHTTPPort,
            platformNodeID: platformNodeID
        )
    }
}
