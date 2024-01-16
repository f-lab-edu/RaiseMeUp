//
//  MainView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit

public enum ElementKind {
    static public let sectionHeader = "section-header-element-kind"
    static public let backgroundDecoration = "backgroundDecoration"
}

final class MainView: UIView {

    var programListView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBackground
        
        configure()
        addSubviews()
    }
    
    override func updateConstraints() {
        layout()
        
        super.updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        programListView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        programListView.translatesAutoresizingMaskIntoConstraints = false
        programListView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        self.addSubview(programListView)
    }
    
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            programListView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            programListView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            programListView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            programListView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension MainView {
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // item size
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(72)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: itemSize.heightDimension
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 1
            )
            let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: ElementKind.backgroundDecoration)
            backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 16)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
            section.decorationItems = [backgroundDecoration]
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(70)
            )
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: ElementKind.sectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [headerSupplementary]
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider,
            configuration: config
        )
        layout.register(
            RoundedBackgroundView.self,
            forDecorationViewOfKind: ElementKind.backgroundDecoration
        )
        return layout
    }
}
