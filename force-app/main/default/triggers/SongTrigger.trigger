/**
 * @description       : Trigger for Song__c to assign the nearest album based on artist before insert and update
 * @author            : Valeria Cobian
 * @group             : Bebotes
 * @last modified on  : 08-01-2025
 * @last modified by  : Valeria Cobian
**/
trigger SongTrigger on Song__c (before insert, before update) {
    SongAlbumHandler.handleSongTrigger(Trigger.new);
}