//
//  MemberDetailViewController.swift
//  NBCamp-TeamBoard
//
//  Created by Eunsung on 3/4/25.
//

import UIKit
import PinLayout
import FlexLayout
import CoreData

final class MemberDetailViewController: UIViewController {
    
    var memberEntity: MemberEntity?
    
    private var labels: [(UILabel, CGFloat)] = []
    private var timer: Timer?
    
    private let memberDetailView: MemberDetailView = {
        return MemberDetailView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
        configureUI()
        setupLabels()
        startScrolling()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(memberDetailView)
        
        
        guard let memberEntity = memberEntity else { return }
        memberDetailView.profileImageView.image = UIImage(data: memberEntity.image ?? Data())
        memberDetailView.nameLabel.text = memberEntity.name
        memberDetailView.introductionText.text = memberEntity.introduction
    }
    
    private func configureLayout(){
        memberDetailView.pin.top(view.pin.safeArea).left().right().bottom()
    }
    
    private func configureNavigationBar(){
        title = "상세 정보"
        
        let editButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.setRightBarButton(editButtonItem, animated: true)
    }
    
    @objc private func editButtonTapped() {
        let editMemberVC = AddMemberViewController()
        editMemberVC.memberEntity = memberEntity
        
        if let mainVC = self.navigationController?.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController {
            editMemberVC.delegate = mainVC
        }
        self.navigationController?.pushViewController(editMemberVC, animated: true)
    }
    
    @objc private func notionButtonTapped() {
        print("노션 버튼 클릭!")
    }
    
    @objc private func githubButtonTapped() {
        print("깃허브 버튼 클릭!")
    }
    
    private func setupLabels() {
        guard let hobbyString = memberEntity?.hobby else { return }
        let hobbies = hobbyString.split { $0 == " " || $0 == "," }.map { String($0) }.filter { !$0.isEmpty }
        print(hobbies)

        let allItems = hobbies + hobbies + hobbies // 3회 반복 후 초기화
        
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
            
            labels.append((label, width))
        }
        memberDetailView.marqueeFlexView.flex
            .direction(.row).define { marqueeFlex in
                labels.forEach{
                    marqueeFlex.addItem($0.0)
                        .marginRight(15)
                        .width($0.1)
                        .height(40)
                }
            }
    }
    
    private func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0.1...0.9),
            green: CGFloat.random(in: 0.1...0.9),
            blue: CGFloat.random(in: 0.1...0.9),
            alpha: 0.5
        )
    }
    
    private func startScrolling() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(scrollLabels), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollLabels() {
        let currentX = memberDetailView.scrollView.contentOffset.x
        let newX = currentX + 1
        
        if newX > memberDetailView.marqueeFlexView.frame.width / 2 {
            DispatchQueue.main.async { [weak self] in
                self?.memberDetailView.scrollView.contentOffset.x = 0
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.memberDetailView.scrollView.contentOffset.x = newX
            }
        }
    }
}



