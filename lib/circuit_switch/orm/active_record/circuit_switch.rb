require 'active_record'

module CircuitSwitch
  class CircuitSwitch < ::ActiveRecord::Base
    validates :key, uniqueness: true

    after_initialize do |switch|
      switch.key ||= switch.caller
    end

    def assign(run_limit_count: nil, report_limit_count: nil)
      self.run_limit_count = run_limit_count if run_limit_count
      self.report_limit_count = report_limit_count if report_limit_count
      self
    end

    def reached_run_limit?(new_value)
      if new_value
        run_count >= new_value
      else
        run_count >= run_limit_count
      end
    end

    def reached_report_limit?(new_value)
      if new_value
        report_count >= new_value
      else
        report_count >= report_limit_count
      end
    end

    def increment_run_count!
      with_writable { save! && increment!(:run_count, touch: true) }
    end

    def increment_report_count!
      with_writable { save! && increment!(:report_count, touch: true) }
    end

    def message
      process = key == caller ? 'Watching process' : "Process for '#{key}'"
      "#{process} is called for #{report_count}th. Report until for #{report_limit_count}th."
    end

    private

    def with_writable
      if self.class.const_defined?(:ApplicationRecord) && ApplicationRecord.respond_to?(:with_writable)
        ApplicationRecord.with_writable { yield }
      else
        yield
      end
    end
  end
end
