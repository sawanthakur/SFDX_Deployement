@isTest
private class testPreventAccountDeletion {
    
    static testmethod void testPreventAccDel(){
        Account accRecord = new Account(name='testAccount');
        insert accRecord;
        
        try{
            delete accRecord;
        }catch(DMLexception e){
            system.assert(e.getMessage().contains('Account Cannot be deleted'),'Account Cannot be deleted');                       
        }
    }
}