//
//  QuorumMasternode.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

// MARK: - QuorumMasternode

class QuorumMasternode {
    let quorumHash: Data
    let masternode: Masternode

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
