trigger HelloWorld on Account (before insert, before update) {
List<Account> acc= trigger.new;
HelloWorld my= new HelloWorld();
my.addHelloWorld(acc);
}