//
//  ViewController.swift
//  ExDragDropStackView
//
//  Created by 김종권 on 2023/07/12.
//

import Then
import UIKit
import SnapKit

class ViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = DragDropStackView().then {
        $0.axis = .vertical
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        stackView.dargDropDelegate = self
    }
}


// MARK: - Priavte Method

private extension ViewController {
    func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        (0...30)
            .map(String.init)
            .map { text in
                let label = UILabel().then {
                    $0.text = text
                    $0.font = .systemFont(ofSize: 13)
                    $0.textAlignment = .center
                    $0.backgroundColor = randomColor()
                }
                label.snp.makeConstraints {
                    $0.height.equalTo(120)
                }
                return label
            }
            .forEach(stackView.addArrangedSubview)
        
        scrollView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }
    
    func randomColor() -> UIColor{
        UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
}


// MARK: - ViewController + DragDropDelegate

extension ViewController: DragDropStackViewDelegate {
    func didBeginDrag() {
        print("began")
    }
    
    func dargging(inUpDirection up: Bool, maxY: CGFloat, minY: CGFloat) {
        print("dargging")
    }
    
    func didEndDrop() {
        print("end")
    }
}
