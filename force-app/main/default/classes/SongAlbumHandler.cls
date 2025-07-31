// Trigger handler for Song__c  to delegate logic to SongAlbumHelper
public with sharing class SongAlbumHandler {
    public static void handleBeforeInsertSong(List<Song__c> newSongs) {
        SongAlbumHelper.assignNearestAlbumOnInsert(newSongs);
    }
    public static void handleBeforeUpdateSong(List<Song__c> newSongs, List<Song__c> oldSongs) {
        SongAlbumHelper.assignNearestAlbumOnUpdate(newSongs, oldSongs);
    }
}