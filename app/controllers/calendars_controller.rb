class CalendarsController < ApplicationController
    def show
      service = Google::Apis::CalendarV3::CalendarService.new
      service.client_options.application_name = APPLICATION_NAME
      service.authorization = Rails.application.config.google_calendar_credentials
  
      # カレンダーのイベントを取得
      calendar_id = 'primary' # ユーザーのメインのカレンダー
      events = service.list_events(calendar_id)
  
      # イベントデータをデータベースに保存
      user_id = current_user.id  # ログインしているユーザーのIDを取得する（実際のコードに合わせて変更してください）
  
      events.items.each do |event|
        GoogleCalendarEvent.create(
          user_id: user_id,
          title: event.summary,
          description: event.description,
          start_datetime: event.start.date_time,
          end_datetime: event.end.date_time
        )
      end
  
      # データベースからイベントデータを取得
      @events = GoogleCalendarEvent.where(user_id: user_id)
      render 'learning_roadmaps/show'
    end
  end
  
  