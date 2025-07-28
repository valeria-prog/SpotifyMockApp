public with sharing class SongSelector {
     public static List<Song__c> getUpcomingSongs() {
        return [
            SELECT Id, Name, Album_Id__c, Artist_Id__c, Release_Date__c, Duration__c
            FROM Song__c
            WHERE Release_Date__c > :Date.today()
            ORDER BY Release_Date__c ASC
        ];
    }

    public static List<Song__c> getNextSongs(Integer limitSize) {
        return [
            SELECT Id, Name, Album_Id__c, Artist_Id__c, Release_Date__c, Duration__c
            FROM Song__c
            WHERE Release_Date__c >= :Date.today()
            ORDER BY Release_Date__c ASC
            LIMIT :limitSize
        ];
    }

    public static List<Song__c> getSongsFromAlbum(Id albumId) {
        return [
            SELECT Id, Name, Album_Id__c, Artist_Id__c, Release_Date__c, Duration__c
            FROM Song__c
            WHERE Album_Id__c = :albumId
            ORDER BY Release_Date__c ASC
        ];
    }
    public SongSelector() {

    }
}