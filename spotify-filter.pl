#/usr/lib/perl
use strict;
use warnings;
use JSON;

=head1 NAME 

spotify-filter.pl

=cut

=head1 SYNOPSIS

	perl spotify-filter.pl YourLibrary.json albums.json tracks album

=cut

=head1 DESCRIPTION

Filter the C<YourLibrary.json> from a Spotify data request. 

The tool can filter based on album, artist, or track name and output the filtered result as a new json file.

to 


=cut


=head1 METHODS
=cut


sub usage {
    print "USAGE: perl converter.pl INPUT_FILENAME.json OUTPUT_FILENAME.json tracks album|artist\n"
}

=head2 decode_library 

Decode the C<YourLibrary.json> file provided by spotify into a perl hash.

=cut

sub decode_library {
    my ($filename) = @_;
    my $library = do {
        open(my $fh, "<:encoding(UTF-8)", $filename)
          or die("Can't open \"$filename\": $!\n");
        local $/;
        <$fh>
    };
    return from_json($library);
}

=head2 filter_library 

Given our decoded library, return a hash showing each unique item and the amount of times it shows up in our library C<$section> based on our C<$filter>.

=cut 


sub filter_library {
	my ($library, $section, $filter) = @_;

	my %unique_items = ();
	for ( @{$library->{$section}} ) {
		my $item = $_->{$filter};
		if ($unique_items{$item}){
			$unique_items{$item}++;
		}
		else {
			$unique_items{$item} = 1;
		}
	}
	return \%unique_items;
}

=head2 write_output 

Write back a json file with our filtered library hash.

=cut

sub write_output {
    my ($output_file, $library) = @_;
	
	# it feels bad to declare an object here and add two more lines but to_json doesn't have pretty print
	my $json = JSON->new();
	$json->pretty(1);
    open(FH,">:encoding(UTF-8)", $output_file) or die $!;
    print FH $json->encode($library);
    close(FH);
    
    return 1;
}

sub main {
    my ($input_file, $output_file, $section, $filter) = @ARGV;
    die usage() unless $input_file and $output_file and $section and $filter;

    my $library = decode_library($input_file);
    my $filtered_library = filter_library($library, $section, $filter);
    die "problem writing to $output_file" unless write_output($output_file, $filtered_library);

}

main();


