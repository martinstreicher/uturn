class GamesController < ApplicationController
  inherit_resources

  custom_actions :resource => [:privatize, :publicize]

  belongs_to :room
end
