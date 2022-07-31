@RestResource(urlMapping='/v/updateIntegrationSettings/*')
global class UpdateIntegrationSettings {
    
    @HttpPatch
    global static string doPatch(){
        
        RestRequest resReq = RestContext.request; 
        blob jsonAccountString = resReq.requestBody; 
        SF_Integration__c sfIntegration = (SF_Integration__c)JSON.deserialize(jsonAccountString.toString(), SF_Integration__c.class);
        
        System.debug('sfIntegration::>>'+JSON.serialize(sfIntegration));
        try{
            SF_Integration__c updateSfIntegration = SF_Integration__c.getOrgDefaults();
            updateSfIntegration.Org_dsable_to_sdinfo1__c = sfIntegration.Org_dsable_to_sdinfo1__c;
            updateSfIntegration.Org_sdinfo1_To_dsable__c = sfIntegration.Org_sdinfo1_To_dsable__c;
            updateSfIntegration.Allow_To_Both__c = sfIntegration.Allow_To_Both__c;
            updateSfIntegration.Sync_on_Schedule_Time__c = sfIntegration.Sync_on_Schedule_Time__c;
            System.debug('sfIntegration::>>'+JSON.serialize(updateSfIntegration));
            update updateSfIntegration;
            //update accountList;
            return 'Record updated successfully';
        }catch(exception ex){
            System.debug('ex.getMessage()::>>'+ex.getMessage());
            return ex.getMessage()+''+ex.getLineNumber();  
        }  
        
    }  
}