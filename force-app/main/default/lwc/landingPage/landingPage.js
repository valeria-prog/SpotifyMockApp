import { LightningElement } from 'lwc';
import getUpcomingSongs from '@salesforce/apex/LandingPageController.getUpcomingSongs';
import getRecentAlbums from '@salesforce/apex/LandingPageController.getRecentAlbums';


export default class LandingPage extends LightningElement {
    upcomingSongs;
    recentAlbums;
    albums;

    async connectedCallback() {
        try {
            this.upcomingSongs = await getUpcomingSongs();
            this.recentAlbums = await getRecentAlbums();
            this.albums = await getAlbums();
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    }
}