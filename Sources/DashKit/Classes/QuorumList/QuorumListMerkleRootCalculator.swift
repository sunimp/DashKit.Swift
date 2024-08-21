//
//  QuorumListMerkleRootCalculator.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

class QuorumListMerkleRootCalculator: IQuorumListMerkleRootCalculator {
    private let merkleRootCreator: IMerkleRootCreator

    init(merkleRootCreator: IMerkleRootCreator, quorumHasher _: IDashHasher) {
        self.merkleRootCreator = merkleRootCreator
    }

    func calculateMerkleRoot(sortedQuorums: [Quorum]) -> Data? {
        merkleRootCreator.create(hashes: sortedQuorums.map(\.dataHash))
    }
}
