//
//  File.swift
//  Pollexa
//
//  Created by Umut Yüksel on 7.06.2024.
//

import Foundation

protocol DiscoverViewModelDelegate : AnyObject {
    func didUpdatePost()
}

final class DiscoverViewModel {
    
    private let postProvider = PostProvider.shared
    
    weak var delegate : DiscoverViewModelDelegate?
    
    private var posts : [Post] = [] {
        didSet {
            delegate?.didUpdatePost()
        }
    }
    
    func fetchPosts() {
        postProvider.fetchAll { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedPosts):
                self.posts = fetchedPosts
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
