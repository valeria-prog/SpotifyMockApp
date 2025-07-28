public with sharing class PlaylistSelector {
    public static Playlist__c getLastModified() {
        List<Playlist__c> playlists = [
            SELECT Id, Name, OwnerId, Is_Private__c, LastModifiedDate
            FROM Playlist__c
            ORDER BY LastModifiedDate DESC
            LIMIT 1
        ];
        return playlists.isEmpty() ? null : playlists[0];
    }

    //all playlists for a specific user
    public static List<Playlist__c> getPlaylistsFromUser(Id userId) {
        return [
            SELECT Id, Name, OwnerId, Is_Private__c, LastModifiedDate
            FROM Playlist__c
            WHERE OwnerId = :userId
            ORDER BY LastModifiedDate DESC
        ];
    }

    // for a specific user private playlist 
    public static List<Playlist__c> getPrivatePlaylists(Id userId) {
        return [
            SELECT Id, Name, OwnerId, Is_Private__c, LastModifiedDate
            FROM Playlist__c
            WHERE OwnerId = :userId AND Is_Private__c = true
            ORDER BY LastModifiedDate DESC
        ];
    }
    public PlaylistSelector() {

    }
}