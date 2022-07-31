trigger prefixdoc on Lead (before insert) {
  for (Lead l : Trigger.new){
    if (l.FirstName == null) {
      l.FirstName = '';
    }
    l.FirstName = 'Dr.'+ l.FirstName;
  }
}