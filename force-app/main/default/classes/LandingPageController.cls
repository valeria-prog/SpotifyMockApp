public with sharing class LandingPageController {
    @AuraEnabled(cacheable=true)
    public static List<Album__c> getRecentAlbums() {
        return AlbumSelector.getAlbums();
    }

    @AuraEnabled(cacheable=true)
    public static List<Song__c> getUpcomingSongs() {
        return SongSelector.getUpcomingSongs();
    }

    @AuraEnabled(cacheable=true)
    public static List<Song__c> getNextSongs(Integer limitSize) {
        return SongSelector.getNextSongs(limitSize);
    }

    @AuraEnabled(cacheable=true)
    public static List<Playlist__c> getUserPlaylists(Id userId) {
        return PlaylistSelector.getPlaylistsFromUser(userId);
    }

    @AuraEnabled(cacheable=true)
    public static List<Playlist__c> getUserPrivatePlaylists(Id userId) {
        return PlaylistSelector.getPrivatePlaylists(userId);
    }

    @AuraEnabled(cacheable=true)
    public static List<Artist__c> getAllArtists() {
        return ArtistSelector.getAllArtists();
    }
}