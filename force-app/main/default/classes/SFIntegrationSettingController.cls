public class SFIntegrationSettingController {
    
    @AuraEnabled
    public static SF_Integration__c getSFIntegrationSetting() {
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        
        return integrationDetails;
        //return ('Hello from the server');
    }
    
    @AuraEnabled
    public static resultClass saveSFIntegrationSetting(SF_Integration__c integrationDetails) {
        System.debug('SFIntegration Method Call.');
        resultClass result = new resultClass();
        try{
            SF_Integration__c sfIntegerationToUpdate = new SF_Integration__c();
            sfIntegerationToUpdate.Id = integrationDetails.Id;
            sfIntegerationToUpdate.Org_dsable_to_sdinfo1__c = integrationDetails.Org_dsable_to_sdinfo1__c;
            sfIntegerationToUpdate.Org_sdinfo1_To_dsable__c = integrationDetails.Org_sdinfo1_To_dsable__c;
            sfIntegerationToUpdate.Allow_To_Both__c = integrationDetails.Allow_To_Both__c;
            sfIntegerationToUpdate.Sync_on_Schedule_Time__c = integrationDetails.Sync_on_Schedule_Time__c;
            System.debug('SerializeData::>> '+JSON.serialize(sfIntegerationToUpdate));
            update sfIntegerationToUpdate;
            restAPISFtoSF.updateIntigrationSettings(JSON.serialize(sfIntegerationToUpdate));
            result.Message = 'Successfully Updated.';
            result.Status = 'Success';
        }catch(exception ex){
            result.Message = ex.getMessage();
            result.Status = 'Error';
            
            System.debug('ERROR::>> '+ex.getMessage());
        }
        return result;
    }
    
    public class resultClass{
        public string Message;
        public string Status;
    }

}