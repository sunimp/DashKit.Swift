//
//  TransactionLockVoteMessageParser.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore
import WWCryptoKit
import WWExtensions

class TransactionLockVoteMessageParser: IMessageParser {
    var id: String { "txlvote" }

    func parse(data: Data) -> IMessage {
        let byteStream = ByteStream(data)

        let txHash = byteStream.read(Data.self, count: 32)
        let outpoint = Outpoint(byteStream: byteStream)
        let outpointMasternode = Outpoint(byteStream: byteStream)
        let quorumModifierHash = byteStream.read(Data.self, count: 32)
        let masternodeProTxHash = byteStream.read(Data.self, count: 32)
        let signatureLength = byteStream.read(VarInt.self)
        let vchMasternodeSignature = byteStream.read(Data.self, count: Int(signatureLength.underlyingValue))

        let hash = Crypto.doubleSha256(data.prefix(168))

        return TransactionLockVoteMessage(
            txHash: txHash,
            outpoint: outpoint,
            outpointMasternode: outpointMasternode,
            quorumModifierHash: quorumModifierHash,
            masternodeProTxHash: masternodeProTxHash,
            vchMasternodeSignature: vchMasternodeSignature,
            hash: hash
        )
    }
}
