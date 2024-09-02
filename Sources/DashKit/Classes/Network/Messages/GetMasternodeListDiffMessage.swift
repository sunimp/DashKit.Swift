//
//  GetMasternodeListDiffMessage.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

struct GetMasternodeListDiffMessage: IMessage {
    // MARK: Properties

    // "getmnlistd"
    let baseBlockHash: Data
    let blockHash: Data

    // MARK: Computed Properties

    var description: String {
        "\(baseBlockHash) \(blockHash)"
    }
}
