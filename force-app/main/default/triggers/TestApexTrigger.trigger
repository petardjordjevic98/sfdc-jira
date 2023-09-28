trigger TestApexTrigger on Account (before insert) {
    System.debug('123');
}