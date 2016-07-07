
var map;
var markers = [];
var allPosition = [];
function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 14.45, lng: 120.98},
        zoom: 14
    });
    google.maps.event.addListener(map, 'click', function (event) {
        placeMarker(event.latLng);
    });
    function placeMarker(location) {
        var marker = new google.maps.Marker({
            position: location,
            map: map
        });
        markers.push(marker);
        latitude = marker.position.lat();
        longitude = marker.position.lng();
        var string = latitude + "&" + longitude;
        allPosition.push(string);
        document.getElementById("location").value = allPosition;
    }

}

function removeMarker() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
    allPosition = [];
}