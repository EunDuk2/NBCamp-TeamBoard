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
    
    var teamModel: TeamModel?
    
    private let imageSize: CGFloat = 300
    private let padding: CGFloat = 24
    
    private lazy var teamScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var containerView = UIView()
    
    // MARK: - UI 요소
    private lazy var teamImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var teamName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var rules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Rules"
        return label
    }()
    private lazy var teamRules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var schedules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Schedules"
        return label
    }()
    private lazy var teamSchedules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var TMI: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "TMI"
        return label
    }()
    private lazy var teamTMI: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    @objc func editBtnTapped() {
        
        let nextVC = TeamAddViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.title = "팀 상세"
        self.navigationItem.hidesBackButton = true
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
                flex.addItem(rules)
                flex.addItem(teamRules)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(schedules)
                flex.addItem(teamSchedules)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(TMI)
                flex.addItem(teamTMI)
            }
        }
    }
    
    private func updateUI() {
        guard let model = teamModel else { return }
        teamImage.image = model.teamImage
        teamName.text = model.teamName
        teamRules.text = model.teamRules
        teamSchedules.text = model.teamSchedules
        teamTMI.text = model.teamTMI
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        teamScrollView.pin.all(view.pin.safeArea)
        containerView.pin.all()
        containerView.flex.layout(mode: .adjustHeight)
        teamScrollView.contentSize = containerView.frame.size
    }
}

#Preview {
    TeamDetailViewController()
}
