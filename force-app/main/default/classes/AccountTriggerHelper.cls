public class AccountTriggerHelper {
    public static void createAccounts(List<Account> accountList){
        System.debug('Called Account Trigger Create');
        if(checkCalloutPermission()){
            restAPISFtoSF.createAccount(JSON.serialize(removeRecordId(accountList)));
        }
    }
    
    public static void updateAccounts(List<Account> accountList){
        System.debug('Called Account Trigger Update');
        if(checkCalloutPermission()){
            restAPISFtoSF.updateAccount(JSON.serialize(removeRecordId(accountList)));  
        }
    }
    
    public static void deleteAccounts(List<Account> accountList){
        System.debug('Called Account Trigger Delete');
        List<Deleted_Records_UID__c> deletedUID = new List<Deleted_Records_UID__c>();
        for(Account acc : accountList){
            deletedUID.add(new Deleted_Records_UID__c(Name = acc.UID__c));
        }
        insert deletedUID;
        if(checkCalloutPermission()){
            restAPISFtoSF.deleteAccount(JSON.serialize(removeRecordId(accountList)));
        }
    }
    
    public static void deleteStoredUID(List<Account> accountList){
        Set<String> accountUidSet = new Set<String>();
        for(account acc : accountList){
            accountUidSet.add(acc.UID__c);
        }
        List<Deleted_Records_UID__c> DeletedRecordsUIDList = new List<Deleted_Records_UID__c>([SELECT Id FROM Deleted_Records_UID__c WHERE Name IN:accountUidSet]);
        if(DeletedRecordsUIDList != null && !DeletedRecordsUIDList.isEmpty()){
            delete DeletedRecordsUIDList;
        }
    }
    
    public static List<Account> removeRecordId(List<Account> accountList){
        List<Account>modifiedAccountList = new List<Account>();
        for(Account acc : accountList){ 
            modifiedAccountList.add(new Account(Name=acc.Name, UID__c = acc.UID__c));
        }
        return modifiedAccountList;
    }
    
    public static boolean checkCalloutPermission(){
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults(); 
        List<Organization> orgDetails = [SELECT Id, Name, Division, InstanceName FROM Organization Limit 1];
        if(integrationDetails.Allow_To_Both__c || ((integrationDetails != null && integrationDetails.Org_Name__c != null) &&
           (integrationDetails.Org_dsable_to_sdinfo1__c && integrationDetails.Org_Name__c == 'AP24'||
            integrationDetails.Org_sdinfo1_To_dsable__c && integrationDetails.Org_Name__c == 'AP4'))
            
          ){
              return true;
          }else{
              return false;
          }
    }
}