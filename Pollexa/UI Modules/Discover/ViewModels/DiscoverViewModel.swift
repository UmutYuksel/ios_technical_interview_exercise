//
//  File.swift
//  Pollexa
//
//  Created by Umut Yüksel on 7.06.2024.
//

import Foundation
import UIKit

protocol DiscoverViewModelDelegate : AnyObject {
    func didUpdatePost()
}

final class DiscoverViewModel {
    
    private let postProvider = PostProvider.shared
    
    weak var delegate : DiscoverViewModelDelegate?
    
    var posts : [Post] = [] {
        didSet {
            delegate?.didUpdatePost()
        }
    }
    
    func fetchPosts(collectionView: UICollectionView) {
        postProvider.fetchAll { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedPosts):
                self.posts = fetchedPosts
                print(posts)
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func activatePollsButton(label : UILabel) {
        label.text = "\(posts.count) Active Polls"
    }
}
