require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

root = File.expand_path("..", __FILE__)

brew_facts = {"chemex" =>
              ['Great for light roasts',
               'Makes a bright, clean cup of coffee',
               'Helps nuanced flavors shine through'
              ],
              "frenchpress" =>
              ['Great for dark roasts',
               'Makes a brew with a rich taste and texture',
               'Allows the oils of the coffee to shine through'
              ]
             }



get "/" do
  @title = "Coffee App"

  @coffee_pics = Dir.glob(root + "/public/images/coffee_pictures/*").map do |path|
    File.basename(path)
  end

  erb :index, layout: :layout
end

get "/:brewtype" do
  brewtype = params[:brewtype]
  @brew_facts = brew_facts[brewtype]
  @instructions = File.readlines("data/#{brewtype}.txt")

  brewtype == "chemex" ? @method = "Chemex" : @method = "French Press"

  erb :brew_type, layout: :layout
end
