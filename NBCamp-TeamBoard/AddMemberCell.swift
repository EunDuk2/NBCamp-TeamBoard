//
//  AddMemberCell.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/4/25.
//


import UIKit
import PinLayout

class AddMemberCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AddMemberCell"
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.text = "+"
        label.textColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(plusLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusLabel.pin.all()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
