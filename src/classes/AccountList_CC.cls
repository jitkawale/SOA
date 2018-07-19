/**************************************************************************************************************
Component Name: AccountList_CC
Description : This class is used as a controller of AccountList component
Author : Jitendra Kawale (Jitkawale@gmail.com)
Date 20th July 2018
***************************************************************************************************************/
Public with sharing class AccountList_CC {
    @auraEnabled 
    public static List<Account> getRecentAccounts() {
        return [Select Id, Name, Createddate, LastModifiedDate FROM Account ORDER By Createddate DESC LIMIT 10];
    }
}