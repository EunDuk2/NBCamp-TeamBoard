//
//  TeamPartnerDetailView.swift
//  NBCamp-TeamBoard
//
//  Created by Eunsung on 3/4/25.
//

import UIKit
import PinLayout
import FlexLayout

import UIKit

class TeamPartnerDetailView: UIViewController {
    // Root FlexView
    private let rootFlexView = UIView()
    private let profileFlexView = UIView()
    
    // 프로필 이미지
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile1"))
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 프로필 이름
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "조은성"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    // 소개 제목
    private let introductionLabel: UILabel = {
        let label = UILabel()
        label.text = "소개"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    
    private let introductionText: UITextView = {
        let textView = UITextView()
        textView.text = "잘 부탁드립니다."
        textView.font = .systemFont(ofSize: 20, weight: .bold)
        textView.backgroundColor = .gray
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return textView
    }()

    
    // 가로 스크롤을 위한 ScrollView & StackView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    // Notion 버튼
    private let notionImageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_notion")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit // 버튼 크기에 맞게 이미지 조정
        button.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func imageButtonTapped() {
        print("이미지 버튼 클릭!")
    }
    
    private var labels: [UILabel] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "상세 정보"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "편집",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        
        view.addSubview(rootFlexView)
        rootFlexView.backgroundColor = .systemBackground
        profileFlexView.backgroundColor = .systemBackground
        
        scrollView.addSubview(stackView)
        
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
                    profileFlex.addItem(notionImageButton)
                    profileFlex.addItem(introductionLabel)
                        .alignSelf(.start)
                    profileFlex.addItem(introductionText)
                        .alignSelf(.start)
                        .padding(15)
                        .size(200)
                }
        }
        setupLabels()
        startScrolling()
    }
    
    @objc private func editButtonTapped() {
        print("편집 버튼 클릭!")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootFlexView.pin.all(view.pin.safeArea)
        
        profileFlexView.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
        
        scrollView.pin
            .below(of: profileFlexView, aligned: .center)
            .width(100%)
            .height(50)
//            .marginTop(20)
        
        stackView.frame = CGRect(x: 0, y: 0, width: labels.count * 120, height: 50)
        scrollView.contentSize = stackView.frame.size
        
        // 이 아래 코드가 안 먹힘
        notionImageButton.pin
            .height(100)
        introductionText.pin
            .horizontally()
        
        rootFlexView.flex.layout()
    }
    
    private func setupLabels() {
        let items = ["INTP", "영화보기", "음악감상", "운동", "Leader", "Member"] // 임시 데이터
        let allItems = items + items + items // 3회 반복 후 초기화
        
        allItems.forEach { text in
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 16, weight: .bold)
            label.textColor = .black
            label.layer.borderWidth = 1
            label.textAlignment = .center
            label.backgroundColor = randomColor()
            label.layer.cornerRadius = 20
            label.clipsToBounds = true
            label.numberOfLines = 1
            
            let horizontalPadding: CGFloat = 16
            var width: CGFloat = 100
            
            if text.count > 5 {
                let size = (text as NSString).size(withAttributes: [.font: label.font])
                width = size.width + horizontalPadding * 2
            }
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: width),
                label.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            labels.append(label)
            stackView.addArrangedSubview(label)
        }
    }
    
    func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0.1...0.9),
            green: CGFloat.random(in: 0.1...0.9),
            blue: CGFloat.random(in: 0.1...0.9),
            alpha: 1.0
        )
    }
    
    private func startScrolling() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(scrollLabels), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollLabels() {
        let currentX = scrollView.contentOffset.x
        let newX = currentX + 1
        
        if newX > stackView.frame.width / 2 {
            scrollView.contentOffset.x = 0
        } else {
            scrollView.contentOffset.x = newX
        }
    }
}



