# NAME 

spotify\_filter.pl

# SYNOPSIS

        perl spotify_filter.pl YourLibrary.json albums.json tracks album

# DESCRIPTION

Filter the `YourLibrary.json` from a Spotify data request. 

The tool can filter based on album, artist, or track name and output the filtered result as a new json file.

to 

# METHODS

## decode\_library 

Decode the `YourLibrary.json` file provided by spotify into a perl hash.

## filter\_library 

Given our decoded library, return a hash showing each unique item and the amount of times it shows up in our library `$section` based on our `$filter`.

## write\_output 

Write back a json file with our filtered library hash.
