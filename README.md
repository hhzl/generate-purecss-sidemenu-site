# generate-purecss-sidemenu-site

The aim of this repository is to show how a simple [static website](https://en.wikipedia.org/wiki/Static_web_page) generator may work in Smalltalk.

It is not meant as a ready made generator but rather as a demonstration how you can set up a simple custom made generator in a short time.

String concatenation and replacement of place holders with content string values are used.
The classes for the web pages inherit the boiler plate code from a template class. The code for the content is included in the code. An adaptation may pull the content from elsewhere.

The code is specific to the particular layout taken from https://purecss.io/layouts/side-menu/. That web code is [responsive](https://en.wikipedia.org/wiki/Responsive_web_design).


# Usage

The class

      StaticSiteGenerator3 example
   
implements the code which generates the result.
   
The classes ``StaticSiteGenerator0``, ``StaticSiteGenerator1`` and ``StaticSiteGenerator2`` show earlier stages of the development.     

# Demo
https://hhzl.github.io/generate-purecss-sidemenu-site/

# Notes

An approach using a Makefile http://cdaniels.net/2017-11-22_make-static-site.html. It makes use of [pandoc](http://pandoc.org/index.html).

A similar article but applying a Makefile to JavaScript: *http://www.olioapps.com/blog/the-lost-art-of-the-makefile/*

An approach to do a "light static site generator" using ``node`` and ``npm``: *https://github.com/BrandonRomano/static-lite*
