//
//  PeerTaskFactory.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

class PeerTaskFactory: IPeerTaskFactory {
    func createRequestMasternodeListDiffTask(baseBlockHash: Data, blockHash: Data) -> PeerTask {
        RequestMasternodeListDiffTask(baseBlockHash: baseBlockHash, blockHash: blockHash)
    }
}
