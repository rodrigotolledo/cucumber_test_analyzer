#!/usr/bin/ruby -w

class CaptureOutput
	def capture_stdout(&block)
		original_stdout = $stdout
		$stdout = fake = StringIO.new
		begin
			yield
		ensure
			$stdout = original_stdout
		end
		fake.string
	end
end
