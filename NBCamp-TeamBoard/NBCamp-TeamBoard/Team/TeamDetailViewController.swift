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
    
    private let teamModel = TeamModel()
        
    private let imageSize: CGFloat = 300
    private let padding: CGFloat = 24
    
    private lazy var teamScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var containerView = UIView()

    
    // MARK: - UI 요소
    private lazy var teamImage: UIImageView = {
        let imageView = UIImageView(image: teamModel.teamImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    
    private lazy var teamName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = teamModel.teamName
        return label
    }()
    
    
    private lazy var rules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Rules"
        return label
    }()
    private lazy var teamRules: [UILabel] = {
        return teamModel.teamRules.map { text in
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.text = "- \(text)"
            label.numberOfLines = 0
            return label
        }
    }()
    
    
    private lazy var schedules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Schedules"
        return label
    }()
    private lazy var teamSchedules: [UILabel] = {
        return teamModel.teamSchedules.map { text in
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.text = "- \(text)"
            label.numberOfLines = 0
            return label
        }
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
        label.text = teamModel.teamTMI
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(teamScrollView)
        teamScrollView.addSubview(containerView)
    
        containerView.flex.padding(padding).alignItems(.start).define { (flex) in
            
            flex.addItem(teamImage).width(view.frame.width-padding*2).height(view.frame.height/3).alignSelf(.center)
            
            flex.addItem(teamName).padding(padding)
            
            // Rules
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(rules)
                teamRules.forEach { label in
                    flex.addItem(label)
                }
            }
            
            // Schedules
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(schedules)
                teamSchedules.forEach { label in
                    flex.addItem(label)
                }
            }
            
            // TMI
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(TMI)
                flex.addItem(teamTMI)
            }
        }
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
