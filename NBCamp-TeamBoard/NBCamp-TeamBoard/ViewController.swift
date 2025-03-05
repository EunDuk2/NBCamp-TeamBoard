//
//  ViewController.swift
//  NBCamp-TeamBoard
//
//  Created by Eunsung on 3/3/25.
//

 
import UIKit

class ViewController: UIViewController {
    
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "초기세팅 테스트 입니다."
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.clipsToBounds = true
        return label
    }()
    
    private let showProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필 만들기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showTeamPartnerDetailView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    
    private func setUI() {
        view.addSubview(testLabel)
        view.addSubview(showProfileButton)
        view.backgroundColor = .yellow
    }
    
    private func setLayout() {
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        showProfileButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            
            showProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showProfileButton.topAnchor.constraint(equalTo: testLabel.bottomAnchor, constant: 20),
            showProfileButton.widthAnchor.constraint(equalToConstant: 150),
            showProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func showTeamPartnerDetailView() {
        let profileVC = TeamPartnerDetailView()
        profileVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
}


