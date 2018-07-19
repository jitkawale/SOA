/**************************************************************************************************************
Component Name: ContactTrigger
Description : This Trigger is used to count number of contacts related to account
Author : Jitendra Kawale (Jitkawale@gmail.com)
Date 20th July 2018
***************************************************************************************************************/
trigger ContactTrigger on Contact (After insert, After update, After delete, After undelete) {
    Set<Id> accountIdsSet = new Set<Id>();
    List<Account> accountsToUpdate = new List<Account>();
    If(Trigger.IsAfter){
        // User Trigger.New to collect accountId for Insert and Undelete operation
        If(Trigger.IsInsert || Trigger.IsUndelete){
            for(Contact c : Trigger.new){
                if(c.AccountId != null){   
                   accountIdsSet.add(c.AccountId); 
                }
            }
        }
        // User Trigger.New to collect accountId for Update AccountId operation
        If(Trigger.IsUpdate){
            for(Contact c : Trigger.new){
                // Check if accountId changed in case of update operation. If AccountId is changed add both accountId to update
                if(c.AccountId != null && c.AccountId != Trigger.oldMap.get(c.Id).AccountId ){   
                   accountIdsSet.add(c.AccountId); 
                   accountIdsSet.add(Trigger.oldMap.get(c.Id).AccountId );
                }
            }
            
        }
        // User Trigger.old to collect accountId for delete operation
        If(Trigger.IsDelete){
            for(Contact c : Trigger.Old){
                if(c.AccountId != null){   
                   accountIdsSet.add(c.AccountId); 
                }
            }
        }
    }
    //Query on accounts to get related contacts with inner query
    List<Account> accountList = new List<Account>([Select id ,Name, Number_of_Contacts__c, (Select id, Name From Contacts) from Account Where id IN : accountIdsSet ]);
    for(Account acc : accountList){
        List<Contact> contactList = acc.Contacts;
        acc.Number_of_Contacts__c = contactList.size();
        accountsToUpdate.add(acc);
    }
    try{
        update accountsToUpdate;
    }catch(System.Exception e){
        
    }
}