require "spec_helper"

RSpec.describe Screen::GuessCharacter, type: :feature do
  let(:payload) {
    {
      characters: [
        { value: "1", position: [0, 25] },
        { value: "2", position: [25, 50] }
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
      expect(div).to have_css("span.text-3xl.cursor-pointer", text: digit.to_s)
    end

    # Wait for 10 seconds - TODO # [6XvFWWG4fWH7JP4G]

    page.accept_alert "Response received" do
      page.find("span.text-3xl.cursor-pointer", text: "1").click
    end

    expect(page).to have_current_path("/solution?answer=1")
  end
end
