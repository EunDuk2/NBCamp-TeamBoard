//
//  PartnerDetailViewController.swift
//  NBCamp-TeamBoard
//
//  Created by Eunsung on 3/4/25.
//

import UIKit
import PinLayout
import FlexLayout

final class PartnerDetailViewController: UIViewController {
    
    private var labels: [UILabel] = []
    private var timer: Timer?
    
    private lazy var partnerDetailView: PartnerDetailView = {
        return PartnerDetailView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
        configureUI()
//        setupLabels()
//        startScrolling()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(partnerDetailView)
    }
    
    private func configureLayout(){
        partnerDetailView.pin.top(view.pin.safeArea).left().right().bottom()
    }
    
    private func configureNavigationBar(){
        title = "상세 정보"
        
        let editButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.setRightBarButton(editButtonItem, animated: true)
    }
    
    @objc private func editButtonTapped() {
        print("편집 버튼 클릭!")
    }
    
    @objc private func notionButtonTapped() {
        print("노션 버튼 클릭!")
    }
    
    @objc private func githubButtonTapped() {
        print("깃허브 버튼 클릭!")
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
//            stackView.addArrangedSubview(label)
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
//        let currentX = scrollView.contentOffset.x
//        let newX = currentX + 1
//        
//        if newX > stackView.frame.width / 2 {
//            scrollView.contentOffset.x = 0
//        } else {
//            scrollView.contentOffset.x = newX
//        }
    }
}



