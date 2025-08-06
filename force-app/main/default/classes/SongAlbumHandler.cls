/**
 * @description       : Handler class to manage song album assignments for insert and update operations
 * @author            : Valeria Cobian
 * @group             : 
 * @last modified on  : 08-06-2025
 * @last modified by  : Valeria Cobian
**/
public with sharing class SongAlbumHandler {
    /**
    * @description This method handles the before insert event for songs to assign the nearest album
    * @author Valeria Cobian | 08-06-2025 
    * @param newSongs List of new songs being inserted
    **/
    public static void handleBeforeInsertSong(List<Song__c> newSongs) {
        SongAlbumHelper.assignNearestAlbumBeforeInsert(newSongs);
    }
    /**
    * @description This method handles the before update event for songs to assign the nearest album
    * @author Valeria Cobian | 08-06-2025
    * @param newSongs List of new songs being updated
    * @param oldSongs List of old songs being updated
    **/
    public static void handleBeforeUpdateSong(List<Song__c> newSongs, List<Song__c> oldSongs) {
        SongAlbumHelper.assignNearestAlbumBeforeUpdate(newSongs, oldSongs);
    }
}