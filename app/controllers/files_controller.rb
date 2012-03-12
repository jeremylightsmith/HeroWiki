class FilesController < ApplicationController
  def show                          
    path = File.join("/HSD/online", (params[:id] || File.join(params[:path])))
    path += ".#{params[:format]}"

    content = DROPBOX.get_file(path)
    # response.headers['Cache-Control'] = 'public, max-age=60'
    case params[:format]
    when "jpg", "pdf", "png", "txt"
      send_data content, :disposition => "inline", :type => mime_type_for(params[:format])
    else
      send_data content, :type => mime_type_for(params[:format])
    end
  # rescue Dropbox::UnsuccessfulResponseError, Errno::ENOENT
  #   raise ActionController::RoutingError.new('Not Found')
  end
    
  protected
  
  def mime_type_for(format)
    case format
    when "txt" then "text/plain"
    when "png", "jpg" then "image/#{format}"
    when "pdf" then "application/pdf"
    else
      "application/binary"
    end
  end
end
