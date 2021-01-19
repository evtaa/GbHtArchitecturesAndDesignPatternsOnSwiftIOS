//
//  NewsDataServiceProxy.swift
//  vk
//
//  Created by Alexandr Evtodiy on 13.01.2021.
//  Copyright © 2021 Alexandr Evtodiy. All rights reserved.
//

import Foundation
import PromiseKit

class VkServiceProxy: VkServiceInterface {
    
    let vkService: VKService
    init (vkService: VKService) {
        self.vkService = vkService
    }
    
    func loadFriendsData(userId: String) -> Promise <[VkApiUsersItem]> {
        print ("called function loadFriendsData with a userId = \(userId)")
        return vkService.loadFriendsData(userId: userId)
    }
    
    func loadPhotosData (userId: Int) {
        print ("called function loadPhotosData with a userId = \(userId)")
        return vkService.loadPhotosData(userId: userId)
    }
    
    func loadGroupsData (userId: Int) {
        print ("called function loadGroupsData with a userId = \(userId)")
        return vkService.loadGroupsData(userId: userId)
    }
    
    func loadSearchGroupsData (search: String, completion: @escaping ([VkApiGroupItem]) -> Void) {
        print ("called function loadSearchGroupsData with a search = \(search)")
        vkService.loadSearchGroupsData(search: search, completion: completion)
    }
    
    func loadNewsData(startTime: Int = 0, startFrom: String = "", typeNew: [TypeNew], completion: @escaping (Swift.Result<[VkApiNewItem]?, loadNewsDataError>, String?) -> Void) {
        
        print ("called function loadNewsdata from a startTime = \(startTime) and a startFrom = \(startFrom)")
        vkService.loadNewsData(startTime: startTime, startFrom: startFrom, typeNew: typeNew, completion: completion)
        
    }
   
    
}
