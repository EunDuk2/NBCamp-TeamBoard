//
//  TeamAddViewController.swift
//  NBCamp-TeamBoard
//
//  Created by 정근호 on 3/5/25.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class TeamAddViewController: UIViewController {
    
    private let teamModel = TeamModel()

    private let imageSize: CGFloat = 300
    private let padding: CGFloat = 24
        
    private lazy var teamScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var containerView = UIView()
    
    
    // MARK: - UI 요소
    private lazy var addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray4
        return imageView
    }()
    
    private lazy var teamName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Team Name"
        return label
    }()
    private lazy var addTeamName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    
    private lazy var rules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Rules"
        return label
    }()
    private lazy var addRules: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    
    private lazy var schedules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Schedules"
        return label
    }()
    private lazy var addSchedules: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    
    private lazy var TMI: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "TMI"
        return label
    }()
    private lazy var addTMI: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.flex.padding(padding).alignItems(.start).define { flex in
            
            flex.addItem(addImageView).width(view.frame.width-padding*2).height(view.frame.height/3).alignSelf(.center).paddingBottom(padding)
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(teamName)
                flex.addItem(addTeamName).paddingTop(4).width(view.frame.width-padding*2).height(40)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(rules)
                flex.addItem(addRules).paddingTop(4).width(view.frame.width-padding*2).height(40)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(schedules)
                flex.addItem(addSchedules).paddingTop(4).width(view.frame.width-padding*2).height(40)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(TMI)
                flex.addItem(addTMI).paddingTop(4).width(view.frame.width-padding*2).height(40)
            }
        }
        
        view.addSubview(teamScrollView)
        teamScrollView.addSubview(containerView)
    }
    
    override func viewDidLayoutSubviews() {
        teamScrollView.pin.all(view.pin.safeArea)
        containerView.pin.all()
        
        containerView.flex.layout(mode: .adjustHeight)
        
        teamScrollView.contentSize = containerView.frame.size
    }
}

#Preview {
    TeamAddViewController()
}
