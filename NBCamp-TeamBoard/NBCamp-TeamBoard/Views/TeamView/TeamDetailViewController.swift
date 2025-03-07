//
//  TeamDetailView.swift
//  NBCamp-TeamBoard
//
//  Created by 정근호 on 3/4/25.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

final class TeamDetailViewController: UIViewController {
    
    var teamEntity: TeamEntity?
    
    private let imageSize: CGFloat = 300
    private let padding: CGFloat = 24
    private let categoryFontSize: CGFloat = 20
    private let subtextFontSize: CGFloat = 16
    
    private lazy var teamScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var containerView = UIView()
    
    // MARK: - UI 요소
    
    // 이미지
    private lazy var teamImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    // 팀 이름
    private lazy var teamName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    
    // 팀 규칙
    private lazy var rules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: .bold)
        label.text = "Rules"
        return label
    }()
    private lazy var teamRules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: subtextFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    
    // 팀 일정
    private lazy var schedules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: .bold)
        label.text = "Schedules"
        return label
    }()
    private lazy var teamSchedules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: subtextFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var TMI: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: .bold)
        label.text = "TMI"
        return label
    }()
    private lazy var teamTMI: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: subtextFontSize, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    @objc func editBtnTapped() {
        let nextVC = AddTeamViewController()
        nextVC.teamEntity = teamEntity
        // 내비게이션 스택에서 MainViewController를 찾아 delegate로 할당
        if let mainVC = self.navigationController?.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController {
            nextVC.delegate = mainVC
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.title = "팀 상세"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editBtnTapped))
        
        view.addSubview(teamScrollView)
        teamScrollView.addSubview(containerView)
        
        setLayout()
        updateUI()
    }
    
    private func setLayout() {
        containerView.flex.padding(padding).alignItems(.start).define { (flex) in
            flex.addItem(teamImage).width(view.frame.width - padding * 2).height(view.frame.height / 3).alignSelf(.center)
            flex.addItem(teamName).padding(padding)
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(rules).marginBottom(8)
                flex.addItem(teamRules)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(schedules).marginBottom(8)
                flex.addItem(teamSchedules)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(TMI).marginBottom(8)
                flex.addItem(teamTMI)
            }
        }
    }
    
    private func updateUI() {
        guard let teamEntity = teamEntity else { return }
        
        teamImage.image = UIImage(data: teamEntity.image ?? Data())
        teamName.text = teamEntity.name
        teamRules.text = teamEntity.rule
        teamSchedules.text = teamEntity.schedules
        teamTMI.text = teamEntity.tmi
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        teamScrollView.pin.all(view.pin.safeArea)
        containerView.pin.all()
        containerView.flex.layout(mode: .adjustHeight)
        teamScrollView.contentSize = containerView.frame.size
    }
}
