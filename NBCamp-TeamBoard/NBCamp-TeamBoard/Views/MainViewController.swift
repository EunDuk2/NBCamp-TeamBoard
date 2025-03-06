//
//  MainViewController.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/3/25.
//

import UIKit
import PinLayout
import CoreData

enum Section: Int, CaseIterable {
    case team
    case members
}

enum CellItem: Hashable {
    case team(TeamEntity)
    case member(MemberEntity)
    case addTeam
    case addMember
}

class MainViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        return collectionView
    }()
    
    private var datasource: UICollectionViewDiffableDataSource<Section, CellItem>!
    
    // MARK: - ViewModel
    private let viewModel = MainViewModel(teams: [], members: [])
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCollectionView()
        bindViewModel()
        updateSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchTeam()
        viewModel.fetchMember()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom()
    }
    
    // MARK: - Configuration
    private func configureView() {
        title = "팀 소개"
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(resetButtonTapped)
        )
    }
    
    @objc private func resetButtonTapped() {
        viewModel.resetData()
        updateSnapshot()
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        registerCells()
        configureDatasource()
    }
    
    private func registerCells() {
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: TeamCell.reuseIdentifier)
        collectionView.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.reuseIdentifier)
        collectionView.register(AddMemberCell.self, forCellWithReuseIdentifier: AddMemberCell.reuseIdentifier)
        collectionView.register(AddTeamCell.self, forCellWithReuseIdentifier: AddTeamCell.reuseIdentifier)
        collectionView.register(
            TitleSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleSupplementaryView.reuseIdentifier
        )
    }
    
    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, CellItem>(collectionView: collectionView)
        { collectionView, indexPath, item in
            switch item {
            case .team(let team):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeamCell.reuseIdentifier,
                    for: indexPath
                ) as! TeamCell
                cell.configure(with: team)
                return cell
                
            case .member(let member):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MemberCell.reuseIdentifier,
                    for: indexPath
                ) as! MemberCell
                cell.configure(with: member)
                return cell
                                
            case .addTeam:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddTeamCell.reuseIdentifier,
                    for: indexPath
                ) as! AddTeamCell
                return cell
                
            case .addMember:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddMemberCell.reuseIdentifier,
                    for: indexPath
                ) as! AddMemberCell
                return cell
            }
        }
        
        datasource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let section = Section(rawValue: indexPath.section),
                  kind == UICollectionView.elementKindSectionHeader,
                  section == .members else { return nil }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleSupplementaryView.reuseIdentifier,
                for: indexPath
            ) as! TitleSupplementaryView
            return headerView
        }
    }
    
    private func bindViewModel() {
        viewModel.didChangeData = { [weak self] in
            self?.updateSnapshot()
        }
        
        viewModel.didSelectTeam = { [weak self] team in
            let teamVM = TeamViewModel(team: team)
            let detailVC = TeamDetailViewController(viewModel: teamVM)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        viewModel.didSelectMember = { [weak self] member in
            let memberVM = MemberViewModel(member: member)
            let detailVC = MemberDetailViewController(viewModel: memberVM)
            self?.navigationController?.pushViewController(detailVC, animated: true)

        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellItem>()
        
        if viewModel.teams.isEmpty {
            snapshot.appendSections([.team])
            snapshot.appendItems([.addTeam], toSection: .team)
        } else {
            snapshot.appendSections(Section.allCases)
            
            let teamItems = viewModel.teams.map { CellItem.team($0) }
            snapshot.appendItems(teamItems, toSection: .team)
            
            let memberItems = viewModel.members.map { CellItem.member($0) }
            snapshot.appendItems(memberItems, toSection: .members)
            snapshot.appendItems([.addMember], toSection: .members)
        }
        
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let self = self, let section = Section(rawValue: sectionIndex) else { return nil }
            return section == .team ? self.teamSectionLayout() : self.membersSectionLayout()
        }
    }
    
    private func teamSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalWidth(0.9)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
        return section
    }
    
    private func membersSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.65)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 40
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = datasource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .team(let teamItem):
            viewModel.selectTeam(teamItem)
        case .member(let memberItem):
            viewModel.selectMember(memberItem)
        case .addTeam:
            viewModel.addTeam()
        case .addMember:
            viewModel.addMember()
        }
    }
}
