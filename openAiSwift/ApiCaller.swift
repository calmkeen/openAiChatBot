//
//  ApiCaller.swift
//  openAiSwift
//
//  Created by calmkeen on 2022/12/24.
//

import UIKit
import OpenAISwift

final class ApiCaller {
    static let shared = ApiCaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func openAiKey() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(. failure(error))
            }
        })
        
    }
}
