//
//  X11Hasher.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore
import X11Kit

class X11Hasher: IDashHasher, IHasher {
    func hash(data: Data) -> Data {
        X11Kit.x11(data)
    }
}
