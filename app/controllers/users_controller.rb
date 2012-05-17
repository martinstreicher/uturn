class UsersController < ApplicationController
  inherit_resources

  belongs_to :room, optional: true do
    belongs_to :game, optional: true
  end

  def show
    debugger
    x = 1
  end
end
