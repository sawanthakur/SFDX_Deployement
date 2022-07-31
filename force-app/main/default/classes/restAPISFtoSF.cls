public class restAPISFtoSF {
    
    private final String clientId = '3MVG9fe4g9fhX0E4mfTfX3jXeniyUHJyAhF7oDEubKxqHv4tdWfAgtHnjV7MUPW7CWchTnXiaFB8fbtRvXEUa';
    private final String clientSecret = '30008B706DA68268BD814CCFD565D0D3E9A4D44F340C67F0D0F6FD03439F5747';
    private final String username = 'sawanthakur150@salesforce.com';
    private final String password = '@conneX190587@';
    
    
    public class deserializeResponse{
        public String id;
        public String access_token;
    }
    
    public String ReturnAccessToken(){
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        
        /*String reqbody = 'grant_type=password'+
            '&client_id='+integrationDetails.Client_Id__c+
            '&client_secret='+integrationDetails.Client_Secret__c+
            '&username='+integrationDetails.User_Name__c+
            '&password='+integrationDetails.Password__c;*/
        System.debug('@@@@reqbody::>>'+reqbody);
        
        try{
            
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setBody(reqbody);
            req.setMethod('POST');
            req.setEndpoint(IntegrationDetails.End_Point_URL__c+'/services/oauth2/token');
            System.debug('@@@@Endpoint::>>'+IntegrationDetails.End_Point_URL__c+'/services/oauth2/token');
            HttpResponse res = h.send(req);
            if(res.getStatusCode() == 200){
                System.debug('Result::>> Success');
                deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
                system.debug('@@@@access_token@@'+resp1 );
                system.debug('@@@@access_token ::>>'+resp1.access_token);
                system.debug('@@@@access_token Id::>>'+resp1.id);
                return resp1.access_token;
            }else{
                System.debug('@@@@StatusCode::>>'+res.getStatusCode());
            }
            
        }catch(exception ex){
            System.debug('Error::>>'+ex.getMessage());
        }
        return null;
    }
    
    @Future(callout=true)
    public static void createAccount(String jsonstr){
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        restAPISFtoSF acount1 = new restAPISFtoSF();
        String accessToken = acount1.ReturnAccessToken();
        System.debug('jsonstr::>> '+jsonstr);
         
        if(accessToken != null){
            String endPoint = IntegrationDetails.End_Point_URL__c+'/services/apexrest/v/credAccount/'; 
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setBody(jsonstr);
            req1.setMethod('POST');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            system.debug('@@@RESPONSE@@'+trimmedResponse); 
        }
    }
    
    @Future(callout=true)
    public static void updateAccount(String jsonstr){
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        restAPISFtoSF acount1 = new restAPISFtoSF();
        String accessToken = acount1.ReturnAccessToken(); 
          
        if(accessToken != null){
            String endPoint = IntegrationDetails.End_Point_URL__c+'/services/apexrest/v/credAccount/'; 
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setBody(jsonstr);
            req1.setMethod('PATCH');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            system.debug('@@@RESPONSE@@'+trimmedResponse); 
        }
    }
    
    public static void upsertAccount(String jsonstr){
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        restAPISFtoSF acount1 = new restAPISFtoSF();
        String accessToken = acount1.ReturnAccessToken(); 
          
        if(accessToken != null){
            String endPoint = IntegrationDetails.End_Point_URL__c+'/services/apexrest/v/credAccount/'; 
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setBody(jsonstr);
            req1.setMethod('PUT');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            system.debug('@@@RESPONSE@@'+trimmedResponse); 
        }
    }
    
   @Future(callout=true)
    public static void deleteAccount(String jsonstr){
        deleteAccountCallout(jsonstr);
    }
    
    public static void deleteAccountCallout(String jsonstr){
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        restAPISFtoSF acount1 = new restAPISFtoSF();
        String accessToken = acount1.ReturnAccessToken(); 
         
        if(accessToken != null){
            String endPoint = IntegrationDetails.End_Point_URL__c+'/services/apexrest/v/credAccount/'; 
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setBody(jsonstr);
            req1.setMethod('DELETE');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            system.debug('@@@RESPONSE@@'+trimmedResponse); 
        } 
    }
    
    @Future(callout=true)
    public static void updateIntigrationSettings(String jsonstr){
        SF_Integration__c integrationDetails = SF_Integration__c.getOrgDefaults();
        restAPISFtoSF acount1 = new restAPISFtoSF();
        String accessToken = acount1.ReturnAccessToken();
        System.debug('updateIntigrationSettings Callout');
        if(accessToken != null){
            String endPoint = IntegrationDetails.End_Point_URL__c+'/services/apexrest/v/updateIntegrationSettings/'; 
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setBody(jsonstr);
            req1.setMethod('PATCH');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            system.debug('@@@RESPONSE@@'+trimmedResponse); 
        }
    }  
}