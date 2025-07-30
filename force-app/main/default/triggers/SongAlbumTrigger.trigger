trigger SongAlbumTrigger on Song__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            SongAlbumHandler.beforeInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            SongAlbumHandler.beforeUpdate(Trigger.new, Trigger.old);
        }
    }
}