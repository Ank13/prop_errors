get '/' do
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  erb :new_event
end

post '/events/create' do
  p params
  @title = params[:title]
  @email = params[:email]
  @name = params[:name]
  if params[:date] != ""
    date = Date.strptime(params[:date], "%Y-%m-%d")
    @event = Event.new(title: @title, 
                       organizer_name: @name, 
                       organizer_email: @email,
                       date: date)
    if @event.save
      redirect '/'
    else
      @errors = @event.errors.full_messages
      erb :new_event
    end
  else
    @errors = ["Date can't be blank"]
    erb :new_event
  end
end
