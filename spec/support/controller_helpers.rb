module ControllerHelpers
  def sign_in_as(user = nil)
    user ||= instance_double('User', :current_user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end