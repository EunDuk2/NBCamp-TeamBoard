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

protocol EditMemberDelegate: AnyObject {
    func editMember()
}

class AddMemberViewController: UIViewController {
    
    weak var delegate: EditMemberDelegate?
    
    var memberEntity: MemberEntity?
    
    private let scrollView = UIScrollView()
    private let rootFlexContainer = UIView()
    private let profileImage = UIImageView()
    private let addImageButton = UIButton()
    
    private let nameLabel = UILabel()
    private let roleLabel = UILabel()
    private let mbtiLabel = UILabel()
    private let hobbyLabel = UILabel()
    private let githubLinkLabel = UILabel()
    private let notionLinkLabel = UILabel()
    private let introductionLabel = UILabel()
    
    private let nameTextField = UITextField()
    private let roleTextField = UITextField()
    private let mbtiTextField = UITextField()
    private let hobbyTextField = UITextField()
    private let githubLinkTextField = UITextField()
    private let notionLinkTextField = UITextField()
    private let introductionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupUI()
        setupFlexLayout()
        profileButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all(view.pin.safeArea)
        
        rootFlexContainer.pin.top().left().right()
        
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        scrollView.contentSize = rootFlexContainer.frame.size
    }
    
    // MARK: - 델리게이트 설정
    private func setupDelegates() {
        nameTextField.delegate = self
        roleTextField.delegate = self
        mbtiTextField.delegate = self
        hobbyTextField.delegate = self
        githubLinkTextField.delegate = self
        notionLinkTextField.delegate = self
        introductionTextView.delegate = self
    }
    // MARK: - UI
    private func setupUI() {
        view.backgroundColor = .white
        
        if let memberEntity = memberEntity {
            navigationItem.title = "멤버 수정"
            // 완료 버튼 추가
            let completeButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(completeButtonClicked))
            navigationItem.rightBarButtonItem = completeButton
            
            profileImage.image = UIImage(data: memberEntity.image ?? Data())
            nameTextField.text = memberEntity.name
            roleTextField.text = memberEntity.role
            mbtiTextField.text = memberEntity.mbti
            hobbyTextField.text = memberEntity.hobby
            githubLinkTextField.text = memberEntity.githubLink
//            notionLinkTextField.text = memberEntity.notionLink  <-- memberEntity 수정이 안됩니다
            introductionTextView.text = memberEntity.introduction
            
        } else {
            navigationItem.title = "멤버 추가"
            // 완료 버튼 추가
            let completeButton = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(completeButtonClicked))
            navigationItem.rightBarButtonItem = completeButton
            
            profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(rootFlexContainer)
        
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
        
        nameLabel.text = "이름"
        roleLabel.text = "역할"
        mbtiLabel.text = "MBTI"
        hobbyLabel.text = "취미"
        githubLinkLabel.text = "링크(GitHub)"
        notionLinkLabel.text = "노션(Notion)"
        introductionLabel.text = "나의 소개"
        
        [nameLabel, roleLabel, mbtiLabel, hobbyLabel, githubLinkLabel, notionLinkLabel, introductionLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textColor = .black
        }
        
        [nameTextField, roleTextField, mbtiTextField, hobbyTextField, githubLinkTextField, notionLinkTextField].forEach { textField in
            textField.borderStyle = .roundedRect
            textField.backgroundColor = .white
            textField.font = UIFont.systemFont(ofSize: 16)
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 8
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
        }
        
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
            
            flex.addItem(roleLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(roleTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(mbtiLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(mbtiTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(hobbyLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(hobbyTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(githubLinkLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(githubLinkTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(notionLinkLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(notionLinkTextField).marginTop(10).height(40).marginHorizontal(20)
            
            flex.addItem(introductionLabel).marginTop(20).marginHorizontal(20)
            flex.addItem(introductionTextView).marginTop(10).height(120).marginHorizontal(20)
            
            flex.marginBottom(10)
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
        let notionLink = notionLinkTextField.text ?? ""
        let introduction = introductionTextView.text ?? ""
        let role = "팀원" // 역할은 필요에 따라 수정
        
        // MARK: - CoreData
        if let member = memberEntity {
            delegate?.editMember()
            
            // TODO: Notion 링크 추가 필요
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
// MARK: - ImagePicker
extension AddMemberViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage.image = editedImage
        } else {
            print("이미지 선택 실패")
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate 및 UITextViewDelegate
extension AddMemberViewController: UITextFieldDelegate, UITextViewDelegate {
    // 리턴 키 눌렀을 때 다음 텍스트 필드로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            roleTextField.becomeFirstResponder()
        case roleTextField:
            mbtiTextField.becomeFirstResponder()
        case mbtiTextField:
            hobbyTextField.becomeFirstResponder()
        case hobbyTextField:
            githubLinkTextField.becomeFirstResponder()
        case githubLinkTextField:
            notionLinkTextField.becomeFirstResponder()
        case notionLinkTextField:
            introductionTextView.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
