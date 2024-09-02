//
//  QorumMasternode.swift
//
//  Created by Sun on 2019/4/12.
//

import Foundation

// MARK: - QuorumMasternode

class QuorumMasternode {
    // MARK: Properties

    let quorumHash: Data
    let masternode: Masternode

    // MARK: Lifecycle

    init(quorumHash: Data, masternode: Masternode) {
        self.quorumHash = quorumHash
        self.masternode = masternode
    }
}

// MARK: Hashable, Comparable

extension QuorumMasternode: Hashable, Comparable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(quorumHash)
    }

    public static func == (lhs: QuorumMasternode, rhs: QuorumMasternode) -> Bool {
        lhs.quorumHash == rhs.quorumHash
    }

    public static func < (lhs: QuorumMasternode, rhs: QuorumMasternode) -> Bool {
        lhs.quorumHash < rhs.quorumHash
    }
}
