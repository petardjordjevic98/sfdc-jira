trigger TestApexTrigger on Account (before insert) {
    System.debug('123');
    System.debug('123');

}