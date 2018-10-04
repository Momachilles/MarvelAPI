//
//  ComicCollectionViewCell.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 04/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Variables
    lazy var viewModel = ComicCollectionViewCellModel()
    
    
    // MARK: - Init
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBinding()
    }
    
    // MARK: - Setup
    func configureCell(comic: Comic) {
        viewModel.comic.value = comic
    }
    
    private func setupBinding() {
        //nameLabel.reactive.text <~ viewModel.title
        viewModel.title.signal.observeValues { [weak self] name in self?.nameLabel.text = name }
        viewModel.thumbnailImageURL.signal.observeValues { [weak self] url in
            DispatchQueue.global(qos: DispatchQoS.default.qosClass).async {
                if let url = url {
                    do {
                        let data = try Data(contentsOf: url)
                        DispatchQueue.main.async {
                            let img = UIImage(data: data)
                            self?.thumbnailImage.image = img
                        }
                    } catch {
                        print("ERROR: \(error)")
                    }
                }
            }
        }
    }
    
}
