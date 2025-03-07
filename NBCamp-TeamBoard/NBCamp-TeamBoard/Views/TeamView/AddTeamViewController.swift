//
//  AddTeamViewController.swift
//  NBCamp-TeamBoard
//
//  Created by 정근호 on 3/5/25.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout
import CoreData

protocol EditTeamDelegate: AnyObject {
    func editTeam()
}

class AddTeamViewController: UIViewController {
    
    weak var delegate: EditTeamDelegate?
    
    var teamEntity: TeamEntity?
    
    private let imageSize: CGFloat = 300
    private let padding: CGFloat = 24
    private let textPadding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private let textHeight: CGFloat = 30
    private let categoryFontSize: CGFloat = 16
    private let subtextFontSize: CGFloat = 12

    
    private lazy var teamScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var containerView = UIView()
    
    // MARK: - UI 요소
    
    // 이미지
    private lazy var addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray5
        imageView.tintColor = .systemGray
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 60, weight: .medium)
        label.textAlignment = .center
        label.text = "+"
        label.textColor = .systemGray
        return label
    }()
    private lazy var deleteImageBtn: UIButton = {
        let image = UIImage(systemName: "x.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.tintColor = .systemGray2
        btn.addTarget(self, action: #selector(didTapDeleteImage), for: .touchUpInside)
        return btn
    }()
    
    // 팀 이름
    private lazy var teamName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: .bold)
        label.text = "Team Name"
        return label
    }()
    private lazy var addTeamName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 8
        textField.font = .systemFont(ofSize: subtextFontSize)
        // 왼쪽 패딩
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        // 오른쪽 패딩
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        return textField
    }()
    
    
    // 팀 규칙
    private lazy var rules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: .bold)
        label.text = "Rules"
        return label
    }()
    private lazy var addRules: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 8
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.textContainerInset = textPadding
        return textView
    }()
    
    private lazy var schedules: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: .bold)
        label.text = "Schedules"
        return label
    }()
    private lazy var addSchedules: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 8
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.textContainerInset = textPadding
        return textView
    }()
    
    private lazy var TMI: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: .bold)
        label.text = "TMI"
        return label
    }()
    private lazy var addTMI: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 8
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.textContainerInset = textPadding
        return textView
    }()
    
    // MARK: - 버튼 업데이트
    
    // 이미지 추가 버튼, 이미지 삭제 버튼 hidden 여부
    private func addImageButtonSet() {
        if addImageView.image == nil {
            deleteImageBtn.isHidden = true
            addLabel.isHidden = false
        } else {
            deleteImageBtn.isHidden = false
            addLabel.isHidden = true
        }
        updateCompleteButtonState()
    }
    
    private func updateCompleteButtonState() {
//        let isImageSet = addImageView.image != nil
//        let isTeamNameSet = !(addTeamName.text?.isEmpty ?? true)
//        let isRulesSet = !(addRules.text?.isEmpty ?? true)
//        let isSchedulesSet = !(addSchedules.text?.isEmpty ?? true)
//        let isTMISet = !(addTMI.text?.isEmpty ?? true)
//        
//        navigationItem.rightBarButtonItem?.isEnabled = isImageSet && isTeamNameSet && isRulesSet && isSchedulesSet && isTMISet
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    
    @objc private func didTapDeleteImage() {
        addImageView.image = nil
        addImageButtonSet()
    }
    
    // 모델 데이터 전달
    @objc private func addCompleteBtnClicked() {
        if let teamEntity = teamEntity {
            print("팀 수정 완료")
            let image = addImageView.image?.pngData() ?? Data()
            let name = addTeamName.text ?? ""
            let rule = addRules.text ?? ""
            let schedules = addSchedules.text ?? ""
            let tmi = addTMI.text ?? ""
            
            delegate?.editTeam()
            
            CoreDataManager.shared.editTeam(team: teamEntity ,image: image, name: name, rule: rule,
                                            schedules: schedules, tmi: tmi)
            
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            print("팀 추가 완료")
            let image = addImageView.image?.pngData() ?? Data()
            let name = addTeamName.text ?? ""
            let rule = addRules.text ?? ""
            let schedules = addSchedules.text ?? ""
            let tmi = addTMI.text ?? ""
            
            CoreDataManager.shared.addTeam(image: image, name: name, rule: rule,
                                           schedules: schedules, tmi: tmi)
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        teamEntity == nil ? setupAddUI() : setupEditUI()
        addImageButtonSet()
        setLayout()
    }
    
    private func setupAddUI() {
        self.navigationItem.title = "팀 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addCompleteBtnClicked))
    }
    
    private func setupEditUI() {
        self.navigationItem.title = "팀 수정"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(addCompleteBtnClicked))
        
        addImageView.image = UIImage(data: teamEntity?.image ?? Data())
        addTeamName.text = teamEntity?.name
        addRules.text = teamEntity?.rule
        addSchedules.text = teamEntity?.schedules
        addRules.text = teamEntity?.rule
        
    }
    
    
    private func setLayout() {
        containerView.flex.padding(padding).alignItems(.start).define { flex in
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(addImageView).width(view.frame.width - padding * 2).height(view.frame.height / 3).alignSelf(.center)
                flex.addItem(addLabel)
                flex.addItem(deleteImageBtn).size(40)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(teamName).marginBottom(8)
                flex.addItem(addTeamName).width(view.frame.width - padding * 2).height(textHeight)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(rules).marginBottom(8)
                flex.addItem(addRules).width(view.frame.width - padding * 2)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(schedules).marginBottom(8)
                flex.addItem(addSchedules).width(view.frame.width - padding * 2)
            }
            
            flex.addItem().paddingBottom(padding).direction(.column).define { flex in
                flex.addItem(TMI).marginBottom(8)
                flex.addItem(addTMI).width(view.frame.width - padding * 2)
            }
        }
        
        view.addSubview(teamScrollView)
        teamScrollView.addSubview(containerView)
        addImageView.addSubview(addLabel)
        addImageView.addSubview(deleteImageBtn)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamScrollView.pin.all(view.pin.safeArea)
        containerView.pin.all()
        
        containerView.flex.layout(mode: .adjustHeight)
        addLabel.pin.vCenter(to: addImageView.edge.vCenter)
        addLabel.pin.hCenter(to: addImageView.edge.hCenter)
        deleteImageBtn.pin.topRight(to: addImageView.anchor.topRight)
        
        
        teamScrollView.contentSize = containerView.frame.size
        
        // 자동 스크롤
        goToBottomOfScrollView()

        
    }
    
    
    // 자동 스크롤
    private func goToBottomOfScrollView() {
        let scrollView = teamScrollView
        scrollView.scrollRectToVisible(CGRect(x: 0,
                                              y: scrollView.contentSize.height - scrollView.bounds.height,
                                              width: scrollView.bounds.size.width,
                                              height: scrollView.bounds.size.height),
                                       animated: false)
    }

}

// MARK: - UITextViewDelegate
extension AddTeamViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCompleteButtonState()
        
        // 텍스트 뷰 여러줄 크기 조정
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.flex.height(estimatedSize.height > textHeight ? estimatedSize.height : textHeight)
        textView.flex.markDirty()
                
        teamScrollView.flex.layout(mode: .adjustHeight)
        teamScrollView.contentSize = containerView.frame.size
        
    }
}

// MARK: - Image Picker
extension AddTeamViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func didTapAddImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: false)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Select Image")
        self.dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            let pickedImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.addImageView.image = pickedImg
            self.addImageButtonSet()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel Image Picker")
        self.dismiss(animated: false)
    }
}
