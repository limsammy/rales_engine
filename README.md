# How to Setup

This readme will walk you through the setup and installation of this app.

### Running Locally

  * Clone this repo.
  * cd into it
  * ```bundle install```
  * ```rake db:create```
  * ```rake db:migrate ```
  * Add dataset to tmp folder
  * ```rake import_csv:all```
  * ```rails server```
  * ```Visit localhost:3000```

### Running the spec harness
  * Run ```rspec``` from the root directory