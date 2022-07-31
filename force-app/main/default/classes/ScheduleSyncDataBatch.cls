public class ScheduleSyncDataBatch implements Schedulable {
    public void execute(SchedulableContext sc) {
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        System.debug('integrationDetails.Sync_on_Schedule_Time__c::>>'+integrationDetails.Sync_on_Schedule_Time__c);
        if(integrationDetails.Sync_on_Schedule_Time__c){
            deleteAccount();
        }
        if(Test.isRunningTest()){
            deleteAccount();
        }
    }
    
    public void deleteAccount(){
        List<Account> accountsToDelete = new List<Account>();
        System.debug('deleteAccount Called from Schedule');
        List<Deleted_Records_UID__c> DeletedRecordUIDList = new List<Deleted_Records_UID__c>([SELECT Id, Name FROM Deleted_Records_UID__c WHERE CreatedDate >= TODAY]);  
        System.debug('DeletedRecordUIDList Size::>>'+DeletedRecordUIDList.size());
        for(Deleted_Records_UID__c deletedRecord : DeletedRecordUIDList){
            //deletedRecords.CreatedDate
            accountsToDelete.add(new Account(UID__c = deletedRecord.Name));
            System.debug('deleteAccount Called for loop');
        }
        if(accountsToDelete != null && !accountsToDelete.isEmpty()){
            System.debug('deleteAccount Called :: Schedule Batch::');
            SyncDataFromSFtoSFBatch myBatchObject = new SyncDataFromSFtoSFBatch(accountsToDelete, 'deleteOperation');
            Database.executeBatch(myBatchObject);
            delete DeletedRecordUIDList;
        }else{
            upsertAccounts();
        }
    }
    
    public static void upsertAccounts(){
        List<Account> upsertAccount = new List<Account>([SELECT Id, Name, UID__c FROM Account WHERE LastModifiedDate = today]);
        if(!upsertAccount.isEmpty()){
            upsertAccount = AccountTriggerHelper.removeRecordId(upsertAccount);
            SyncDataFromSFtoSFBatch myBatchObject = new SyncDataFromSFtoSFBatch(upsertAccount, 'upsertOperation');
            Database.executeBatch(myBatchObject);
        }
    }
}