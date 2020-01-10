describe Fastlane::Actions::LibPubAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The lib_pub plugin is working!")

      Fastlane::Actions::LibPubAction.run(nil)
    end
  end
end
