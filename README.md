# FindDupeImages

This is a simple gem to find duplicate images in a directory structure recursively. At the moment images greater than
8 MB will be ignored. This is due to the fact, that I observed a high memory consumption leading to use many
GB RAM. You can easily change this to another value by changing `MAX_FILE_SIZE` in find_dupe_images.rb.

## Technical idea

The process of comparing the images is this:

* traverse through the directory
* check if the mime-type is the one for an image (defined in `ImageMimeTypes`)
* open the image and read the bytes
* create an `Digest::MD5.hexdigest` of the content of the image
* Marshal.dump the digest and further info to a file (serialized.marshal)
* when all images are scanned, open the marshal file, run through it and find duplicate digests
* show the result

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'find_dupe_images'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install find_dupe_images

## Usage

It's as simple as this:

    $ find_dupe_images /your/path/to/images

where the directory images can contain directories with directories of images.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andywenk/find_dupe_images. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
