trigger Iaccount on Account (before Insert, before Update) {
for(Account acc: trigger.new)
{
 if(acc.Industry=='Education')
 acc.adderror('We do not work with Education Org anymore');
}
}