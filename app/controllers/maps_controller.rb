class MapsController < ApplicationController
  include GeoKit::Geocoders
  include GeoKit::Mappable
  layout "start"
  
  def index
  
    loc = IpGeocoder.geocode(request.remote_ip)

    @map = GMap.new("map")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([50, 10],5)
    if loc.success
      @map.overlay_init GMarker.new([loc.lat, loc.lng],:title => "Hello!")
    end 
    flash[:notice] = loc
  end
  
  def search
    
    @map = Variable.new("map")
    #@search = Variable.new('mtgt_marker1')
    @locations = Geocoding::get(params[:search])
    if @locations.status == Geocoding::GEO_SUCCESS
      @latlng = GLatLng.new([@locations.first.latitude, @locations.first.longitude])
      @marker = GMarker.new(@latlng,:info_window => "<b>#{@locations.first.address}</b>", :id =>'marker1')
      #@marker.open_info_window_html(@locations.first.address)
      render :update do |page|

        page << @map.clear_overlays
        #@locations.each do |l|
          page << @map.setCenter(@latlng, 5)
          page << @map.addOverlay(@marker)
          page << @map.openInfoWindowHtml(@latlng, "<b>#{@locations.first.address}</b>")
        #end
        page.replace_html 'sidebar', :partial => 'results'
      end
      
    end
  end
end
