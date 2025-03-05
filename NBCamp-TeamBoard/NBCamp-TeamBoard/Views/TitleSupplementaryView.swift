//
//  TitleSupplementaryView.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/4/25.
//


import UIKit
import PinLayout

class TitleSupplementaryView: UICollectionReusableView {
    
    static let reuseIdentifier = "TitleSupplementaryView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.pin.all()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 외부에서 제목을 설정할 메서드
    func configure(_ text: String) {
        titleLabel.text = text
    }
}
