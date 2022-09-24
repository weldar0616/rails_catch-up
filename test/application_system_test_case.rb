require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400], options: {
    browser: :remote,
    url: ENV.fetch('SELENIUM_REMOTE_URL'),
    desired_capabilities: :chrome
  }
end
