/*jslint browser: true*/
/*jslint node: true */
/*global $ */
'use strict';
var LIKING_FEATURE = {};
// all className toggling managed here
LIKING_FEATURE.styles = {
    setLikedStyle: function (elt) {
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
    isLiked: function (elt) {
        return elt.className === 'perfume__loveit loved';
    },
    setDefaultStyle: function (elt) {
        elt.innerHTML = '&#9825;';
        elt.className = 'perfume__loveit';
    },
    markLikedHeart: function (elt, likedPerfumes) {
        var id = elt.parentNode.id;
        if (likedPerfumes.indexOf(id) > -1) {
            LIKING_FEATURE.styles.setLikedStyle(elt);
        }
    }
};
LIKING_FEATURE.storedLikes = {
    get: function () {
        return JSON.parse(localStorage.getItem('LIKING_FEATURE:likedPerfumes'));
    },
    set: function (arr) {
        localStorage.setItem('LIKING_FEATURE:likedPerfumes', JSON.stringify(arr));
    }
};
LIKING_FEATURE.events = {
    mouseover: function (evt) {
        var elt = evt.target;
        // conditional toggle hover on
        if (!LIKING_FEATURE.styles.hasHover(elt) &&
                !LIKING_FEATURE.styles.isLiked(elt)) {
            LIKING_FEATURE.styles.setHoverStyle(elt);
        }
    },
    mouseout: function (evt) {
        var elt = evt.target;
        // conditional toggle hover off
        if (LIKING_FEATURE.styles.hasHover(elt)) {
            LIKING_FEATURE.styles.setDefaultStyle(elt);
        }
    },
    mousedown: function (evt) {
        // if perfume not yet on likedPerfumes list, add it
        // if perfume already on likedPerfumes list, remove it
        var id = evt.target.parentNode.id,
            perf = LIKING_FEATURE.storedLikes.get(),
            arr = [],
            index,
            elt = evt.target;
        if (perf) { arr = perf; }
        index = arr.indexOf(id);

        if (index === -1) {
            arr.push(id);
            LIKING_FEATURE.styles.setLikedStyle(elt);
        } else {
            arr.splice(index, 1);
            LIKING_FEATURE.styles.setHoverStyle(elt);
        }
        LIKING_FEATURE.storedLikes.set(arr);
    },
    addHandlersToHeart: function (elt) {
        elt.addEventListener('mouseover', this.mouseover);
        elt.addEventListener('mouseout', this.mouseout);
        elt.addEventListener('mousedown', this.mousedown);
    }
};
LIKING_FEATURE.update_DOM = function(perfumes, likedPerfumes) {
    var j,
        i,
        elt,
        childNodes,
        likedPerfumes = LIKING_FEATURE.storedLikes.get();
    for (j = 0; j < perfumes.length; j += 1) {
        childNodes = perfumes[j].childNodes;
        for (i = 0; i < childNodes.length; i += 1) {
            elt = childNodes[i];
            if (elt.className === 'perfume__loveit') {
                LIKING_FEATURE.events.addHandlersToHeart(elt);
                LIKING_FEATURE.styles.markLikedHeart(elt, likedPerfumes);
            }
        }
    }
};
$(document).on('page:change', function () {
    var perfumes = document.getElementsByClassName('perfume');
    if (perfumes.length > 0) {
        LIKING_FEATURE.update_DOM(perfumes);
    }
});
