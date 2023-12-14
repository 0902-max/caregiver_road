# app/controllers/events_controller.rb

class EventsController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @events = current_user.events.where('start_datetime > ?', Time.now).order(:start_datetime).limit(4)
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

    def get_upcoming_events
      start_date = Date.today
      end_date = start_date + 3.days
      upcoming_events = Event.where(start_datetime: start_date.beginning_of_day..end_date.end_of_day)
  
      render json: upcoming_events, only: [:title, :start_datetime]
    end
  
    private
  
    def event_params
      params.require(:event).permit(:title, :start_datetime)
    end
  end
  
  