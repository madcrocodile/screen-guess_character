# frozen_string_literal: true

RSpec.describe Screen::GuessCharacter do
  it "is a correct subclass" do
    expect { Screen::Base.subclasses_check!(1) }.not_to raise_error
  end

  describe "#payload_errors" do
    it "returns empty array if the payload is valid" do
      payload = Screen::GuessCharacter::EXAMPLE_PAYLOADS.first
      screen = Screen::GuessCharacter.new(payload:)
      expect(screen.payload_errors).to eq([])
    end

    it "returns array of errors if the payload is invalid" do
      payload = {}
      screen = Screen::GuessCharacter.new(payload:)
      expect(screen.payload_errors).to eq([
        "Did not contain a required property of 'characters'",
        "Did not contain a required property of 'color'"
      ])
    end
  end

  describe "#preprocess_payload" do
    it "processes the payload" do
      expect(
        Screen::GuessCharacter.new(
          payload: {
            "characters" => [
              {
                "value"    => "1",
                "position" => ["0", "1"]
              }
            ],
            "color" => "red"
          }
        ).preprocess_payload
      ).to eq(
         {
           "characters" => [
             {
               "value"    => "1",
               "position" => [0, 1]
             }
           ],
           "color" => "red"
         }
     )
    end
  end

  describe "#answer_errors" do
    it "returns errors if the answer is not provided" do
      expect(Screen::GuessCharacter.new(answer: "").answer_errors).to eq(["can't be blank"])
    end

    it "returns errors if it's more than one character" do
      expect(Screen::GuessCharacter.new(answer: "12").answer_errors).to eq(["can't be longer than 1 character"])
    end

    it "doesn't return errors if the answer exists" do
      expect(Screen::GuessCharacter.new(answer: "1").answer_errors).to eq([])
    end
  end
end
