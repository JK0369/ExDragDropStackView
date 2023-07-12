//
//  DragDropStackView.swift
//  ExDragDropStackView
//
//  Created by 김종권 on 2023/07/12.
//

import UIKit
import RxSwift

protocol DragDropStackViewDelegate {
    func didBeginDrag()
    func dargging(inUpDirection up: Bool, maxY: CGFloat, minY: CGFloat)
    func didEndDrop()
}

final class DragDropStackView: UIStackView, DragDropable {
    // MARK: Property
    var dargDropDelegate: DragDropStackViewDelegate?
    var dragDropEnabled = false {
        didSet { gestures.forEach { $0.isEnabled = dragDropEnabled } }
    }
    var gestures = [UILongPressGestureRecognizer]()
    var disposeBag = DisposeBag()
    
    let config: DragDropConfig
    
    init(config: DragDropConfig = DragDropConfig()) {
        self.config = config
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Method
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        addLongPressGestureForDragDrop(arrangedSubview: view)
        /// long press 후 드래그 할 때 동시에 스크롤 안되게끔 처리
        gestures.last?.delegate = self
    }
}


// MARK: - DragDropStackView + UIGestureRecognizerDelegate

extension DragDropStackView: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        /// long press 후 드래그 할 때 동시에 스크롤 안되게끔 처리
        !isStatusDragging
    }
}

