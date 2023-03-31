//
//  AnyViewModel.swift
//  RatioBarChart
//
//  Created by Keyvan on 3/31/23.
//

import Foundation

public protocol AnyViewModel: ObservableObject {
    associatedtype Inputs
    associatedtype Outputs
    var inputs: Inputs { get }
    var outputs: Outputs { get }
}
