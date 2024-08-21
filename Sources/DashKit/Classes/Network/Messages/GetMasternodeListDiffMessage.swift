//
//  GetMasternodeListDiffMessage.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

struct GetMasternodeListDiffMessage: IMessage { // "getmnlistd"
    let baseBlockHash: Data
    let blockHash: Data

    var description: String {
        "\(baseBlockHash) \(blockHash)"
    }
}
