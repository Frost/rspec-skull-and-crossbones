# coding: utf-8
require 'rspec'

class SkullAndCrossbones
  ::RSpec::Core::Formatters.register self, :example_failed, :example_passed, :example_pending, :start_dump
  SLOW = 0.2 # seconds

  def initialize(output)
    @output = output
  end

  def example_failed(notification)
    @output.print "F"
  end

  def example_passed(notification)
    if notification.example.execution_result.run_time > SLOW
      @output.print "☠"
    else
      @output.print "."
    end
  end

  def example_pending(_notification)
    @output.print "*"
  end

  def start_dump(_notification)
    @output.puts
  end
end
