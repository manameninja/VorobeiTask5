//
//  ViewController.swift
//  VorobeiTask5
//
//  Created by Даниил Павленко on 15.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    let presentButton = UIButton()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureButton()
        view.addSubview(presentButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        presentButton.sizeToFit()
        presentButton.center.x = view.frame.width / 2
        presentButton.center.y = view.layoutMargins.top + 50
    }
    
    //MARK: - Methods
    func configureButton() {
        presentButton.tintColor = .systemBlue
        presentButton.setTitleColor(.tintColor, for: .normal)
        presentButton.setTitle("Present", for: .normal)
        presentButton.addAction(.init(handler: { _ in
            let navigationController = PopoverController(root: CompactController(),
                                                                   size: CGSize(width: 300, height: 280),
                                                                   sourceView: self.presentButton,
                                                                   sourceRect: self.presentButton.bounds,
                                                                   direction: .up)
            self.present(navigationController, animated: true)
        }), for: .touchUpInside)
    }
}

class CompactController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segment = UISegmentedControl(items: ["280pt", "150pt"])
        segment.addAction(.init(handler: { _ in
            self.navigationController?.preferredContentSize = CGSize(width: 300, height: segment.selectedSegmentIndex == 1 ? 150 : 280)
        }), for: .valueChanged)
        segment.selectedSegmentIndex = 0
        navigationItem.titleView = segment
        navigationItem.rightBarButtonItem = .init(systemItem: .close, primaryAction: .init(handler: { _ in
            self.dismiss(animated: true)
        }))
        view.backgroundColor = .systemGray6
    }
}

class PopoverController: UINavigationController, UIPopoverPresentationControllerDelegate {
    
    //MARK: - Initializations
    init(root: UIViewController, size: CGSize, sourceView: UIView, sourceRect: CGRect, direction: UIPopoverArrowDirection) {
        super.init(rootViewController: root)
        modalPresentationStyle = .popover
        preferredContentSize = size
        
        popoverPresentationController?.permittedArrowDirections = [direction]
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.sourceRect = sourceRect
        
        popoverPresentationController?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
