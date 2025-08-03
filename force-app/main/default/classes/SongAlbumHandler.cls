/**
 * @description       : Handler class for Song__c records to assign the nearest album.
 * @author            : Valeria Cobian
 * @group             : Bebotes
 * @last modified on  : 08-02-2025
 * @last modified by  : Valeria Cobian
**/
public with sharing class SongAlbumHandler {
    /**
    * @description This method handles the before insert and update events for Song__c records.
    * @author Valeria Cobian | 08-01-2025 
    * @param newSongs Defines the list of songs to which the nearest album will be assigned.
    **/
    public static void handleSongTrigger(List<Song__c> newSongs) {
        SongAlbumHelper.assignNearestAlbum(newSongs);
    }
}