public with sharing class SongAlbumHelper {
    public static void assignNearestAlbum(List<Song__c> newSongs) {
        Map<Id, List<Song__c>> artistToSongs = new Map<Id, List<Song__c>>();

        for(Song__c song : newSongs) {
            if(song.Album_Id__c == null && song.Artist_Id__c != null) {
                if(!artistToSongs.containsKey(song.Artist_Id__c)) {
                    artistToSongs.put(song.Artist_Id__c, new List<Song__c>());
                }
                artistToSongs.get(song.Artist_Id__c).add(song);
            }
        }
        if(artistToSongs.isEmpty()) {
            return; 
        }

        Map<Id, Album__c> artistToNewestAlbum = new Map<Id, Album__c>();
        for (Album__c album : [
            SELECT Id, Artist_Id__c, CreatedDate
            FROM Album__c
            WHERE Artist_Id__c IN :artistToSongs.keySet()
            ORDER BY CreatedDate DESC
        ]) {

            if (!artistToNewestAlbum.containsKey(album.Artist_Id__c)) {
                artistToNewestAlbum.put(album.Artist_Id__c, album);
            }
        }

        for (Id artistId : artistToSongs.keySet()) {
            if (artistToNewestAlbum.containsKey(artistId)) {
                Id albumId = artistToNewestAlbum.get(artistId).Id;
                for (Song__c song : artistToSongs.get(artistId)) {
                    song.Album_Id__c = albumId;
                }
            }
        }
    }
}