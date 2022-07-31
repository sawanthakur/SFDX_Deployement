trigger AccountDelete on Account (before delete) {
for(Account acc: trigger.old)
    {
        acc.adderror('You can not Delete Account Record');
    }

}