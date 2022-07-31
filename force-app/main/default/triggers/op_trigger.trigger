trigger op_trigger on Opportunity (before insert) {
trigger_class.check_opp(Trigger.New);

}