Rails.application.configure do
  config.active_job.queue_adapter = :sucker_punch
end

# SuckerPunch.config do
#   queue name: :do_the_thing, worker: MessageQueueHandler, workers: 4
# end


MessageQueueHandler.new.async.perform

# SuckerPunch::Queue[:do_the_thing].async.perform
