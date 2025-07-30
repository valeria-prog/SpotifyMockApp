public with sharing class SongAlbumHandler {
    public static void beforeInsert(List<Song__c> newSongs) {
        SongAlbumHelper.assignNearestAlbum(newSongs);
    }
    public static void beforeUpdate(List<Song__c> newSongs, List<Song__c> oldSongs) {
        SongAlbumHelper.assignNearestAlbum(newSongs);
    }
}