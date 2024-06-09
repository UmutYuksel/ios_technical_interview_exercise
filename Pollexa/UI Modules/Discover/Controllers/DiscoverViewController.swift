//
//  DiscoverViewController.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit

class DiscoverViewController: UIViewController {

    

    @IBOutlet weak var activePollsLabel: UILabel!
    @IBOutlet weak var pollsCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let postProvider = PostProvider.shared
    private let viewModel = DiscoverViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        viewModel.fetchPosts(collectionView: pollsCollectionView)
        viewModel.activatePollsButton(label: activePollsLabel)
       
    }
    
    func setupCollectionView() {
        pollsCollectionView.delegate = self
        pollsCollectionView.dataSource = self
    }
}

extension DiscoverViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PollCollectionViewCell", for: indexPath) as! PollsCollectionViewCell
        let posts = viewModel.posts[indexPath.row]
        cell.configure(with: posts)
        return cell
    }
    
    
    
}
