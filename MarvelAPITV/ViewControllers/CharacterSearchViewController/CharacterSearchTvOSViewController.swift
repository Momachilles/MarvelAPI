//
//  CharacterSearchTvOSViewController.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 05/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class CharacterSearchTvOSViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var exactSegmentedControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.layer.cornerRadius = 10.0
        }
    }
    
    // MARK: - Variables
    let viewModel = CharacterSearchTvOSViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    // MARK: - Setup
    private func setupBindings() {
        viewModel.searchButtonSignal <~ searchButton.reactive.controlEvents(.primaryActionTriggered).map { _ in self.searchTextField.text }
        
        viewModel.searchTextType <~ exactSegmentedControl.reactive.controlEvents(.valueChanged)
            .map { $0.selectedSegmentIndex }
            .map {
                switch $0 {
                case 0:
                    return .exact
                case 1:
                    return .startsWith
                default:
                    return .exact
                }
            }
    }

}
