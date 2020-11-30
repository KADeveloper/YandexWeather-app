//
//  LoadingView.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 30.11.2020.
//

import UIKit

class LoadingView: UIView {
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = UIColor.black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    init() {
        super.init(frame: CGRect.zero)
        initUI()
        initLayout()
    }

    private func initUI() {
        backgroundColor = .lightGray
        addSubview(spinner)
    }

    private func initLayout() {
        addConstraints([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func show(in view: UIView) {
        frame = view.bounds
        
        view.addSubview(self)
        spinner.startAnimating()
    }

    private func hide() {
        spinner.stopAnimating()
        removeFromSuperview()
    }
    
    func hide(withDelay delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.hide()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

