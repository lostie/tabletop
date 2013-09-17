class LobbiesController < ApplicationController
  include Tubesock::Hijack

  def chat
    hijack do |tubesock|

      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "lobby" do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |msg|
        Redis.new.publish "lobby", msg
      end

      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end
    end
  end
end
