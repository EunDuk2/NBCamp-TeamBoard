//
//  ProfileEditViewController.swift
//  NBCamp-TeamBoard
//
//  Created by GO on 3/4/25.
//

import UIKit
import PinLayout
import FlexLayout
import CoreData

class ProfileViewController: UIViewController {
    
    var memberEntity: MemberEntity?
    
    private let rootFlexContainer = UIView()
    private let profileImage = UIImageView()
    private let addImageButton = UIButton()
    
    private let nameLabel = UILabel()
    private let mbtiLabel = UILabel()
    private let hobbyLabel = UILabel()
    private let githubLinkLabel = UILabel()
    private let introductionLabel = UILabel()
    
    private let nameTextField = UITextField()
    private let mbtiTextField = UITextField()
    private let hobbyTextField = UITextField()
    private let githubLinkTextField = UITextField()
    private let introductionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFlexLayout()
        profileButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // PinLayout으로 rootFlexContainer 위치 및 크기 설정
        rootFlexContainer.pin.all(view.pin.safeArea)
        
        // FlexLayout으로 내부 아이템 배치
        rootFlexContainer.flex.layout()
    }
    
    // MARK: - UI
    private func setupUI() {
        view.backgroundColor = .white

        // 타이틀 설정
        navigationItem.title = "프로필 추가"
        
        // 완료 버튼 추가
        let completeButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completeButtonClicked))
        navigationItem.rightBarButtonItem = completeButton
        
        // 뷰 추가
        view.addSubview(rootFlexContainer)
        
        // 프로필 이미지 설정
        profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
        addImageButton.setImage(UIImage(systemName: "plus.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)), for: .normal)
        addImageButton.tintColor = .white
        addImageButton.backgroundColor = .systemGray
        addImageButton.layer.cornerRadius = 15
        addImageButton.clipsToBounds = true
        addImageButton.imageView?.contentMode = .scaleAspectFill
        
        
        // Label 텍스트 설정
        nameLabel.text = "이름"
        mbtiLabel.text = "MBTI"
        hobbyLabel.text = "취미"
        githubLinkLabel.text = "링크(GitHub)"
        introductionLabel.text = "나의 소개"
        
        [nameLabel, mbtiLabel, hobbyLabel, githubLinkLabel, introductionLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textColor = .black
        }
        
        // 텍스트 필드 스타일 설정
        [nameTextField, mbtiTextField, hobbyTextField, githubLinkTextField].forEach { textField in
            textField.borderStyle = .roundedRect
            textField.backgroundColor = .white
            textField.font = UIFont.systemFont(ofSize: 16)
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 8
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
        }
        
        // 소개 텍스트뷰 스타일 설정
        introductionTextView.layer.borderWidth = 1
        introductionTextView.layer.borderColor = UIColor.lightGray.cgColor
        introductionTextView.layer.cornerRadius = 8
        introductionTextView.font = UIFont.systemFont(ofSize: 16)
        
        introductionTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    // MARK: - FlexLayout 구성
    private func setupFlexLayout() {
        rootFlexContainer.flex.define { flex in
            
            flex.addItem().alignItems(.center).marginTop(20).define { row in
                row.addItem().define { imageContainer in
                    imageContainer.addItem(profileImage).size(100)
                    imageContainer.addItem(addImageButton).size(30).position(.absolute)
                        .right(0).bottom(0)
                }
            }
            
            flex.addItem(nameLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(nameTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(mbtiLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(mbtiTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(hobbyLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(hobbyTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(githubLinkLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(githubLinkTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(introductionLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(introductionTextView).marginTop(10).height(120).marginHorizontal(20)
            
            flex.marginBottom(10)
        }
    }
    
    // MARK: - CoreData 로직 - CoreDataManager
    private func saveMemberProfile() {
        let image = profileImage.image?.pngData()
        let name = nameTextField.text ?? ""
        let mbti = mbtiTextField.text ?? ""
        let hobby = hobbyTextField.text ?? ""
        let githubLink = githubLinkTextField.text ?? ""
        let introduction = introductionTextView.text ?? ""
        let role = "팀원" // 역할은 필요에 따라 수정
        
        if let member = memberEntity {
            CoreDataManager.shared.editMember(member: member, image: image, name: name, mbti: mbti, hobby: hobby, githubLink: githubLink, introduction: introduction, role: role)
        } else {
            CoreDataManager.shared.addMember(image: image, name: name, mbti: mbti, hobby: hobby, githubLink: githubLink, introduction: introduction, role: role)
        }
        

    }

    
    private func profileButton() {
        addImageButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
    }
    
    // Navigation rightBarButton Action
    @objc private func completeButtonClicked() {
        let image = profileImage.image?.pngData()
        let name = nameTextField.text ?? ""
        let mbti = mbtiTextField.text ?? ""
        let hobby = hobbyTextField.text ?? ""
        let githubLink = githubLinkTextField.text ?? ""
        let introduction = introductionTextView.text ?? ""
        let role = "팀원" // 역할은 필요에 따라 수정
        
        if let member = memberEntity {
            CoreDataManager.shared.editMember(member: member, image: image, name: name, mbti: mbti, hobby: hobby, githubLink: githubLink, introduction: introduction, role: role)
        } else {
            CoreDataManager.shared.addMember(image: image, name: name, mbti: mbti, hobby: hobby, githubLink: githubLink, introduction: introduction, role: role)
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func profileButtonClicked() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        // 이미지를 선택
        
        // Any? -> UIImage [ 타입 캐스팅 ]
        let image = info[UIImagePickerController.InfoKey.editedImage] // orginalImage일 경우 편집된 이미지 적용 불가 editedImage 써줘야함
        
        if let result = image as? UIImage {
            profileImage.image = result
        } else {
            // 토스트 메시지
            // 얼럿 메시지
            print("타입 캐스팅 실패")
        }
        
        // 이미지뷰에 이미지를 넣는 작업, 피커 dismiss
        dismiss(animated: true)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        
        dismiss(animated: true)
    }
}
