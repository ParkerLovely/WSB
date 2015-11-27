//
//  ContactData.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/21.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import Foundation

class ContactData: NSObject, NSFetchedResultsControllerDelegate {
    
    
    var fetchedResultsController : NSFetchedResultsController!
    
    var refreshData : (Void ->Void)?
    
    
     init(refreshData : (Void->Void)?) {
        super.init()
        
        
        self.refreshData = refreshData
        let context = XMPPManager.getInstance().getRosterCoreDataContext()
        let request = NSFetchRequest(entityName: "XMPPUserCoreDataStorageObject")
        let jid = UserInfo.getInstance().userName + "@tarena.com"
        //predicate
        let pre = NSPredicate(format: "streamBareJidStr=%@", jid)
        request.predicate = pre
        //sort
        let sort = NSSortDescriptor(key: "displayName", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        }catch let error as NSError {
            print("获取数据失败\(error)")
        }
        
        
        
    }
    
    func getContacts() ->[XMPPUserCoreDataStorageObject] {
        return fetchedResultsController.fetchedObjects as! [XMPPUserCoreDataStorageObject]
        
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.refreshData?()
    }
    
    
    
    
    
}
