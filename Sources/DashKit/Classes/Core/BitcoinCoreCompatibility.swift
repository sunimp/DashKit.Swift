//
//  BitcoinCoreCompatibility.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

extension DifficultyEncoder: IDashDifficultyEncoder {}
extension BlockValidatorHelper: IDashBlockValidatorHelper {}
extension TransactionSizeCalculator: IDashTransactionSizeCalculator {}
extension TransactionSyncer: IDashTransactionSyncer {}

extension DoubleShaHasher: IDashHasher {}
