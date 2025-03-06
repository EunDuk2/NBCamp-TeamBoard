//
//  PartnerDetailView.swift
//  NBCamp-TeamBoard
//
//  Created by 유현진 on 3/6/25.
//

import UIKit
import PinLayout
import FlexLayout

final class PartnerDetailView: UIView {
    // Root FlexView
    private lazy var rootFlexView: UIView = {
        return UIView()
    }()
    
    private lazy var profileFlexView: UIView = {
        return UIView()
    }()
    
    private lazy var buttonFlexView: UIView = {
        return UIView()
    }()
    
    // 프로필 이미지
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile1"))
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 프로필 이름
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "조은성"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    // 소개 제목
    private lazy var introductionLabel: UILabel = {
        let label = UILabel()
        label.text = "소개"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var introductionText: UITextView = {
        let textView = UITextView()
        textView.text = "잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다."
        textView.font = .systemFont(ofSize: 20, weight: .bold)
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = 10 // 10pt 만큼 둥글게
        textView.clipsToBounds = true // 내부 콘텐츠가 모서리를 넘지 않도록
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return textView
    }()

    // 가로 스크롤을 위한 ScrollView & StackView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    lazy var marqueeFlexView: UIView = {
        return UIView()
    }()
    
    // Notion 버튼
    private lazy var notionImageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_notion")
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit // 버튼 크기에 맞게 이미지 조정
        return button
    }()
    // Github 버튼
    private lazy var githubImageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_github")
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit // 버튼 크기에 맞게 이미지 조정
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        rootFlexView.backgroundColor = .systemBackground
        profileFlexView.backgroundColor = .systemBackground
        
        addSubview(rootFlexView)
        scrollView.addSubview(marqueeFlexView)
        
        rootFlexView.flex.define { rootFlex in
            rootFlex.addItem(profileFlexView)
                .alignItems(.center)
                .padding(16)
                .define { profileFlex in
                    profileFlex.addItem(profileImageView)
                        .size(260)
                        .cornerRadius(15)
                    profileFlex.addItem(nameLabel)
                        .padding(16)
                        .alignSelf(.start)
                 
                    profileFlex.addItem(scrollView)
                        .width(100%)
                        .height(50)
                        .marginHorizontal(-16)
                        .define { scrollFlex in
                            scrollFlex.addItem(marqueeFlexView)
                                .direction(.row)
                                .justifyContent(.start)
                                .alignItems(.center)
                        }
                    
                    profileFlex.addItem(buttonFlexView)
                        .direction(.row)
                        .alignSelf(.center)
                        .padding(16)
                        .define { buttonFlex in
                            buttonFlex.addItem(notionImageButton)
                                .size(60)
                                .marginRight(25)
                            buttonFlex.addItem(githubImageButton)
                                .size(60)
                                .marginLeft(25)
                        }
                    
                    profileFlex.addItem(introductionLabel)
                        .alignSelf(.start)
                        
                    profileFlex.addItem(introductionText)
                        .alignSelf(.start)
                        .paddingTop(10)
                        .width(100%)
                        .height(200)
                }
        }
    }
    
    private func configureLayout(){
        rootFlexView.pin.all()
        
        profileFlexView.pin
            .all()
     
        rootFlexView.flex.layout()
    }
}
