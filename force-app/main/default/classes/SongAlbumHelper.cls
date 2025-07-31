// Helper class to assign automatically the most recent Album to a Song
// when the Song is inserted or updated without an Album assigned.

public with sharing class SongAlbumHelper {
    // Core logic to assign the nearest album based on the artist
    private static void assignAlbums(List<Song__c> songsToAssign, Set<Id> artistIds) {
        // If there are no songs to assign or no artists, exit early
        if (songsToAssign.isEmpty() || artistIds.isEmpty()) {
            return;
        }
        // Map to hold the most recent album for each artist
        Map<Id, Album__c> artistToNewestAlbum = new Map<Id, Album__c>();

        for(Album__c album : [
            SELECT Id, Artist_Id__c, Release_Date__c
            FROM Album__c
            WHERE Artist_Id__c IN :artistIds
            ORDER BY Release_Date__c DESC
        ]) {
            // Only keep the most recent album for each artist
            if (!artistToNewestAlbum.containsKey(album.Artist_Id__c)) {
                artistToNewestAlbum.put(album.Artist_Id__c, album);
            }
        }
        // Assign the most recent album to each song
        // that does not already have an album assigned
        for(Song__c song : songsToAssign) {
            if (song.Artist_Id__c != null && artistToNewestAlbum.containsKey(song.Artist_Id__c)) {
                song.Album_Id__c = artistToNewestAlbum.get(song.Artist_Id__c).Id;
            }
        }
    }

    // Method to assign the nearest album on insert if the song does not have an album
    public static void assignNearestAlbumOnInsert(List<Song__c> newSongs) {
        List<Song__c> songsToAssign = new List<Song__c>();
        Set<Id> artistIds = new Set<Id>();

        for(Song__c song : newSongs) {
            if(song.Album_Id__c == null && song.Artist_Id__c != null) {
                songsToAssign.add(song);
                artistIds.add(song.Artist_Id__c);
            }
        }
            assignAlbums(songsToAssign, artistIds);
    }

    // Method to assign the nearest album on update if the song does not have an album
    public static void assignNearestAlbumOnUpdate(List<Song__c> newSongs, List<Song__c> oldSongs) {
        
        Map<Id, Song__c> oldMap = new Map<Id, Song__c>();
        List<Song__c> songsToAssign = new List<Song__c>();
        Set<Id> artistIds = new Set<Id>();

        for (Song__c song : newSongs) {
            Song__c oldSong = oldMap.get(song.Id);
            if (song.Album_Id__c == null && oldSong != null && oldSong.Album_Id__c == null && song.Artist_Id__c != null) {
                songsToAssign.add(song);
                artistIds.add(song.Artist_Id__c);
            }  
        }
        assignAlbums(songsToAssign, artistIds);
    }
}