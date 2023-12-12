require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'myapp'.freeze
CREDENTIALS_PATH = Rails.root.join('client_secret_1053632602051-posra24vaup0h1fvvp2t6qanptf00si3.apps.googleusercontent.com.json').to_s.freeze  # ルートディレクトリに配置した場合
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

credentials = Google::Auth::UserAuthorizer.new(
  Google::Auth::ClientId.from_file(CREDENTIALS_PATH),
  SCOPE,
  token_store: Google::Auth::Stores::FileTokenStore.new(file: Rails.root.join('path/to/token.yaml').to_s)
)


Rails.application.config.after_initialize do
    Rails.application.config.google_calendar_credentials = credentials
end
