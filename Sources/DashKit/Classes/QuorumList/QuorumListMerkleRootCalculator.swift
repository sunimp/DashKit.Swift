//
//  QuorumListMerkleRootCalculator.swift
//
//  Created by Sun on 2019/5/30.
//

import Foundation

import BitcoinCore

class QuorumListMerkleRootCalculator: IQuorumListMerkleRootCalculator {
    // MARK: Properties

    private let merkleRootCreator: IMerkleRootCreator

    // MARK: Lifecycle

    init(merkleRootCreator: IMerkleRootCreator, quorumHasher _: IDashHasher) {
        self.merkleRootCreator = merkleRootCreator
    }

    // MARK: Functions

    func calculateMerkleRoot(sortedQuorums: [Quorum]) -> Data? {
        merkleRootCreator.create(hashes: sortedQuorums.map(\.dataHash))
    }
}
