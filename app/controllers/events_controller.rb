# app/controllers/events_controller.rb

class EventsController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @events = current_user.events
      @event = Event.new
    end
  
    def create
      @event = current_user.events.new(event_params)
  
      if @event.save
        redirect_to events_path, notice: 'イベントが作成されました。'
      else
        @events = current_user.events
        render :index
      end
    end
  
    private
  
    def event_params
      params.require(:event).permit(:title, :start_datetime)
    end
  end
  
  