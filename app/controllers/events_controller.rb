# app/controllers/events_controller.rb

class EventsController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @events = current_user.events.all # すべてのイベントを取得する例
    
      # FullCalendar に表示する形式にデータを変換する
      @event_data = @events.map do |event|
        {
          title: event.title,
          start: event.start_datetime.rfc3339, # RFC3339 形式に変換
        }
      end
      # FullCalendar に渡すために JSON 形式に変換する
      @event_data_json = @event_data.to_json
    end
  
    def create
      @event = current_user.events.new(event_params)
  
      if @event.save
        redirect_to events_path, flash: { success: 'イベントが作成されました。' }
        render json: @event
      else
        @events = current_user.events
        render :index
      end
    end

    def get_upcoming_events
      start_date = Date.today
      end_date = start_date + 3.days
      upcoming_events = current_user.events.where(start_datetime: start_date.beginning_of_day..(end_date.end_of_day + 1.day))
  
      render json: upcoming_events, only: [:title, :start_datetime]
    end
  
    private
  
    def event_params
      params.require(:event).permit(:title, :start_datetime)
    end
  end
  
  