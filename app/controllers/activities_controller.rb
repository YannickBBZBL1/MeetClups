class ActivitiesController < ApplicationController
  def index
    authorize :activity, :index?   # <-- use a symbol here that matches your policy name (ActivityPolicy)
    @versions = policy_scope(PaperTrail::Version, policy_scope_class: ActivityPolicy::Scope)
                  .order(created_at: :desc).limit(50)
  end
end
