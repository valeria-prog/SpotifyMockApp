// Trigger for Song__c to assign the nearest album based on artist before insert and update 
// if the album is not set.
// This trigger calls the SongAlbumHandler to handle the logic
trigger SongTrigger on Song__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            SongAlbumHandler.handleBeforeInsertSong(Trigger.new);
        }
        if (Trigger.isUpdate) {
            SongAlbumHandler.handleBeforeUpdateSong(Trigger.new, Trigger.old);
        }
    }
}