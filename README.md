# CFML Continious Integration Matrix Runner

This repository provides an easy way to test your CFML code on one or more CFML engines using *CommandBox*. It currently supports integration with Travis-CI and GitLab CI, adding support for additional CI environments should be pretty easy.

## Simple Example

Checkout the [cfmatrix-example-pass](https://github.com/foundeo/cfmatrix-example-pass) repository for a very simple example of how you use this.

## How does it work

The CI script will fire up a CFML engine specified by the `CFENGINE` environment variable matrix in your build script using `box server start cfengine=$CFENGINE` 

Next it makes a request to the `TEST_RUNNER_URI` that you specify, for example `/test/run.cfm` it will output the results of that run (this can be code that invokes a testbox runner, or simply a bunch of custom test cases). 

If the result of the `TEST_RUNNER_URI` is a non `200` HTTP status code the build will fail.

## How do I set it up for Travis-CI?

If you are using Travis CI simply copy the `[.travis.yml](https://github.com/foundeo/cfmatrix/blob/master/.travis.yml)` file from this repository and put it in the root of your repository. You can edit the `env` section to specify a different `TEST_RUNNER_URI` or you can remove `CFENGINE` from the test (this is a good idea, it will take a really long to time to run the tests).

### What does the Travis CI output look like?

[![Build Status](https://travis-ci.org/foundeo/cfmatrix.svg?branch=master)](https://travis-ci.org/foundeo/cfmatrix)

Click on the build status button above to see the test matrix results, you can see the results for each CFML engine that was run.

## How do I set i up for GitLab CI?

To use GitLab CI, simply copy the `[.gitlab-ci.yml](https://github.com/foundeo/cfmatrix/blob/master/.gitlab-ci.yml)` file into the root of your repository. You can add a test pipeline for each `CFENGINE` you want to use.



