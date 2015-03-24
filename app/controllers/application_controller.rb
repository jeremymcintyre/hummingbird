require "application_responder"

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  respond_to :html

  include ActionController::RespondWith
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
end
