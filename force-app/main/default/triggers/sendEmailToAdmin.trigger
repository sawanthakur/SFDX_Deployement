trigger sendEmailToAdmin on Account (after insert){

    if(trigger.IsAfter && trigger.IsInsert){
        sentEmailToSystemAdminHandler sETSA = new sentEmailToSystemAdminHandler();
        sETSA.sendEmailAfterCreationOfAccount(trigger.new);
    }
}