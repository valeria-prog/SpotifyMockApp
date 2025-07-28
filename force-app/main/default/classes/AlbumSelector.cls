public with sharing class AlbumSelector {
    
        public static List<Album__c> getAlbums() {
        return [
            SELECT Id, Name, Artist_Id__c, Is_Public__c, Release_Date__c, Image__c
            FROM Album__c
            ORDER BY Release_Date__c DESC
        ];
        }
    public AlbumSelector() {

    }
}