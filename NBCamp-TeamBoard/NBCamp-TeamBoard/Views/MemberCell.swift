//
//  MemberCell.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/3/25.
//

import UIKit
import FlexLayout
import PinLayout

class MemberCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MemberCell"
    
    private let rootContainerView = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let roleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
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
            .cornerRadius(12)
            .border(1, .black)
            .define { flex in
                flex.addItem(imageView)
                    .width(100%)
                    .aspectRatio(1)
                flex.addItem(nameLabel)
                    .marginTop(8)
                flex.addItem(roleLabel)
                    .marginTop(2)
            }
    }
    
    func configure(with member: MemberEntity) {
        nameLabel.text = member.name
        roleLabel.text = member.role
    }
}
