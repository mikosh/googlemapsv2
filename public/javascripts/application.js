// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function focusPoint(id){
if (currentFocus) {
Element.removeClassName("sidebar-item-"+currentFocus,"current");
}
Element.addClassName("sidebar-item-"+id,"current");
markerHash[id].marker.openInfoWindowHtml(markerHash[id].address);
currentFocus=id;
}