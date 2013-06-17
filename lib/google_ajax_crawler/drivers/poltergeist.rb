require "capybara"
require "capybara/dsl"
require "capybara/poltergeist"

module GoogleAjaxCrawler
  module Drivers
    class Poltergeist < Driver
      include Capybara::DSL

      def initialize *args
        super *args
        configure
      end

      def html
        content = super
        page.driver.browser.reset
        return content
      end  

      def default_page_loaded_test
        (page.evaluate_script('$.active') == 0)
      end

      protected

      def configure
        Capybara.run_server     = false
        Capybara.current_driver = :poltergeist
        Capybara.default_wait_time = options.timeout
      end
    end
  end
end