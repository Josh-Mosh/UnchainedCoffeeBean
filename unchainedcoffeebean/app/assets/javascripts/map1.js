 

var geocoder;
var map;
var infowindow = null;
function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(37.731145,-97.326092);
  var mapOptions = {
    
    zoom: 4,
    center: latlng
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  console.log(gon.shops)
  console.log(gon.addresses)

  function addMarkerArray()
    { 
        var infowindow = new google.maps.InfoWindow({
            content: "holding..."
          });

        for(var i = 0; i < gon.addresses.length; i++) 
        {
          var latitude = gon.addresses[i].latitude;
          var longitude = gon.addresses[i].longitude;
          var myLatlng = new google.maps.LatLng(latitude,longitude);
          
          marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            info: "<div class=info_window'><h5>"+gon.shops[i].name+"</h5>"+
                  "<p>"+gon.addresses[i].address+ "</p>"+
                  "<p>"+gon.shops[i].pricing +' - rating </p>'+
                  "<a href='http://www."+gon.shops[i].website+"' target='_blank'>"+gon.shops[i].website + "</p></div>",
            title: "marker"
            });
          google.maps.event.addListener(marker, 'mouseover', function() {
            infowindow.setContent(this.info);
            infowindow.open(map, this);
          });
        }
    }
    addMarkerArray();
}

function codeAddress() {
  alert("got here");
  var address = $('#address').val();
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      map.setZoom(7);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);


