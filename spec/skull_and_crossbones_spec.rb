# coding: utf-8
require "skull_and_crossbones"

module FormatterSupport
  def new_example(metadata = {})
    metadata = metadata.dup
    result = RSpec::Core::Example::ExecutionResult.new
    result.started_at = Time.now
    finished_at = metadata.delete(:finished_at) { Time.now }
    result.record_finished(metadata.delete(:status) { :passed }, finished_at)
    instance_double(RSpec::Core::Example,
                    description: "Example",
                    full_description: "Example",
                    execution_result: result,
                    metadata: metadata)
  end

  def start_notification
    RSpec::Core::Notifications::StartNotification.new(2)
  end

  def example_notification(metadata = {})
    RSpec::Core::Notifications::ExampleNotification.for new_example(metadata)
  end
end

RSpec.describe SkullAndCrossbones do
  include FormatterSupport

  let(:output) { StringIO.new }
  let(:config) do
    config = RSpec::Core::Configuration.new
    config.output_stream = output
    config
  end

  let(:formatter) do
    config.add_formatter(described_class)
    config.formatters.first
  end

  let(:reporter) do
    formatter
    config.reporter
  end

  before(:each) do
    reporter.notify :start, start_notification
  end

  it "prints . for fast, passing examples" do
    reporter.notify :example_passed, example_notification

    expect(output.string).to eq(".")
  end

  it "prints ☠ for slow but passing examples" do
    reporter.notify :example_passed,
                    example_notification(finished_at: Time.now + 100)

    expect(output.string).to eq("☠")
  end

  it "prints an F for failing examples" do
    reporter.notify :example_failed, example_notification(status: :failed)

    expect(output.string).to eq("F")
  end

  it "prints a * for pending examples" do
    reporter.notify :example_pending, example_notification

    expect(output.string).to eq("*")
  end
end
