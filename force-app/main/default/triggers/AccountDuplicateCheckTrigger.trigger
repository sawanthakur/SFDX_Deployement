trigger AccountDuplicateCheckTrigger on Account (before insert) {


       //Preparing Account names in Set from trigger.new

        Set<String> nameSet = new Set<String>();

        for(Account acc : trigger.new){

            nameSet.add(acc.name);        

        }

        // getting the list of accounts in database  with the account name we entered ( trigger.new)

        List<Account> accList = new List<Account>(
            [select id,name from Account where name in: nameSet]);

        for(Account a : trigger.new){

            if(accList.size() > 0 )
                a.addError('Account already exists in your Organization with name '+a.name);

        }

}