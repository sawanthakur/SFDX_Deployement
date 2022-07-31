global class BatchContactUpdate implements Database.Batchable<sobject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        
        string query='select Id,Name,Title from Contact';
        return database.getQueryLocator(query);
    }
    global void execute(database.BatchableContext BC ,List<Contact> scope)
    {
        system.debug('Execute Method called');
        for(contact c:scope)
        {
            c.Title= c.Title+'***';
        }
        update scope;
    }
    global void finish(database.BatchableContext BC)
    {
        system.debug('Finish Method called');
    }
}