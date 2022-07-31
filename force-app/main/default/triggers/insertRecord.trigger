trigger insertRecord on Integration__c (after insert, after update) {

    for(Integration__c intt: trigger.new) {
        // callRestService.callPostMethod(false, intt.Name, intt.Email_Id__c, intt.Mobile__c, intt.Date__c);
    }
}