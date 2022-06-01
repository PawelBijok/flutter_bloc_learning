import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/models/artist/artist.dart';
import 'package:bloc_learning/models/image/image.dart';

const List<Album> fakeAlbumsList = [
  Album(
    id: 'album1',
    name: 'Name 1',
    totalTracks: 2,
    releaseDate: '2020-02-02',
    artists: [
      Artist(id: 'artist1', name: 'Artist 1'),
    ],
    images: [
      Image(
        url: 'https://fakeimg.pl/300',
        height: 600,
        width: 600,
      ),
      Image(
        url: 'https://fakeimg.pl/300',
        height: 300,
        width: 300,
      ),
    ],
  ),
];
const List<Album> fakeAlbumsList2 = [
  Album(
    id: 'album1',
    name: '1 name',
    totalTracks: 2,
    releaseDate: '2020-02-04',
    artists: [
      Artist(id: 'artist1', name: 'Artist 1'),
    ],
    images: [
      Image(
        url: 'https://fakeimg.pl/300',
        height: 600,
        width: 600,
      ),
      Image(
        url: 'https://fakeimg.pl/300',
        height: 300,
        width: 300,
      ),
    ],
  ),
];
const List<Album> fakeAlbumsListNoArtists = [
  Album(
    id: 'album1',
    name: '1 name',
    totalTracks: 2,
    releaseDate: '2020-02-04',
    images: [
      Image(
        url: 'https://fakeimg.pl/300',
        height: 600,
        width: 600,
      ),
      Image(
        url: 'https://fakeimg.pl/300',
        height: 300,
        width: 300,
      ),
    ],
  ),
];
