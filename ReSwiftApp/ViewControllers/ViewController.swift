//
//  ViewController.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import UIKit
import ReSwift
import MJRefresh
import DifferenceKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private lazy var dataSource: [Member] = {
        return [Member]()
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private lazy var refreshHeader: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader { [weak self] in
            guard let `self` = self else { return }
            self.refreshFooter.resetNoMoreData()
            mainStore.dispatch(fetchNewMembers)
        }
        return header
    }()

    private lazy var refreshFooter: MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter { [weak self] in
            guard let `self` = self else { return }
            guard !self.refreshHeader.isRefreshing else { return }
            mainStore.dispatch(fetchNextPageMembers)
        }
        return footer
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
        indicatorView.startAnimating()
        mainStore.dispatch(fetchNewMembers)
    }

    override func viewDidDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(indicatorView)
        tableView.tableFooterView = UIView()
        tableView.mj_header = refreshHeader
        tableView.mj_footer = refreshFooter
        refreshFooter.isHidden = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        indicatorView.center = view.center
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func endHeaderRefresh() {
        if refreshHeader.isRefreshing {
            refreshHeader.endRefreshing()
        }
    }

    private func endFooterRefresh() {
        if refreshHeader.isRefreshing {
            refreshHeader.endRefreshing()
        }
        if refreshFooter.isRefreshing {
            refreshFooter.endRefreshing()
        }
    }
}

// MARK: - StoreSubscriber

extension ViewController: StoreSubscriber {

    typealias StoreSubscriberStateType = MainState

    func newState(state: MainState) {

        ///Diff relaod
        let changeset = StagedChangeset(source: dataSource, target: state.members)
        tableView.reload(using: changeset, with: .fade) { [weak self] in
            guard let `self` = self else { return }
            self.dataSource = $0
        }

        /// Handle Error
        if let error = state.error {
            alert(title: "连接错误", message: error.localizedDescription)
        }

        /// 处理点击
        if let selectMember = state.selectMember {
            alert(title: "点击了", message: selectMember.name ?? "")
        }
        
        /// 停止加载动画
        if indicatorView.isAnimating {
            indicatorView.stopAnimating()
        }
        
        /// 结束刷新
        if state.endHeaderFresh {
            endHeaderRefresh()
        }
        if state.endFooterFresh {
            endFooterRefresh()
        }

        /// 没有更多数据了
        if state.isNoMoreData {
            refreshFooter.endRefreshingWithNoMoreData()
        }

        /// 没有数据隐藏Footer
        refreshFooter.isHidden = state.members.isEmpty

    }

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberCell.identify, for: indexPath) as? MemberCell else {
            return UITableViewCell()
        }
        let model = dataSource[indexPath.row]
        cell.configureData(member: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Preload data
        if indexPath.row == dataSource.count - 5, refreshFooter.state != .noMoreData, refreshFooter.state != .refreshing {
            mainStore.dispatch(MainStateAction.beginFooterRefresh)
        }
    }
    
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mainStore.dispatch(MainStateAction.didSelectRow(indexPath.row))
    }

}
