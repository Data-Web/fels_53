module ActivityLogs
  def create_activity user_id, target_id, status
    Activity.create! user_id: user_id, target_id: target_id, status: status
  end
end