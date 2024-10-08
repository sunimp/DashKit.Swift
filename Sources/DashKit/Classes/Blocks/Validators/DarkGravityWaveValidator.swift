//
//  DarkGravityWaveValidator.swift
//
//  Created by Sun on 2019/4/15.
//

import Foundation

import BigInt
import BitcoinCore

class DarkGravityWaveValidator: IBlockChainedValidator {
    // MARK: Properties

    private let difficultyEncoder: IDashDifficultyEncoder
    private let blockHelper: IDashBlockValidatorHelper

    private let heightInterval: Int
    private let targetTimeSpan: Int
    private let maxTargetBits: Int
    private let powDGWHeight: Int

    // MARK: Lifecycle

    init(
        encoder: IDashDifficultyEncoder,
        blockHelper: IDashBlockValidatorHelper,
        heightInterval: Int,
        targetTimeSpan: Int,
        maxTargetBits: Int,
        powDGWHeight: Int
    ) {
        difficultyEncoder = encoder
        self.blockHelper = blockHelper

        self.heightInterval = heightInterval
        self.targetTimeSpan = targetTimeSpan
        self.maxTargetBits = maxTargetBits
        self.powDGWHeight = powDGWHeight
    }

    // MARK: Functions

    func validate(block: Block, previousBlock: Block) throws {
        let blockTarget = difficultyEncoder.decodeCompact(bits: previousBlock.bits)

        var actualTimeSpan = 0
        var avgTargets = blockTarget
        var prevBlock: Block? = blockHelper.previous(for: previousBlock, count: 1)

        for blockCount in 2 ... heightInterval {
            guard let currentBlock = prevBlock else {
                throw BitcoinCoreErrors.BlockValidation.noPreviousBlock
            }
            let currentTarget = difficultyEncoder.decodeCompact(bits: currentBlock.bits)
            avgTargets = (avgTargets * BigInt(blockCount) + currentTarget) / BigInt(blockCount + 1)

            if blockCount < heightInterval {
                prevBlock = blockHelper.previous(for: currentBlock, count: 1)
            } else {
                actualTimeSpan = previousBlock.timestamp - currentBlock.timestamp
            }
        }
        var darkTarget = avgTargets
        if actualTimeSpan < targetTimeSpan / 3 {
            actualTimeSpan = targetTimeSpan / 3
        } else if actualTimeSpan > targetTimeSpan * 3 {
            actualTimeSpan = targetTimeSpan * 3
        }

        darkTarget = darkTarget * BigInt(actualTimeSpan) / BigInt(targetTimeSpan)
        let compact = min(maxTargetBits, difficultyEncoder.encodeCompact(from: darkTarget))

        if compact != block.bits {
            throw BitcoinCoreErrors.BlockValidation.notEqualBits
        }
    }

    func isBlockValidatable(block: Block, previousBlock _: Block) -> Bool {
        block.height >= powDGWHeight
    }
}
