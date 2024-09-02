//
//  MasternodeListDiffMessage.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

struct MasternodeListDiffMessage: IMessage {
    // MARK: Properties

    let baseBlockHash: Data
    let blockHash: Data
    let totalTransactions: UInt32
    let merkleHashesCount: UInt32
    let merkleHashes: [Data]
    let merkleFlagsCount: UInt32
    let merkleFlags: Data
    let cbTx: CoinbaseTransaction
    let nVersion: UInt16
    let deletedMNsCount: UInt32
    let deletedMNs: [Data]
    let mnListCount: UInt32
    let mnList: [Masternode]
    let deletedQuorums: [(type: UInt8, quorumHash: Data)]
    let quorumList: [Quorum]

    // MARK: Computed Properties

    var description: String {
        "\(baseBlockHash) \(blockHash)"
    }
}
