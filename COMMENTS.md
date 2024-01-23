# Comments

## Running the exercise

### Input files

This exercise solution requires three CSV files to be present in this project's `data` directory:

- plans.csv
- slcsp.csv
- zips.csv

The versions of those CSV files included in the exercise instructions are included in this repository. To run with different input files, replace the existing ones in the `data` directory.

### How to run

- Install Ruby 3.3.0 in your development environment.
- Clone this repository.
- Install required libraries with bundler.
  - Run `gem install bundler`, if you haven't previously done so for Ruby 3.3.0
  - Run `bundle install`
- From the root of the project directory, run: `ruby slcsp_exercise.rb`

## Tests

Unit tests, written in MiniTest, are in the `test` directory.

To run the test suite, execute: `rake test`
