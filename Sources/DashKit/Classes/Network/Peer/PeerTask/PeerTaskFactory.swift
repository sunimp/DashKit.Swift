//
//  PeerTaskFactory.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

class PeerTaskFactory: IPeerTaskFactory {
    func createRequestMasternodeListDiffTask(baseBlockHash: Data, blockHash: Data) -> PeerTask {
        RequestMasternodeListDiffTask(baseBlockHash: baseBlockHash, blockHash: blockHash)
    }
}
