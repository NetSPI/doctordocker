class PerformanceController < ApplicationController

  def index
    @perf = current_user.performance
  end
end
