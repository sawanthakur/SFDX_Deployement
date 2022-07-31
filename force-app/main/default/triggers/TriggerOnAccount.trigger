trigger TriggerOnAccount on Account (after insert, after update, after delete) {
    
    if(trigger.isAfter){
        RestRequest request = RestContext.request;
        if(request != null){
            Map<String,String> requestHeaders = request.headers;
            
            if (requestHeaders.containsKey('Sfdc-Stack-Depth') && '1'.equals(requestHeaders.get('Sfdc-Stack-Depth'))){
                System.debug('Do not calllout as it will cause a callout loop error');
            }else{
                System.debug('Not Contains sfdc-Stack-Depth');
                if(trigger.isInsert){
                    AccountTriggerHelper.createAccounts(trigger.new);
                }else if(trigger.isUpdate){
                    AccountTriggerHelper.updateAccounts(trigger.new);
                }else if(trigger.isDelete){
                    AccountTriggerHelper.deleteAccounts(trigger.old);
                }
            }
            
        }else{
            if(trigger.isInsert){
                AccountTriggerHelper.createAccounts(trigger.new);
            }else if(trigger.isUpdate){
                AccountTriggerHelper.updateAccounts(trigger.new);
            }else if(trigger.isDelete){
                AccountTriggerHelper.deleteAccounts(trigger.old);
            }
        }
        
       if(trigger.isUndelete){
            AccountTriggerHelper.deleteStoredUID(trigger.new);
        } 
    }
}