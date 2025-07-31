/**
 * @description       : 
 * @author            : Valeria Cobian
 * @group             : 
 * @last modified on  : 07-31-2025
 * @last modified by  : Valeria Cobian
**/
public with sharing class SongAlbumHandler {
    public static void handleBeforeInsertSong(List<Song__c> newSongs) {
        SongAlbumHelper.assignNearestAlbumOnInsert(newSongs);
    }
    public static void handleBeforeUpdateSong(List<Song__c> newSongs, List<Song__c> oldSongs) {
        SongAlbumHelper.assignNearestAlbumOnUpdate(newSongs, oldSongs);
    }
}