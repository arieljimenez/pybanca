'use strict';

require('./index.html');

// Elm stuff
var Elm = require('../src/pybanca-front/Main.elm');
var mountNode = document.getElementById('main');
var app = Elm.Main.embed(mountNode);
