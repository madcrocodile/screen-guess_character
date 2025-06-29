require "spec_helper"

RSpec.describe Screen::GuessCharacter, type: :feature do
  let(:payload) {
    {
      characters: [
        { value: "1", position: [2, 3] },
        { value: "2", position: [1, 1] }
      ],
      color: "red"
    }
  }
  let(:screen) { Screen::GuessCharacter.new(payload:) }

  before :each do
    ScreenServer.set :screen, screen
  end

  it "clicks a digit" do
    visit "/"
    click_on "Play"
    div = page.find("div[id='Screen::GuessCharacter']")

    [1, 2].each do |digit|
      expect(div).to have_css("button.button-character", text: digit.to_s)
    end

    using_wait_time(11) do
      page.accept_alert "Response received" do
        page.find("button.button-character", text: "1").click
      end
    end

    expect(page).to have_current_path("/solution?answer=1")
  end
end
