//
//  TeamCell.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/3/25.
//

import UIKit
import PinLayout

class TeamCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TeamCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(teamNameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        teamNameLabel.pin.left(20).bottom(20).sizeToFit()
        imageView.pin.all()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with team: TeamEntity) {
        teamNameLabel.text = team.name
        guard let data = team.image, let image = UIImage(data: data) else { return }
        imageView.image = image
    }
}
