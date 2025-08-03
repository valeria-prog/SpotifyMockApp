/**
 * @description       : Class to assist with assigning the nearest album to songs if the song doesn't have one assigned.
 * @author            : Valeria Cobian
 * @group             : 
 * @last modified on  : 08-02-2025
 * @last modified by  : Valeria Cobian
**/
public with sharing class SongAlbumHelper {
    /**
    * @description       : Method to assign the nearest album to songs if the song doesn't have one assigned.
    * @author            : Valeria Cobian | 08-02-2025
    * @param songs       : List of songs to process
    **/
    public static void assignNearestAlbum(List<Song__c> songs) {
        if (songs.isEmpty()) {
            return;
        }

        List<Song__c> songsToAssign = new List<Song__c>();
        Set<Id> artistIds = new Set<Id>();
        for (Song__c song : songs) {
            if (song.Album_Id__c == null && song.Artist_Id__c != null) {
                songsToAssign.add(song);
                artistIds.add(song.Artist_Id__c);
            }
        }
        if (songsToAssign.isEmpty() || artistIds.isEmpty()) {
            return;
        }

        Map<Id, Album__c> artistToNewestAlbum = new Map<Id, Album__c>();
        for (Album__c album : [
            SELECT Id, Artist_Id__c, Release_Date__c
            FROM Album__c
            WHERE Artist_Id__c IN :artistIds
            ORDER BY Release_Date__c DESC
        ]) {
            if (!artistToNewestAlbum.containsKey(album.Artist_Id__c)) {
                artistToNewestAlbum.put(album.Artist_Id__c, album);
            }
        }

        for (Song__c song : songsToAssign) {
            if (artistToNewestAlbum.containsKey(song.Artist_Id__c)) {
                song.Album_Id__c = artistToNewestAlbum.get(song.Artist_Id__c).Id;
            }
        }
    }
}