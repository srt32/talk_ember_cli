class Api::SessionsController < Clearance::SessionsController
  def create
    @user = authenticate(session_params)

    sign_in(@user) do |status|
      if status.success?
        render(
          json: { users: [{ id: 1, email: @user.email, token: @user.token }] },
          location: false
        )
      else
        render(nothing: true, status: :unauthorized)
      end
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
    params[:session] = params["session"]
    params
  end
end
