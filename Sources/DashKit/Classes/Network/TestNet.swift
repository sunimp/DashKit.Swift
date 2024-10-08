//
//  TestNet.swift
//
//  Created by Sun on 2019/3/6.
//

import Foundation

import BitcoinCore

class TestNet: INetwork {
    let protocolVersion: Int32 = 70214

    let bundleName = "Dash"

    let maxBlockSize: UInt32 = 1000000000
    let pubKeyHash: UInt8 = 0x8C
    let privateKey: UInt8 = 0x80
    let scriptHash: UInt8 = 0x13
    let bech32PrefixPattern = "bc"
    let xPubKey: UInt32 = 0x0488B21E
    let xPrivKey: UInt32 = 0x0488ADE4
    let magic: UInt32 = 0xCEE2CAFF
    let port = 19999
    let coinType: UInt32 = 1
    let sigHash: SigHashType = .bitcoinAll
    var syncableFromApi = true
    var blockchairChainID = ""

    let dnsSeeds = [
        "testnet-seed.dashdot.io",
        "test.dnsseed.masternode.io",
    ]

    let dustRelayTxFee = 1000 // https://github.com/dashpay/dash/blob/master/src/policy/policy.h#L36
}
