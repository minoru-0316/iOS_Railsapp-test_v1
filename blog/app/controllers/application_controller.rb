class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken

        # before_action :authenticate_user!

        # skip_before_action :verify_authenticity_token, if: :devise_controller?
        # APIではCSRFチェックをしない → 
        # だが、skip_before_actionでArgumentErrorが出るので、コメントアウトして以下を追加
        
        skip_before_action :verify_authenticity_token, raise: false
        # ログイン・サインアップ共に正常に動作

end
