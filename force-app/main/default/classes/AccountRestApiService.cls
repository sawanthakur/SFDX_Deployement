@RestResource(urlMapping='/v/credAccount/*')
global class AccountRestApiService {
    
    @HttpPost
    global static string doPost(){
        
        RestRequest resReq = RestContext.request; 
        blob jsonAccountString = resReq.requestBody; 
        List<Account> accountList = (List<Account>)JSON.deserialize(jsonAccountString.toString(), List<Account>.class);
        
        try{
            insert accountList;
        }catch(exception ex){
            return ex.getMessage();  
        } 
        return 'Record created successfully';
    }
    
    @httpPut
    global static string doPut(){
        RestRequest resReq = RestContext.request; 
        blob jsonAccountString = resReq.requestBody; 
        List<Account> accountList = (List<Account>)JSON.deserialize(jsonAccountString.toString(), List<Account>.class);
        
        System.debug('accountList::>>'+JSON.serialize(accountList));
        
        Map<String,Account> accountMap = new Map<String,Account>();
        Decimal count = 0;
        for(Account acc : accountList){
              accountMap.put(acc.UID__c, acc);
        }
        List<Account> updateAccount = new List<Account>();
        System.debug('Size of Map::>>'+accountMap.size());
        set<String> setOfUID = accountMap.keySet();//new set<Number>();
        
        Map<String, Account> existingAccountMap = new Map<String, Account>();
        for(Account acc : [SELECT Id, UID__c FROM Account WHERE UID__c IN: setOfUID]){
            existingAccountMap.put(acc.UID__c, acc);
        }
        for(Account acc : accountMap.values()){
            if(existingAccountMap.containsKey(acc.UID__c)){
                acc.Id = existingAccountMap.get(acc.UID__c).Id;
            }
            updateAccount.add(acc); 
            count =+ 1;
        }
         try{
            System.debug('updateAccount::>>'+JSON.serialize(updateAccount));
            upsert updateAccount;
            //update accountList;
        }catch(exception ex){
            System.debug('ex.getMessage()::>>'+ex.getMessage());
            return 'Count::>>'+count+'||'+ex.getMessage()+''+ex.getLineNumber();  
        } 
        
        return 'Record updated successfully';
    }
    
    @HttpPatch
    global static string doPatch(){
        
        RestRequest resReq = RestContext.request; 
        blob jsonAccountString = resReq.requestBody; 
        List<Account> accountList = (List<Account>)JSON.deserialize(jsonAccountString.toString(), List<Account>.class);
        
        System.debug('accountList::>>'+JSON.serialize(accountList));
        
        Map<String,Account> accountMap = new Map<String,Account>();
        Decimal count = 0;
        for(Account acc : accountList){
              accountMap.put(acc.UID__c, acc);
        }
        List<Account> updateAccount = new List<Account>();
        System.debug('Size of Map::>>'+accountMap.size());
        set<String> setOfUID = accountMap.keySet();//new set<Number>();
        for(Account acc : [SELECT Id, UID__c FROM Account WHERE UID__c IN: setOfUID ]){
            if(accountMap.containsKey(acc.UID__c)){
                Account newAccount = accountMap.get(acc.UID__c);
                newAccount.Id = acc.Id;
                updateAccount.add(newAccount); 
                count =+ 1;
            } 
        }
        
        try{
            System.debug('updateAccount::>>'+JSON.serialize(updateAccount));
            update updateAccount;
            //update accountList;
        }catch(exception ex){
            System.debug('ex.getMessage()::>>'+ex.getMessage());
            return 'Count::>>'+count+'||'+ex.getMessage()+''+ex.getLineNumber();  
        } 
        
        return 'Record updated successfully';
    } 
    
    @HttpDelete
    global static string doDelete(){
        
        RestRequest resReq = RestContext.request; 
        blob jsonAccountString = resReq.requestBody; 
        List<Account> accountList = (List<Account>)JSON.deserialize(jsonAccountString.toString(), List<Account>.class);
        
        System.debug('accountList::>>'+JSON.serialize(accountList));
        
        Map<String,Account> accountMap = new Map<String,Account>();
        Decimal count = 0;
        for(Account acc : accountList){
              accountMap.put(acc.UID__c, acc);
        }
        List<Account> deleteAccount = new List<Account>();
        set<String> setOfUID = accountMap.keySet();
        for(Account acc : [SELECT Id, UID__c FROM Account WHERE UID__c IN: setOfUID ]){
            if(accountMap.containsKey(acc.UID__c)){
                Account newAccount = accountMap.get(acc.UID__c);
                newAccount.Id = acc.Id;
                deleteAccount.add(newAccount); 
                count =+ 1;
            } 
        }
        
        try{
            System.debug('updateAccount::>>'+JSON.serialize(deleteAccount));
            delete deleteAccount; 
        }catch(exception ex){
            System.debug('ex.getMessage()::>>'+ex.getMessage());
            return 'Count::>>'+count+'||'+ex.getMessage()+''+ex.getLineNumber();  
        }
        return 'Record deleted successfully';
    }
}