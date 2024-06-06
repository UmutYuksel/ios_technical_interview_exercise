//
//  DiscoverViewController.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit

class DiscoverViewController: UIViewController {

    
    @IBOutlet weak var pollsCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let postProvider = PostProvider.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        postProvider.fetchAll { result in
            switch result {
            case .success(let posts):
                print(posts)
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func setupCollectionView() {
        pollsCollectionView.delegate = self
        pollsCollectionView.dataSource = self
    }
}

extension DiscoverViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PollCollectionViewCell", for: indexPath) as! PollsCollectionViewCell
        return cell
    }
    
    
    
}
