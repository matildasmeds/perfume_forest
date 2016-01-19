/*jslint browser: true*/
/*jslint node: true */
/*global $ */
'use strict';
var PERFUMEFOREST = {};
// all className toggling managed here
PERFUMEFOREST.styles = {
    setLovedStyle: function (elt) {
        elt.innerHTML = '&hearts;';
        elt.className = 'perfume__loveit loved';
    },
    setHoverStyle: function (elt) {
        elt.innerHTML = '&#9825;';
        elt.className = 'perfume__loveit hover';
    },
    hasHover: function (elt) {
        return elt.className === 'perfume__loveit hover';
    },
    isLoved: function (elt) {
        return elt.className === 'perfume__loveit loved';
    },
    setDefaultStyle: function (elt) {
        elt.innerHTML = '&#9825;';
        elt.className = 'perfume__loveit';
    },
    markLovedHeart: function (elt, likedPerfumes) {
        var id = elt.parentNode.id;
        if (likedPerfumes.indexOf(id) > -1) {
            PERFUMEFOREST.styles.setLovedStyle(elt);
        }
    }
};
PERFUMEFOREST.storedLikes = {
    get: function () {
        return JSON.parse(localStorage.getItem('PERFUMEFOREST:likedPerfumes'));
    },
    set: function (arr) {
        localStorage.setItem('PERFUMEFOREST:likedPerfumes', JSON.stringify(arr));
    }
};
PERFUMEFOREST.events = {
    mouseover: function (evt) {
        var elt = evt.target;
        // conditional toggle hover on
        if (!PERFUMEFOREST.styles.hasHover(elt) &&
                !PERFUMEFOREST.styles.isLoved(elt)) {
            PERFUMEFOREST.styles.setHoverStyle(elt);
        }
    },
    mouseout: function (evt) {
        var elt = evt.target;
        // conditional toggle hover off
        if (PERFUMEFOREST.styles.hasHover(elt)) {
            PERFUMEFOREST.styles.setDefaultStyle(elt);
        }
    },
    mousedown: function (evt) {
        // if perfume not yet on likedPerfumes list, add it
        // if perfume already on likedPerfumes list, remove it
        var id = evt.target.parentNode.id,
            perf = PERFUMEFOREST.storedLikes.get(),
            arr = [],
            index,
            elt = evt.target;
        if (perf) { arr = perf; }
        index = arr.indexOf(id);

        if (index === -1) {
            arr.push(id);
            PERFUMEFOREST.styles.setLovedStyle(elt);
        } else {
            arr.splice(index, 1);
            PERFUMEFOREST.styles.setHoverStyle(elt);
        }
        PERFUMEFOREST.storedLikes.set(arr);
    },
    addHandlersToHeart: function (elt) {
        elt.addEventListener('mouseover', this.mouseover);
        elt.addEventListener('mouseout', this.mouseout);
        elt.addEventListener('mousedown', this.mousedown);
    }
};
$(document).on('page:change', function () {
    // add handlers to the hearts
    // ideally this method added only to those views where it matters!!!
    var perfumes = document.getElementsByClassName('perfume'),
        j,
        i,
        elt,
        childNodes,
        likedPerfumes = PERFUMEFOREST.storedLikes.get();
    for (j = 0; j < perfumes.length; j += 1) {
        childNodes = perfumes[j].childNodes;
        for (i = 0; i < childNodes.length; i += 1) {
            elt = childNodes[i];
            if (elt.className === 'perfume__loveit') {
                PERFUMEFOREST.events.addHandlersToHeart(elt);
                PERFUMEFOREST.styles.markLovedHeart(elt, likedPerfumes);
            }
        }
    }
});
