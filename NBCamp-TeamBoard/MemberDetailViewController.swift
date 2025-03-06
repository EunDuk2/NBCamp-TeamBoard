//
//  DetailViewController.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/5/25.
//

import UIKit
import PinLayout

class MemberDetailViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var viewModel: MemberViewModel
    
    init(viewModel: MemberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.view.addSubview(nameLabel)
        nameLabel.text = viewModel.member.name
    }
    
    override func viewDidLayoutSubviews() {
        nameLabel.pin.center().sizeToFit()
    }

}
