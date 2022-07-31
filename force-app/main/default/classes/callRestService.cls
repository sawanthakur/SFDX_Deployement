public with sharing class callRestService {
   private static String restmServiceOrg2Domain = 'https://d5g000003ce3weau-dev-ed.my.salesforce.com';
    
    /* private static String getAuthToken() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String token = '';
        
        RestServiceSettings__c setting = RestServiceSettings__c.getOrgDefaults();
        String clientId = setting.ClientId__c;
        String clientSecret = setting.ClientSecret__c;
        req.setMethod('POST');
        req.setEndpoint(restmServiceOrg2Domain+'/services/oauth2/token');
        req.setBody('grant_type=password' +
                   '&client_id=' + clientId +
                   '&client_secret=' + clientSecret +
                   '&username=' + EncodingUtil.urlEncode(setting.Username__c, 'UTF-8') +
                   '&password=' + EncodingUtil.urlEncode(setting.password__c + setting.Security_Token__c, 'UTF-8'));
        HTTPResponse res = http.send(req);
        System.debug('BODY: '+res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());
        
        Map<String, Object> mapObj = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        for(String s : mapObj.keySet()) {
            System.debug(s);
            if(s == 'access_token') {
               token = mapObj.get(s).toString(); 
            }
        }
        
        return token;
        
    }

    @future (callout=true)
    public static void callPostMethod(Boolean byNamedCredentials, String name, String email, Integer phone, String date1 ) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        if(byNamedCredentials) {
            req.setEndpoint('callout:SalesforceOrg2/services/apexrest/Integrations/Demo1');
        } else { 
            String token = getAuthToken();
            if(String.isEmpty(token)) {
                System.debug('Token not received');
                return;
            }
            req.setEndpoint(restmServiceOrg2Domain+'/services/apexrest/Integrations');
            //OAuth header
            req.setHeader('Authorization', 'Bearer ' + token);
        }
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        //req.setBody(body);
        System.debug('Calling Integration Service');
        HTTPResponse res = http.send(req);
        //System.debug(res.getBody());
        if(res.getStatusCode() !=201 &&res.getStatusCode() !=200) {
        System.debug('The status code returned was not expected: '+
                    res.getStatusCode() + ' ' + res.getStatus());            
        } else {
            Integration__c intt = new Integration__c();
            intt.Name = name;
            intt.Date__c = date.ValueOf(date1);
            intt.Email_Id__c = email;
            intt.Mobile__c = phone;
            insert intt;
            System.debug(res.getBody());
            System.debug('Record Inserted '+intt);
        }
        
        if(byNamedCredentials) {
			Integer i=0;
			while (res.getStatusCode() == 302) {
			System.debug('iterate '+i + ': '+res.getBody());
        	req.setEndpoint(res.getHeader('Location'));
			res = new Http().send(req);
        	}

        } 
        
    }
    
    public static void callGetMethod(Boolean byNamedCredentials, String Name) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
            req.setMethod('GET');
        if(byNamedCredentials) {
            req.setEndpoint('callout:SalesforceOrg2/services/apexrest/Integrations/Demo1');
        } else { 
            String token = getAuthToken();
            system.debug('Token Received '+token);
            if(String.isEmpty(token)) {
                System.debug('Token not received');
                return;
            }
            req.setEndpoint(restmServiceOrg2Domain+'/services/apexrest/Integrations/'+Name);
            req.setHeader('Authorization', 'Bearer ' + token);
            req.setHeader('Content-Type', 'application/json');
        }
        
        System.debug('Calling Integration Service');
        HTTPResponse res = http.send(req);
        System.debug( res.getBody() );
        
        if(byNamedCredentials) {
			while (res.getStatusCode() == 302) {
        	req.setEndpoint(res.getHeader('Location'));
			res = new Http().send(req);
        	}
			System.debug(res.getBody());
        }
        
    }
*/
}