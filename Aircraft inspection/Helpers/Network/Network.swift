//
//  Network.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 15.04.2024.
//

import Foundation

class Network: NetworkProtocol {
    
    func requestUsagePolicy(completion: @escaping (URLRequest) -> Void) {
        let stringUrl = URL(string: "https://ya.ru/?npr=1")
        guard let url = stringUrl else { return }
            let request = URLRequest(url: url)
            completion(request)
    }
    func requestSupport(completion: @escaping (URLRequest) -> Void) {
        let stringUrl = URL(string: "https://ya.ru/?npr=1")
        guard let url = stringUrl else { return }
            let request = URLRequest(url: url)
            completion(request)
    }
}
