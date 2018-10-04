//
//  CharacterCollectionViewCell.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 03/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class CharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Variables
    lazy var viewModel = CharacterCollectionViewCellModel()
    
    
    // MARK: - Init
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBinding()
    }
    
    // MARK: - Setup
    func configureCell(character: ComicCharacter) {
        viewModel.character.value = character
    }
    
    private func setupBinding() {
        viewModel.title.signal.observeValues { [weak self] name in self?.nameLabel.text = name }
        viewModel.thumnailImageURL.signal.observeValues { [weak self] url in
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
