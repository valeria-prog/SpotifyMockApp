public with sharing class ArtistSelector {
     public static List<Artist__c> getAllArtists() {
        return [
            SELECT Id, Name, Genre__c
            FROM Artist__c
            ORDER BY Name ASC
        ];
    }

    // Get artist by Id
    public static Artist__c getArtistById(Id artistId) {
        List<Artist__c> artists = [
            SELECT Id, Name, Genre__c
            FROM Artist__c
            WHERE Id = :artistId
            LIMIT 1
        ];
        return artists.isEmpty() ? null : artists[0];
    }

    // Get artists by genre
    public static List<Artist__c> getArtistsByGenre(String genre) {
        return [
            SELECT Id, Name, Genre__c
            FROM Artist__c
            WHERE Genre__c = :genre
            ORDER BY Name ASC
        ];
    }
    public ArtistSelector() {

    }
}