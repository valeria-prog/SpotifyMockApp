/**
 * @description       : Helper class to assign automatically the most recent Album to a Song
 * @author            : Valeria Cobian
 * @group             : 
 * @last modified on  : 08-06-2025
 * @last modified by  : Valeria Cobian
**/

public with sharing class SongAlbumHelper {
    /**
    * @description Private method that prepares and executes the logic to assign the nearest album to songs without an album
    * @author Valeria Cobian | 08-06-2025 
    * @param songsToAssign  List of songs to assign the nearest album
    **/
    private static void assignNearestAlbums(List<Song__c> songsToAssign) {
        Set<Id> artistIds = new Set<Id>();
        Map<Id, Album__c> artistToNewestAlbum = new Map<Id, Album__c>();

        if (songsToAssign == null || songsToAssign.isEmpty()) {
            return;
        }

        for(Song__c song : songsToAssign) {
            if(song.Artist_Id__c != null && song.Album_Id__c == null) {
                artistIds.add(song.Artist_Id__c);
            }
        }
        if (artistIds.isEmpty()) {
            return;
        }

        for(Album__c album : [
            SELECT Id, Artist_Id__c, Release_Date__c
            FROM Album__c
            WHERE Artist_Id__c IN :artistIds
            ORDER BY Release_Date__c DESC
        ]) {

            if (!artistToNewestAlbum.containsKey(album.Artist_Id__c)) {
                artistToNewestAlbum.put(album.Artist_Id__c, album);
            }
        }
        for(Song__c song : songsToAssign) {
            if (song.Album_Id__c == null && artistToNewestAlbum.containsKey(song.Artist_Id__c)) {
                song.Album_Id__c = artistToNewestAlbum.get(song.Artist_Id__c).Id;
            }
        }
    }
    
    /**
    * @description Method to assign the nearest album to songs before insert
    * @author Valeria Cobian | 08-06-2025 
    * @param newSongs List of new songs being inserted
    **/
    public static void assignNearestAlbumBeforeInsert(List<Song__c> newSongs) {
        if (newSongs == null || newSongs.isEmpty()) {
            return;
        }
        assignNearestAlbums(newSongs);
    }

    /**
    * @description Method to assign the nearest album to songs before update
    * @author Valeria Cobian | 08-06-2025
    * @param newSongs List of new songs being updated
    * @param oldSongs List of old songs being updated
    **/
    public static void assignNearestAlbumBeforeUpdate(List<Song__c> newSongs, List<Song__c> oldSongs) {

        if (newSongs == null || newSongs.isEmpty() || oldSongs == null || oldSongs.isEmpty()) {
          return;
        }

        List<Song__c> songsNeedingAlbum = new List<Song__c>();
        for (Integer i=0; i < newSongs.size(); i++) {
            Song__c newSong = newSongs[i];
            Song__c oldSong = oldSongs[i];

            if (newSong.Album_Id__c == null && (oldSong.Album_Id__c == null || newSong.Artist_Id__c != oldSong.Artist_Id__c)) {
                songsNeedingAlbum.add(newSong);
            }
        }
        if (songsNeedingAlbum.isEmpty()) {
            return;
        }
        assignNearestAlbums(songsNeedingAlbum);
    }
}