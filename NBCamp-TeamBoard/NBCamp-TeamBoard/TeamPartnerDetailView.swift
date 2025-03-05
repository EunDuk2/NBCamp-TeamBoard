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
    // 기본, 전체 화면을 덮는 FlexView
    private let rootFlexView = UIView()
    // 프로필에 필요한 정보를 수직으로 나열하는 FlexView
    private let profileFlexView = UIView()
    // 프로필 이미지 뷰
    private let profileImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile1")
        imageView.clipsToBounds = true
        return imageView
    }()
    // 프로필 이름 레이블
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "조은성"
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.backgroundColor = .yellow
        label.numberOfLines = 1
        return label
    }()
    
    // ScrollView + StackView를 활용하여 가로 무한 스크롤 구현
    // FlexView를 통해 가로 배치는 가능하지만 스크롤 하기 어려움
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private var labels: [UILabel] = []
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 최상단 뷰 배경색 설정
        view.backgroundColor = .systemBackground
        
        // 네비게이션 바 타이틀 설정
        title = "상세 정보"

        // Right Bar Button 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "편집",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        
        // PinLaoyout & FlexLayout 사용을 위한 최초 FlexView 배치
        view.addSubview(rootFlexView)
        rootFlexView.backgroundColor = .systemBackground
        profileFlexView.backgroundColor = .systemBlue
        
        scrollView.addSubview(stackView)
        
        // flex의 addItem을 사용하여 자식 뷰나 컨트롤들을 StackView처럼 추가할 수 있다.
        rootFlexView.flex.define { rootFlex in
            rootFlex.addItem(profileFlexView) // rootFlex뷰 안에 자식 뷰로 profileFlexView 배치
                .alignItems(.center) // 사진은 중앙정렬, 나머지는 왼쪽 정렬 필요
                .padding(16)
                .backgroundColor(.green)
                .define { profileFlex in
                    profileFlex.addItem(profileImageView)
                        .size(260)
                        .cornerRadius(15)
                    profileFlex.addItem(nameLabel)
                        .padding(16)
//                        .alignItems(.start) // 이름은 왼쪽 정렬해야 되는데 안 먹힘
                        .alignSelf(.start)
                    profileFlex.addItem(scrollView)
            }
        }
        setupLabels()
        startScrolling()
    }
    
    @objc private func editButtonTapped() {
        print("편집 버튼 클릭됨!")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // rootFlexView는 SafeArea만 덮도록 설정
        rootFlexView.pin.all(view.pin.safeArea)
        
        profileFlexView.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
//            .height(120)
        
        scrollView.pin
            .below(of: profileFlexView, aligned: .center)
            .width(100%)
            .height(50)
            .marginTop(20)
        
        stackView.frame = CGRect(x: 0, y: 0, width: labels.count * 120, height: 50)
        scrollView.contentSize = stackView.frame.size
        
        // flexView의 children 레이아웃 잡기
        rootFlexView.flex.layout()
    }
    
    private func setupLabels() {
        let items = ["INTP", "영화보기", "음악감상", "운동", "Leader", "MemberMemberMember"]
        
        // 기존 아이템 + 무한 스크롤을 위한 복제 아이템 추가
        let allItems = items + items + items // 🚀 아이템 2배 추가
        
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
            
            // 📌 고정된 패딩 유지 (좌우 16px씩 추가)
            let horizontalPadding: CGFloat = 16
            
            // 기본 너비 100
            var width: CGFloat = 100

            // 글자 수가 5개 이상이면 동적 크기 조정
            if text.count > 5 {
                let size = (text as NSString).size(withAttributes: [.font: label.font])
                width = size.width + horizontalPadding * 2 // 🚀 패딩 균일 적용
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
            red: CGFloat.random(in: 0.2...1),
            green: CGFloat.random(in: 0.2...1),
            blue: CGFloat.random(in: 0.2...1),
            alpha: 1.0
        )
    }

    
    private func startScrolling() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(scrollLabels), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollLabels() {
        let currentX = scrollView.contentOffset.x
        let newX = currentX + 1

        // 맨 끝까지 가면 처음으로 되돌리기
        if newX > stackView.frame.width / 2 {
            scrollView.contentOffset.x = 0
        } else {
            scrollView.contentOffset.x = newX
        }
    }
}


