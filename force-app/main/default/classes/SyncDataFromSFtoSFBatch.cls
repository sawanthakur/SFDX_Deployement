public class SyncDataFromSFtoSFBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    //public static Set<String> accountUIDSet = new Set<String>();
    public List<Account> accountList = new List<Account>();
    public string batchOperation;
    
    public SyncDataFromSFtoSFBatch(List<Account> accountList, String batchOperation){
        this.accountList = accountList;
        this.batchOperation = batchOperation;
    }
    public Iterable<sobject>  start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        //String query = 'SELECT Id, Name FROM Account WHERE UID__c IN: accountUIDSet';
        //return Database.getQueryLocator(query);
        System.debug('accountList::>>'+JSON.serialize(accountList));
        return accountList;
    }

    public void execute(Database.BatchableContext bc, List<Account> records){
        System.debug('execute'+JSON.serialize(records));
        if(batchOperation == 'deleteOperation'){
            restAPISFtoSF.deleteAccountCallout(JSON.serialize(records));
        }
        if(batchOperation == 'upsertOperation'){
            restAPISFtoSF.upsertAccount(JSON.serialize(records));
        }
        
    }    

    public void finish(Database.BatchableContext bc){
        System.debug('finish');
        if(batchOperation == 'deleteOperation'){
            ScheduleSyncDataBatch.upsertAccounts();
        }
    }
}