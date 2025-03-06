//
//  TeamPartnerDetailView.swift
//  NBCamp-TeamBoard
//
//  Created by Eunsung on 3/4/25.
//

import UIKit
import PinLayout
import FlexLayout

class TeamPartnerDetailView: UIViewController {
    // Root FlexView
    private let rootFlexView = UIView()
    private let profileFlexView = UIView()
    private let buttonFlexView = UIView()
    
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
        textView.text = "잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다.잘 부탁드립니다."
        textView.font = .systemFont(ofSize: 20, weight: .bold)
        textView.backgroundColor = .lightGray
        
        textView.layer.cornerRadius = 10 // 10pt 만큼 둥글게
        textView.clipsToBounds = true // 내부 콘텐츠가 모서리를 넘지 않도록
        
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
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    // Notion 버튼
    private let notionImageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_notion")
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit // 버튼 크기에 맞게 이미지 조정
        button.addTarget(self, action: #selector(notionButtonTapped), for: .touchUpInside)
        return button
    }()
    // Github 버튼
    private let githubImageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_github")
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit // 버튼 크기에 맞게 이미지 조정
        button.addTarget(self, action: #selector(githubButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func notionButtonTapped() {
        print("노션 버튼 클릭!")
    }
    @objc private func githubButtonTapped() {
        print("깃허브 버튼 클릭!")
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
                        .padding(15)
                        .width(100%)
                        .height(200)
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
        
        
        
        rootFlexView.flex.layout()
    }
    
    private func setupLabels() {
        let items = ["INTP", "영화보기", "음악감상", "운동", "Leader", "MemberMemberMember"] // 임시 데이터
        let allItems = items + items + items // 3회 반복 후 초기화
        
        allItems.forEach { text in
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 16, weight: .bold)
            label.textColor = .black
            label.layer.borderWidth = 1
            label.textAlignment = .center
            label.backgroundColor = randomColor()
            label.layer.cornerRadius = 15
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



