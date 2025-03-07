//
//  AddTeamCell.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/5/25.
//

import UIKit
import PinLayout

class AddTeamCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AddTeamCell"
    
    private let rootContainerView = UIView()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.text = "+"
        label.textColor = .white
        return label
    }()
    
    private let addTeamTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.text = "팀을 추가해주세요"
        label.textColor = .white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setFlexLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootContainerView.pin.all()
        rootContainerView.flex.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFlexLayout() {
        contentView.addSubview(rootContainerView)
        rootContainerView.flex
            .direction(.column)
            .alignItems(.center)
            .justifyContent(.center)
            .cornerRadius(12)
            .backgroundColor(.lightGray)
            .border(1, .black)
            .define { flex in
                flex.addItem(plusLabel)
                flex.addItem(addTeamTitleLabel)
                    .marginTop(8)
            }
        
    }
}
