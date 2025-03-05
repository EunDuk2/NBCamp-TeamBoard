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
    case addMember
    case addTeam
}

class MainViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var datasource: UICollectionViewDiffableDataSource<Section, CellItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "팀 소개"
        self.view.backgroundColor = .white
        
        configureNavigationBar()
        configureCollectionView()
        updateSnapshot()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(resetButtonTapped)
        )
    }
    
    @objc private func resetButtonTapped() {
        CoreDataManager.shared.resetData()
        updateSnapshot()
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.pin
            .top(view.pin.safeArea)
            .horizontally()
            .bottom()
        
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: TeamCell.reuseIdentifier)
        collectionView.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.reuseIdentifier)
        collectionView.register(AddMemberCell.self, forCellWithReuseIdentifier: AddMemberCell.reuseIdentifier)
        collectionView.register(AddTeamCell.self, forCellWithReuseIdentifier: AddTeamCell.reuseIdentifier)
        collectionView.register(
            TitleSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleSupplementaryView.reuseIdentifier
        )
        
        datasource = UICollectionViewDiffableDataSource<Section, CellItem>(collectionView: collectionView)
        { collectionView, indexPath, item in
            switch item {
            case .team(let teamItem):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeamCell.reuseIdentifier,
                    for: indexPath
                ) as! TeamCell
                cell.configure(with: teamItem)
                return cell

            case .member(let memberItem):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MemberCell.reuseIdentifier,
                    for: indexPath
                ) as! MemberCell
                cell.configure(with: memberItem)
                return cell

            case .addMember:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddMemberCell.reuseIdentifier,
                    for: indexPath
                ) as! AddMemberCell
                return cell
                
            case .addTeam:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddTeamCell.reuseIdentifier,
                    for: indexPath
                ) as! AddTeamCell
                return cell
            }
        }

        
        datasource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            if kind == UICollectionView.elementKindSectionHeader, section == .members {
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: TitleSupplementaryView.reuseIdentifier,
                    for: indexPath
                ) as! TitleSupplementaryView
                
                return headerView
            }
            return nil
        }
    }
    private func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            switch section {
            case .team:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                       heightDimension: .fractionalWidth(0.9))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .groupPagingCentered
                sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
                return sectionLayout
                
            case .members:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.65))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                group.interItemSpacing = .fixed(20)
                
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.interGroupSpacing = 40
                sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                sectionLayout.boundarySupplementaryItems = [header]
                return sectionLayout
            }
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellItem>()
        
        let teams = CoreDataManager.shared.fetchTeams()
        if teams.isEmpty {
            snapshot.appendSections([.team])
            snapshot.appendItems([.addTeam], toSection: .team)
        } else {
            snapshot.appendSections(Section.allCases)
            
            let teamItems = teams.map { CellItem.team($0) }
            snapshot.appendItems(teamItems, toSection: .team)
            
            let members = CoreDataManager.shared.fetchMembers()
            let memberItems = members.map { CellItem.member($0) }
            snapshot.appendItems(memberItems, toSection: .members)
            snapshot.appendItems([.addMember], toSection: .members)
        }
        
        datasource.apply(snapshot, animatingDifferences: true)
    }

    
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = datasource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .team:
            print("팀 버튼")
        case .member:
            print("멤버 버튼")
        case .addMember:
            CoreDataManager.shared.addMember()
            updateSnapshot()
        case .addTeam:
            CoreDataManager.shared.addTeam()
            updateSnapshot()
        }
        
    }
}
