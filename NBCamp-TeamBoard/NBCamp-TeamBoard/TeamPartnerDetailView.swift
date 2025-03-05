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
        
        // flex의 addItem을 사용하여 자식 뷰나 컨트롤들을 StackView처럼 추가할 수 있다.
        rootFlexView.flex.define { rootFlex in
            rootFlex.addItem(profileFlexView) // rootFlex뷰 안에 자식 뷰로 profileFlexView 배치
                .alignItems(.center) // 사진은 중앙정렬, 나머지는 왼쪽 정렬 필요
                .padding(16)
                .backgroundColor(.green)
                .define { profileFlex in
                    profileFlex.addItem(profileImageView)
                        .size(260)
                        .cornerRadius(10)
                    profileFlex.addItem(nameLabel)
                        .alignItems(.start) // 이름은 왼쪽 정렬해야 되는데 안 먹힘
            }
        }
        
    }
    
    @objc private func editButtonTapped() {
        print("편집 버튼 클릭됨!")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // rootFlexView는 SafeArea만 덮도록 설정
        rootFlexView.pin.all(view.pin.safeArea)
        
        // flexView의 children 레이아웃 잡기
        rootFlexView.flex.layout()
    }
}


