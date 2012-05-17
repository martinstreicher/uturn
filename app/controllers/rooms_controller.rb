class RoomsController < ApplicationController
  inherit_resources

  custom_actions :resource => [:privatize, :publicize]
end
